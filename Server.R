# Load the necessary libraries
library(shiny)
library(data.table)
library(tm)
library(wordcloud)
library(ggplot2)

# Process functions
source('Process.R')

# Load the necessary tables
con1 <- file(('./freqs/freq_4grams.txt'), open="r")
dt1 <- as.data.table(read.csv(con1))
setkey(dt1, prefix)
close(con1)

con1 <- file(('./freqs/freq_3grams.txt'), open="r")
dt2 <- as.data.table(read.csv(con1))
setkey(dt2, prefix)
close(con1) 

con1 <- file(('./freqs/freq_2grams.txt'), open="r")
dt3 <- as.data.table(read.csv(con1))
setkey(dt3, prefix)
close(con1) 


for (i in 1:3){
        con1 <- file(paste0('./freqs/freq_',5-i,'grams_mini.txt'), open="r")
        dttemp <- as.data.table(read.csv(con1))
        setkey(dttemp, prefix)
        assign(paste0("dt",i, "mini"), dttemp, '.GlobalEnv')
        close(con1)  
}


# Main function
shinyServer(
        function(input, output) {
                
                # Prediction of phrase
                inputcopy <- eventReactive(input$goButton, {input$inputphrase})
                dttemp <- reactive({as.data.frame(findanswer(inputcopy(), dt1, dt2, dt3))})
                
                outputtop1 <- eventReactive(input$goButton, {
                        if (input$inputchoice=="one") {
                                paste0(inputcopy()," ", as.character(dttemp()[1,1]))
                        }
                })
                output$outputtop1 <- renderText({outputtop1()})
                
                outputtop2 <- eventReactive(input$goButton, {
                        if (input$inputchoice=="four"){dttemp()}
                })
                output$outputtop2 <- renderTable({outputtop2()})
                
                
                # Visualisation of word cloud
                wordcloud1 <- eventReactive(input$goButton2, {
                        wordcloud(paste0(dt1$prefix, " ", dt1$answer), dt1$freq, max.words=50, scale=c(3, 0.5), colors=brewer.pal(5, "Set2"))})
                wordcloud2 <- eventReactive(input$goButton2, {
                        wordcloud(paste0(dt2$prefix, " ", dt2$answer), dt2$freq, max.words=50, scale=c(3, 0.5), colors=brewer.pal(5, "Set2"))})
                wordcloud3 <- eventReactive(input$goButton2, {
                        wordcloud(paste0(dt3$prefix, " ", dt3$answer), dt3$freq, max.words=50, scale=c(3, 0.5), colors=brewer.pal(5, "Set2"))})
                
                output$outputbottom21 <- renderPlot({wordcloud1()})
                output$outputbottom22 <- renderPlot({wordcloud2()})
                output$outputbottom23 <- renderPlot({wordcloud3()})
        }
)