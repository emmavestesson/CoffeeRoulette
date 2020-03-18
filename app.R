#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(praise)
library(glue)
df <- read_csv(here::here('names.csv'))

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Coffee roulette"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            radioButtons("group_size", "Group size", 1:3, inline = TRUE,
                         width = NULL)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           uiOutput(
               outputId = "samples_ui"
           ),
           textOutput('email')
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  output$samples_ui = renderUI({
        nTabs <- input$group_size
        start_date <- lubridate::today()-as.numeric(input$group_size)
        myTabs <- imap(1:input$group_size, ~tabPanel(title=paste('tab', .y), 
                                                         selectInput(inputId=paste0('Team',.y, ''), 
                                                                   paste0('Team ',.y), choices = unique(df$team),
                                                                   selected = 'IAU')))
                                                     do.call(tabsetPanel, myTabs)
    })
  outputOptions(output, "samples_ui", suspendWhenHidden = FALSE)  
  

#
# first_person <-  reactive(sample_n(team1(),1) %>%
#     pull(name))

output$email <- renderText({
team1 <- df %>%
    filter(team==input$Team1)
 
first_person <-  sample_n(team1,1) %>%
    pull(name)
if (input$group_size==1){
glue('Dear ',first_person, '\n',  praise('${EXCLAMATION}! You are my ${adjective} coffee buddy!'))
} else if (input$group_size==2){
team2 <- df %>%
        filter(team==input$Team2)
    
second_person <-  sample_n(team2,1) %>%
        pull(name)    
glue('Dear ',first_person, ' and ', second_person,  '\n',  praise('${EXCLAMATION}! You are my ${adjective} coffee buddies!'))
    
} else {
    
    team2 <- df %>%
        filter(team==input$Team2)
    
    second_person <-  sample_n(team2,1) %>%
        pull(name)    
    
    team3 <- df %>%
        filter(team==input$Team3)
    
    third_person <-  sample_n(team3,1) %>%
        pull(name)    
    glue('Dear ',first_person,' ', second_person, ' and ', third_person,  '\n',  praise('${EXCLAMATION}! You are my ${adjective} coffee buddies!'))
    
    
}
    })



}


# Run the application 
shinyApp(ui = ui, server = server)
