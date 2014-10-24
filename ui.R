shinyUI(fluidPage(
    
    titlePanel("M/M/C Queueing Model"),
    h6('Created by Thomas Roh'),
    br(),
    sidebarPanel(
    numericInput('arr.rate',label = 'Arrival Rate',value = 30.4),
    numericInput('serv.rate',label = 'Service Rate',value = 3.2),
    sliderInput('servers',label = 'Servers',min = 1, max = 100,
                value = as.vector(c(10,15)),ticks = T,width = '500px'),
    selectInput('time.units','Time Units',c('Seconds','Minutes','Hours','Days')),
    strong('Instructions:'),
    p('This tool analyzes service lines that have Markovian arrival rates and service times. 
Change the Arrival Rate (Average Customers/Time Unit) and the Service Rate 
(Average Customers Served/Time unit) to the desired level. Adjust the range of number
of servers to see comparative service levels for the following metrics:'),
    p('Average number of customers in system (L)'),
    p('Average number of customers in queue (Lq)'),
    p('Average customer time in system (W)'),
    p('Average customer time in queue (Wq)')
    
),
    
    mainPanel(
        
        tabsetPanel(
    
        tabPanel('L',plotOutput('Lplot'),width = 800, height = 600),
        tabPanel('Lq',plotOutput('Lqplot')),
        tabPanel('W',plotOutput('Wplot')),
        tabPanel('Wq',plotOutput('Wqplot')),
        tabPanel('Utilization',plotOutput('Uplot'))
                 
        )
    )
))