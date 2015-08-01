library(shiny)
shinyUI(navbarPage("Capstone SwiftKey Word Predictive Model",
    tabPanel("Text Prediction", inverse = FALSE, collapsable = FALSE,
        fluidPage(
             fluidRow(
                column(3,
                        wellPanel(
                        h4(p(strong("Predict the next word in the phrase"))),
                        p(strong("How to use the application:")),
                        h5(p('To use the application, simply enter a phrase in the field provided on the right and click on the Submit button.')),
                        h5(p('The next word will be generated at the word prediction output panel.')),
                        p(strong("Author: "), "Tan Chee Liang"),
                        p(strong("Date: "), "August 2015"),
                        p(strong("Slide deck:"), a(href="http://rpubs.com/kenntcl/dscapp", "R Pubs", target="_blank"))
                )),
                column(3,
                br(),
                h4(strong("Phrase Input")),
                textInput("inputphrase", label="Enter your phrase below:", value=""), 
                radioButtons("inputchoice", "Please choose whether to:", c("Predict a single word (as required for the Capstone Project)"="one", "Provide you a selection of four words (additional functionality)" = "four")),
                actionButton("goButton", "Submit!"),
                br()
                ),
                column(3,
                br(),
                h4(strong("Word Prediction Output")),
                br(),
                textOutput("outputtop1"),
                tableOutput("outputtop2")
                ),
                column(3,
                       br(),
                       h4(p(strong("Visualisation Generation"))),
                       actionButton("goButton2", "Generate Word Clouds"),
                       br(),
                       p(),
                       p("This will take a few seconds as it is calculated on the go."),
                       p("Thanks for your patience =)")
                )
        ),
        fluidRow(
                tabsetPanel(
                        tabPanel("Word Clouds",
                                 column(4,
                                        h4(strong("Bi-gram")),
                                        plotOutput("outputbottom23")),
                                 column(4,
                                        h4(strong("Tri-gram")),
                                        plotOutput("outputbottom22")),
                                 column(4,
                                        h4(strong("Quad-gram")),
                                        plotOutput("outputbottom21")) 
                                 
                        )
                )
        ))),
tabPanel("Key Concepts",                                                      
                 h3("Key Concepts/Terminology"),hr(),
                 h4("1. Tokenization() function"),
                 p("A", code("Tokenization()"), "function is developed based on",code("tm package"),
                   "for data cleaning process. It mainly provides users with reproducible functionalities such as:",
                   code("Simple Transformation"), code("Lowercase Transformation"), code("Remove Numbers"), 
                   code("Remove Punctuations"), code("Remove Stop Words"), code("Profanity Filtering"),"using only a single command."),
                 hr(),
                 h4("2. N-grams language model"),
                 p("An", code("n-gram model"), "is a type of probabilistic language model used for predicting the next item in a sequence in the form of", 
                   code("a (n - 1)"),"-order ", code("Markov model")),
                 p("In this model, we are using 2-4 grams for prediction purpose. They are refering to", code("bi-gram"),code("tri-gram"),code("quad-gram"),"respectively."),
                 hr(),
                 h4("3. Computing probabilities"),
                 p("To compute the probabilities of each token,",a("Markov chain", href="https://en.wikipedia.org/wiki/Markov_chain", target="_blank"),"is introduced and implemented
                   in our model."),
                 p("A Markov chain is a sequence of random variables X1, X2, X3, ... with the Markov property, given the present state, the future and past states are independent."),
                 hr(),
                 h4("4. Smoothing"),
                 p("Smoothing techniques are mainly used to cope with unseen n-grams in text modelling.",
                   a("Katz's back-off model", href="https://en.wikipedia.org/wiki/Katz%27s_back-off_model", target="_blank"),"is introduced in our model."),
                 p(code("Katz back-off"),"is a generative n-gram language model that estimates the conditional probability of a word given its history 
                   in the n-gram. It accomplishes this estimation by \"backing-off\" to models with smaller histories under certain conditions. 
                   By doing so, the model with the most reliable information about a given history is used to provide the better results.")
                 )
                 )
)