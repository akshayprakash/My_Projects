library(googleVis)
library(shiny)
library(WDI)
library(choroplethr)
library(choroplethrMaps)
library(BH)

x = WDIsearch(string = "EN", field = "indicator")[27:89,1]
y = setNames(x, as.character(WDIsearch(string = "EN", field = "indicator")[27:89,2]))

r1 = c('world','019','150','002','009','142')
r2 = setNames(r1, c('World','Americas','Europe','Africa','Australia & Oceania','Asia'))

shinyUI(pageWithSidebar(
  
  headerPanel("Climate Change Factors"),
  
  sidebarPanel(
    selectInput("ind", "Select Indicator", 
                choices = y, selected = "EN.ATM.CO2E.PC"),
    sliderInput("year", "Select Year:", 1960, min = 1960, max = 2014, step = 1),
    numericInput("k","Select number of categories:", 5, min = 2, max = 9),
    selectInput("r", "Select the Continent:", 
                choices = r2, selected = as.character("001"))),
  
  mainPanel(
    h2("Classification of countries based on Indicator Values",align="center"),
    p("Explore this interactive app to see the classification of countries into different categories based on indicator values and the desired degrees of detail",align="center", style = "color:black ; font-family: 'Georgia'; font-size:130%"),
    p(strong("Select indicator"), " that you would like to explore.",
      br(),strong("Select Year"),"for which you want to explore the indicator.",
      br(),strong("Select number of categories"),"you want to classify the countries into (range: 2-9) based on indicator values.",
      br(),strong("Note:",style = "color:black ; font-family: 'Courier'; font-size:120%"),em("Black color denotes data was not collected for that year and indicator.", style = "color:black ; font-family: 'Courier'"), style = "color:black ; font-family: 'Helvetica'; font-size:110%"),
      br(),strong(textOutput("text1"),align="center"),
    plotOutput("wdi"),
    h2("Continent/Country-wise indicator values",align="center"),
    p("Explore the indicator based on selected continent with the value for each country.",align="center", style = "color:black ; font-family: 'Georgia'; font-size:130%"),
    p(strong("Select the Continent"),"to zoom in the map below to explore the indicator.",
      br(),strong("Note:",style = "color:black ; font-family: 'Courier'; font-size:120%"),em("Green color denotes data was not collected for that year and indicator.", style = "color:black ; font-family: 'Courier'"),style = "color:black ; font-family: 'Helvetica'; font-size:110%"),
    htmlOutput("map"),
    em(textOutput("text2")),
    em(textOutput("text3")),
    br(),p(strong("Credits:"),"Vadym Barda, Akshay Prakash, Ganesh Kumar", style = "color:black ; font-family: 'Helvetica'; font-size:110%")
  )
))