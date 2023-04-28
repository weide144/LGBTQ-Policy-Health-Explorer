US.bbox <- c(left = -125, bottom = 25, right = -67, top = 49)

US_base.map <- get_map(
  location = US.bbox,
  source   = "stamen",
  maptype  = "terrain",
  crop = TRUE
)

# Download state shapefile
us_states <- map("state", fill=TRUE, col="transparent", plot=FALSE)
us_states_sf <- st_as_sf(us_states)


#Join state data to shape file
state_data$STATE <- tolower(state_data$STATE)

us_states_sf <- left_join(us_states_sf, state_data, by = c("ID" = "STATE"))

#CreateMap
ggplot() +
  geom_sf(data = us_states_sf, aes(fill = MAPAVGZED)) +
  scale_fill_gradient(low = "red", high = "blue") +
  theme_void()