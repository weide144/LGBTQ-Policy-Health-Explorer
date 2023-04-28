#Final Project Functions

#Barplot
makeBarPlot <- function(svydata, var1, var2){
  
  var1 <- sym(var1)
  var2 <- sym(var2)
  
  bar_Values <- svyby(formula = as.formula(paste0("~", var1)),
                      design = svydata,
                      by = as.formula(paste0("~", var2)),
                      FUN = svymean,
                      na.rm = TRUE)
  
  ggplot(data = bar_Values, mapping = aes(x = .data[[var2]], y = .data[[var1]])) +
    geom_col() +
    geom_errorbar(aes(x = .data[[var2]], ymin = (.data[[var1]] - 1.96 * .data[["se"]]), ymax = (.data[[var1]] + 1.96 * .data[["se"]])), width = 0.5, linewidth = 0.74, position = position_dodge(0.3)) +
    theme_classic() +
    ggtitle("Distribution Plot")

}

makeMap <- function(data_sf, var, rev = FALSE){
  var <- sym(var)
  
  hover_text <- paste(print(var))
  
  if (rev){
    map <- ggplot() +
      geom_sf(data = data_sf, aes(fill = !!var, text = hover_text)) +
      scale_fill_gradient2(low = "blue", high = "red") +
      theme_void()
    
  } else {
    map <- ggplot() +
      geom_sf(data = data_sf, aes(fill = !!var, text = hover_text)) +
      scale_fill_gradient2(low = "red", high = "blue") +
      theme_void()
  }
  
  map <- map %>% ggplotly() %>% 
    layout(hovermode = "closest", 
           hoverlabel = list(bgcolor = "white", font = list(size = 12)),
           hovertemplate = "%{text}")
  
  return(map)
}

  
#Distribution Plot
makeDistPlot<- function(svydata, var1, var2){
  
  var1 <- sym(var1)
  var2 <- sym(var2)
  
  bar_Values <- svyby(formula = as.formula(paste0("~", var1)),
                      design = svydata,
                      by = as.formula(paste0("~", var2)),
                      FUN = svymean,
                      na.rm = TRUE)
  
  column_names <- names(bar_Values)
  pivot_columns <- column_names[grepl(as_string(var1), column_names) & !grepl("se\\.", column_names)]
  bar_Values_long <- pivot_longer(bar_Values, cols = pivot_columns,
                                  names_to = paste(var1), values_to = "percent")
  
  # Remove "CSRVPAIN" from the variable name using stringr
 bar_Values_long <- bar_Values_long %>%
   mutate(!!var1 := str_remove(!!var1, paste0("'", var1, "'")))
  
  
 ggplot(bar_Values_long, aes(x = .data[[var1]], y = percent, fill = .data[[var2]])) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(as.formula(paste0("~", var2))) +
   labs(x = as_label(var1), y = "Percent") +
   theme_classic() +
   ggtitle("State Prediction Plot")

  
}

