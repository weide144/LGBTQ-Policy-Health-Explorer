# Final-Project Proposal: PUBH 7462

#### Author:

Ben Weideman. I'm doing this project by myself.

#### Product Title:

Exploring LGBTQ Policy and Cancer Outcomes

#### Product:

Shiny App

#### Product Purpose:

I am currently a member of study team working on an NIH R01 grant investigating cancer in Sexual and Gender Minorities (SGM). As part of my masters thesis, I have been exploring the relationship between state-level LGBTQ policy and cancer outcomes in SGM communities. I would like to build an interactive app that allows for better exploration of the data sets and these relationships. My hope is that exploratory analysis will offer directions for new research, and I plan to make it available to my entire NIH study team as another resource.

#### Data:

I am using publicly available data from the [Behavioral Risk Factor Surveillance System (BRFSS)](https://www.google.com/search?q=brfss+data&oq=brfss&aqs=edge.4.69i59l4j0i512l4j69i60.5098j0j4&sourceid=chrome&ie=UTF-8), a survey administered by state health departments in the United States. My data set spans 5 BRFSS years from 2017-2021. I also use a data set from the [Movement Advanced Project (MAP)](https://www.lgbtmap.org/) I am also considering in pulling in state level census data.

#### Product Features:

1.  An interactive map of the United States shaded with colors scaled according to the MAP Policy score for the state. Hovering over each state will display information about the number BRFSS SGM respondents from that state, and some relevant demographic information about the population. I am interested in additionally pulling in state census data to display interesting state data (i.e. avg. household income) when hovering. This will answer how the policy scores are distributed by state and communicate the volume of respondents by state in an intuitive fashion.

2.  A table for exploring the data to help with understanding the variables.

3.  An interactive scatterplot that allows for plotting and exploring multiple BRFSS variables pertaining to cancer in SGM.

4.  a Bar plot that compares dichotomous response variables in the data set against MAP Policy Z-score and evaluates if there are statistically significant differences using a two-sided t-test.

#### Interactivity:

I want the end user to be able to interact with the map of the United States to better understand differences in LGBTQ policy by state and how that interfaces with the BRFSS data. I want the ability to select and plot variables in the data set in order do exploratory analysis of the data.
