library(ggplot2)
library(queueing)

shinyServer(
    function(input, output) {
        
            results <- reactive({ 
            
            servers <- seq(input$servers[1],input$servers[2],1)
            arrival.rate <- input$arr.rate
            service.rate <- input$serv.rate
            
            if(arrival.rate >= service.rate*servers[1])
                stop('The service rate * number of servers must be greater than the arrival rate.')
            
            inputs.MMC <- lapply(servers,function(x) NewInput.MMC(arrival.rate,service.rate,x))
            models <- lapply(inputs.MMC,QueueingModel)
            results <- data.frame(Servers = as.integer(servers),L = sapply(models,L),Lq = sapply(models,L),
                                  W = sapply(models,W),Wq = sapply(models,Wq), Utilization = sapply(models,RO))
            results
        })
        

        output$Lplot <- renderPlot({ 
            
            ggplot(results(),aes(x = Servers,y = L)) + 
                geom_smooth(method = loess,stat="identity",size = 2,color = '#D8B70A') +
                labs(x = 'Number of Servers',y = 'Average # of Customers in System')
      
        })
        
        output$Lqplot <- renderPlot({ 
            
            ggplot(results(),aes(x = Servers,y = Lq)) + 
                geom_smooth(method = loess,stat="identity",size = 2,color = '#02401B') +
                labs(x = 'Number of Servers',y = 'Average # of Customers in Queue')
            
        })
        
        output$Wplot <- renderPlot({ 
            
            ggplot(results(),aes(x = Servers,y = W)) + 
                geom_smooth(method = loess,stat="identity",size = 2,color = '#A2A475') +
                labs(x = 'Number of Servers',y = paste('Average Time in System (',input$time.units,')',sep=''))
            
        })
        
        output$Wqplot <- renderPlot({ 
            
            ggplot(results(),aes(x = Servers,y = Wq)) + 
                geom_smooth(method = loess,stat="identity",size = 2,color = '#81A88D') +
                labs(x = 'Number of Servers',y = paste('Average Waiting Time in Queue (',input$time.units,')',sep=''))
            
        })
        
        output$Uplot <- renderPlot({ 
            
            #results <- results()
            ggplot(results(),aes(x = Servers,y = Utilization)) + 
                geom_smooth(method = loess,stat="identity",size = 2,color = '#972D15') +
                labs(x = 'Number of Servers',y = 'Average Server Utilization')
            
        })
        
    }
)
