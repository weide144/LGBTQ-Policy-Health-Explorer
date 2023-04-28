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

source("final_project_functions.R")

### Read in the data ###
SGM <- read_csv("data/CancerSGM_Sample.csv") 

#Survey-weighted dataset ###
options(survey.lonely.psu = "adjust")
svySGM= svydesign(data = SGM, id = ~1, strata = ~STSTR, weights = ~FINALWT)

### Define a few sets of variables which might be useful
all_vars <- names(SGM)
id_vars <- "X"
state_id <- "STATE"
demographic_vars <- c("SXORIENT","RACE","EDUCATION","AGE","GENDER","SEX")
outcome_vars <- c("MENT14D","RFDRHV7","ISSMOKER","HPVADC4","CSRVDEIN","CSRVTRN","CSRVPAIN")
state_vars <- c("RACISMINDEX","RACISMZED","MAPAVGZED")


# Define UI for application that draws a histogram
ui <- navbarPage(
  
  # Application title
  title = "Sexual and Gender Minorities Explorer",
  
  # Define three tabs
  tabPanel("Data Explorer",
           #Add Interactive Table of SGM Data
           DTOutput("data_table")
  ),
  
  tabPanel("Data Visualization",
           sidebarLayout(
             sidebarPanel(
               selectInput("demographic_vars",
                           "Demographic Variables: X",
                           choices = demographic_vars)
             ),
             mainPanel(
               plotlyOutput("physioPlot")
             )
           )
           # Add UI components for second tab here
  ),
  
  tabPanel("State-Level Factors",
           # Add UI components for third tab here
  )
  
)


# Define server logic required to draw a histogram
server <- function(input, output) {
  
  #Create Interactive Table of SGM Data
  output$data_table <- renderDT({
    datatable(SGM, options = list(pageLenght = 10))
  })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
