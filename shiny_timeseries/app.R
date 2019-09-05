# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(mizer)
require(tidyverse)

# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Exploring Time Series"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
        sliderInput("r_max", "Rmax scalar:", min = 0.01, max = 5, value = 1,
                    step = 0.1),
     
        sliderInput("eRepro", "Reproductive Efficiency:", min = 0.0001, max = 1, value = 1,
                    step = 0.01),
        sliderInput("kappa", "Plankton Multiplier:", min = 0.1, max = 10, value = 1,
                     step = 0.1),
        submitButton("Submit")
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
  output$distPlot <- renderPlot({
  relative_effort<-readRDS("relative_effort.RDS")
  params <- readRDS("params.RDS")
	# run model
  #sim2 <- project(params, effort=relative_effort, dt = 0.1, t_save = 1,initial_n = sim@n[200,,],initial_n_pp = 	sim@n_pp[200,])
  
	sim2 <- project(params, effort=relative_effort, dt = 0.1, t_save = 1)
  plotYield(sim2)
#   # output modelled yields and reshape for plotting
# 	y <- getYield(sim2)
# 	y <- reshape2::melt(y)
# 
# 	#read in obsy yield values
# 	obsy <- read.csv("data/obslandings.csv")[,-1]
# 
# 	# plot these
# 	ggplot(y) + geom_line(data=y, aes(x = time, y = log(value), 
#             colour = sp)) +
#     geom_point(data=obsy,aes(x = time, y = log(value), 
#             colour = sp),size=0.1) +
#     facet_wrap(~sp) +
#     scale_y_continuous(name = "log Yield [g/year]")  +
#     scale_colour_manual(values = sim@params@linecolour) +
#     xlim(1957, 2011)


   })
}

# Run the application 
shinyApp(ui = ui, server = server)

