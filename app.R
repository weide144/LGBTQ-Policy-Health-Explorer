#Shiny App for Final Project

library(shiny)
library(tidyverse)
library(knitr)
library(plotly)
library(tidycensus)
library(osmdata)
library(ggmap)
library(sf)
library(DT)
library(survey)
library(rlang)
library(viridis)
library(maps)
library(rlang)

source("final_project_functions.R")

### Read in the data ###
SGM_Sample <- read_csv("data/CancerSGM_Sample.csv")
state_data <- read_csv(("data/state_data.csv"))

# Create US shapefile and join to state_data
us_states <- map("state", fill=TRUE, col="transparent", plot=FALSE)
us_states_sf <- st_as_sf(us_states)
SGM <- left_join(SGM_Sample, state_data, by = c("STATE" = "STATE"))
state_data$STATE <- tolower(state_data$STATE)
us_states_sf <- left_join(us_states_sf, state_data, by = c("ID" = "STATE"))

###Survey Weighted Data###
options(survey.lonely.psu = "adjust")
svySGM = svydesign(data = SGM, id = ~1, strata = ~STSTR, weights = ~FINALWT)

### Define a few sets of variables which might be useful
all_vars <- names(SGM)
id_vars <- "X"
state_id <- "STATE"
demographic_vars <- c("SXORIENT","RACE","EDUCATION","AGE","GENDER","SEX")
dist_vars <- c("MENT14D","RFDRHV7","ISSMOKER","HPVADC4","CSRVDEIN","CSRVTRN","CSRVPAIN","SXORIENT","RACE","EDUCATION","AGE","GENDER","SEX")
outcome_vars <- c("MENT14D","RFDRHV7","ISSMOKER","HPVADC4","CSRVDEIN","CSRVTRN","CSRVPAIN")
state_vars <- c("RACISMZED","MAPAVGZED","STATE_PERC_HOUSING_CHANGE","STATE_DIVERSITY_INDEX","STATE_PERC_POP_OVER_18","STATE_POPULATION","STATE_PERC_POVERTY")

# Define UI for application that draws a histogram
ui <- navbarPage(
  
  # Application title
  title = "LGBTQ Policy & Health Explorer",
  
  # Include the CSS file in the head of the document
  tags$head(
    tags$style(HTML("body { background-color: #ADD8E6; }"))
  ),
  
  # Define three tabs
  tabPanel("Data Explorer",
           #Add Interactive Table of SGM Data
           DTOutput("data_table")
  ),
  
  tabPanel("State-Level Factors",
           # Add UI components for third tab here
           sidebarLayout(
             sidebarPanel(
               selectInput("map_color1",
                           "MAP 1",
                           choices = state_vars),
               checkboxInput("rev_map1", "Reverse Colors"),
               selectInput("map_color2",
                           "Map 2",
                           choices = state_vars),
               checkboxInput("rev_map2", "Reverse Colors")
             ),
             mainPanel(
               plotlyOutput("map1"),
               plotlyOutput("map2")
             )
           )
  ),
  
  tabPanel("Data Visualization",
           sidebarLayout(
             sidebarPanel(
               h4("Distribution Plot"),
               selectInput("dist_vars",
                           "Pick a Distribution Variable:",
                           choices = dist_vars),
               selectInput("demographic_vars",
                           "Stratification Variable:",
                           choices = demographic_vars),
               h4("State Prediction Plot"),
               selectInput("state_vars",
                           "State-Level Predictor:",
                           choices = state_vars),
               selectInput("outcome_vars",
                           "Outcome Variable:",
                           choices = outcome_vars)
             ),
             mainPanel(
               plotOutput("dist_plot"),
               plotOutput("barplot")
             )
           )
  )
  
  
)


# Define server logic required to draw a histogram
server <- function(input, output) {
  
  #Create Interactive Table of SGM Data
  output$data_table <- renderDT({
    datatable(SGM, options = list(pageLength = 10))
  })
  
  #Create DistPlot
  output$dist_plot <- renderPlot({
    # generate bins based on input$bins from ui.R
    svySGM %>% makeDistPlot(input$dist_vars, input$demographic_vars)
  })
  
  #Create BarPlot
  output$barplot <- renderPlot({
    # generate bins based on input$bins from ui.R
    svySGM %>% makeBarPlot(input$state_vars, input$outcome_vars)
  })
  
  #Create Map1
  output$map1 <- renderPlotly({
     us_states_sf %>% makeMap(input$map_color1, rev = input$rev_map1)
  })
  
  #Create Map2
  output$map2 <- renderPlotly({
    us_states_sf %>% makeMap(input$map_color2, rev = input$rev_map2)
  })
  
    
}

# Run the application 
shinyApp(ui = ui, server = server)
