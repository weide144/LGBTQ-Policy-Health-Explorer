# Final-Project Proposal: PUBH 7462

#### Author:

Ben Weideman. I'm doing this project by myself.

#### Product Title:

Exploring LGBTQ Policy and Cancer Outcomes

#### Product:

Shiny App

#### Product Purpose:

I am currently a member of study team working on an NIH R01 grant investigating cancer in Sexual and Gender Minorities (SGM). As part of my masters thesis, I have been exploring the relationship between state-level LGBTQ policy and cancer outcomes in SGM communities. The purpose of my app is to help me explore the data and to evaluate the impact of various state-level factors for health outcomes in my sample. 

#### Data:

I am using publicly available data from the [Behavioral Risk Factor Surveillance System (BRFSS)](https://www.google.com/search?q=brfss+data&oq=brfss&aqs=edge.4.69i59l4j0i512l4j69i60.5098j0j4&sourceid=chrome&ie=UTF-8), a survey administered by state health departments in the United States. My data set spans 5 BRFSS years from 2017-2021 and is contained in the "CancerSGM_Sample.csv" file in the data folder. I also use a data set from the [Movement Advanced Project (MAP)](https://www.lgbtmap.org/) to create a Policy Z-Score called 'MAPAVGZED.' I also include other state level variables from the U.S census and a measure of Structural Racism 'RACISMZED' all of which are include in the "state_data.csv" file in the data folder. These data sets are joined for use in the app.


#### Availability:

I believe that my data set is too big to publish to shinyapps.io and I was encountering a signal kill error. You can run my app by cloning my github. All of the data is publicly available so sharing it is not a concern.


#### Product Features:

1.  Tab 1 includes an interactive table of the joined data files. Each line indicates a LGBTQ individual who responded to the survey and then relevant state-level variables joined on the STATE variable.

2. Two interactive maps of the United States shaded with colors scaled according to the State-evel variable selected. Hovering over a state displays the corresponding state value for the input variable. I chose to use two maps so it would be easier to compare trends between state variables. For example, doing this I found that some states with really protective LGBTQ policy (i.e. Minnesota) also have really high levels of structural racism. These trends can help guide future research questions.


3.  Two plots are in the third tab. The first plot shows the distribution of categorical outcome variables stratified by other variables such as demographics. The second is a bar plot that displays relevant outcome variables on the x-axis (i.e MENT14D "poor mental health days") and then a state level predictor on the y-axis (i.e Average MAPAVGZED, my LGBTQ policy variable). Both plot use survey weighted design from the {survey} package in R.

#### Interactivity:

You can interact with each tab, exploring the table, selecting state level variables to view on the maps in tab 2, and selecting which variables to plot in tab 3.

#### Programming Challenges:

The biggest challenge was actually generating the plots because the survey weighted design made it more difficult to manipulate the data. That took a lot of testing. Additionally, it was tricky to get the maps to display well, and I'm still not satifisfied with their aesthetics. There's lots I could probbly do to make the app more visually pleasing.

#### Division of Labor

I worked alone and so coded everything myself.

#### Future Work:

I would like to continue working on the maps so that they show additional information about the total number of BRFSS reponsdents and other information relevant information summarized in the hover bubble. I would also like to make the maps look prettier and allow for the end user to select the color scheme.

I would love to figure out how to allow the end user to select a variable from the census and then query the census with tidycensus to join that data into the dataset. Ultimately, I want greater flexibility for selecting and visualizing other state-level variables that might be associated with my primary predictor (MAPAVGZED) and the various health outcomes of interest.
