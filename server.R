library(tidyverse)

edvec <- seq(from = 0.05, to = 0.95, by = 0.05)
calcCI <- function(x, frac1, frac2, edvec){
  xc <- x %>% filter(Conc1 !=0 & Conc2 !=0)
  x1 <- x %>% filter(Conc1 !=0 & Conc2 ==0)
  x2 <- x %>% filter(Conc1 ==0 & Conc2 !=0)
  xc <- xc %>% mutate(ConcC = Conc1 + Conc2)
  
  fc <- lm(log((1/Response)-1) ~ log(ConcC), data = xc)
  Dmc <- exp(-(fc$coefficients[1])/(fc$coefficients[2]))[[1]]
  f1 <- lm(log((1/Response)-1) ~ log(Conc1), data = x1)
  Dm1 <- exp(-(f1$coefficients[1])/(f1$coefficients[2]))[[1]]
  f2 <- lm(log((1/Response)-1) ~ log(Conc2), data = x2)
  Dm2 <- exp(-(f2$coefficients[1])/(f2$coefficients[2]))[[1]]
  
  CIvec <- numeric()
  for (i in 1:length(edvec)){
    Dmcf <- Dmc*(((1-(1-edvec[i]))/(1-edvec[i]))^(1/fc$coefficients[2][[1]]))
    Dm1f <- Dm1*(((1-(1-edvec[i]))/(1-edvec[i]))^(1/f1$coefficients[2][[1]]))
    Dm2f <- Dm2*(((1-(1-edvec[i]))/(1-edvec[i]))^(1/f2$coefficients[2][[1]]))
    Da <- Dmcf*(frac1/(frac1 + frac2))
    Db <- Dmcf*(frac2/(frac1 + frac2))
    CombIndex <- (Da/Dm1f) + (Db/Dm2f)
    CIvec[i] <- CombIndex
  }
  res <- data.frame('ED' = edvec, 'CI' = CIvec)
  return(res)
}

drug1_name <- 'Magic drug A'
drug2_name <- 'Magic drug B'

mydata_combo <- data.frame('Conc1' = c(500, 400, 300, 200, 100), 'Conc2' = c(50, 40, 30, 20, 10), 'Response' = c(0.042, 0.122, 0.259, 0.532, 0.818))

mydata_mono1 <- data.frame('Conc1' = c(500, 400, 300, 200, 100), 'Conc2' = rep(0, 5), 'Response' = c(0.024, 0.256, 0.633, 0.678, 0.932))

mydata_mono2 <- data.frame('Conc1' = rep(0, 5), 'Conc2' = c(50, 40, 30, 20, 10), 'Response' = c(0.193, 0.244, 0.563, 0.750, 0.921))

df_ex <- rbind(mydata_combo, mydata_mono1, mydata_mono2)
df_ex$Drug1 <- drug1_name
df_ex$Drug2 <- drug2_name

server <- function(input, output){
  react_data <- eventReactive(
    input$buttonSelect,{
      df <- read_csv(input$fileSelect$datapath)
      if (input$checkSelect == TRUE){
        df <- df %>% mutate(Response = Response/100)
        }
      if (input$responseSelect == 'Inhibition'){
        df <- df %>% mutate(Response = 1 - Response)
      }
      m1 <- df %>% pull(Conc1) %>% max()
      m2 <- df %>% pull(Conc2) %>% max()
      res_df <- calcCI(x = df, edvec = edvec, 
                       frac1 = m1, frac2 = m2)
      return(res_df)
      }
  )
  
  output$table <- DT::renderDataTable({
    react_data()
  })
  
  output$plot1 <- renderPlot({
    p <- ggplot(react_data(), aes(x = ED, y = CI)) +
      geom_point() + geom_hline(yintercept = 1, linetype = 'dashed') +
      geom_smooth(method = 'loess', se = FALSE) +
      xlab('Fa') + theme_classic() + 
      annotate('rect', alpha = .2, xmin = -Inf, xmax = Inf,
               ymin = 1, ymax = Inf, fill = 'red') +
      annotate('rect', alpha = .2, xmin = -Inf, xmax = Inf,
               ymin = -Inf, ymax = 1, fill = 'blue')
    print(p)
  })
  
  output$fileDownload <- downloadHandler(
    filename = 'CIcomputeR_result.csv',
    content = function(file){
      write_csv(react_data(), file)
    }
  )
  
  output$exampleSelect <- downloadHandler(
    filename = 'CIcomputeR_example.csv',
    content = function(file){
      write_csv(df_ex, file)
    }
  )
  
  observeEvent(input$helpSelect, {
    showModal(modalDialog(
      title = 'Help, I\'m stuck!',
      'The input file must contain a column named Response, 
      a column named Conc1, and a column named Conc2',
      easyClose = TRUE, footer = NULL
    ))
  })
}