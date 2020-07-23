#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(ggplot2)
library(shiny)
library(mizer)

#  https://sizespectrum.org/mizer/

# Define UI for application that draws a plot
shinyUI(fluidPage(
  
  # Application title
  titlePanel("North Sea Model Example"),
  
  fluidRow(
    column(4, wellPanel(
       sliderInput("kappa", "log10 Resource Carrying Capacity:", min = 2, max = 12, value = 12,
                   step = 1),
       sliderInput("Rmax", "log10 Maximum Recruitment:", min = 4, max = 12, value = 12,
                   step = 1),
       sliderInput("erepro", "log10 Reproductive Efficiency:", min = -8, max = 1, value = 1,
                   step = 1)
       #textInput("text", "Text:"
       #textInput("text", "Text:", "text here"),
    #  submitButton("Submit")
    )),
    column(6,
           plotOutput("distPlot", width = 600, height = 600)
    ))
  
    
  )
)



