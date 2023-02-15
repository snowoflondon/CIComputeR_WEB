library(shinythemes)
library(DT)
library(shinycssloaders)
library(magrittr)

responseChoices <- c('Viability', 'Inhibition')

fluidPage(
  theme = shinytheme('journal'),
  titlePanel('CIcomputeR'),
  fluidRow(
    column(width = 4,
           verticalLayout(
             p('Upload your file here!'),
             fileInput(inputId = 'fileSelect',
                       accept = c('text/csv', 'text/comma-separated-values', '.csv'),
                       label = 'Open'),
             selectInput(inputId = 'responseSelect',
                         label = 'Cell Response Metric: ',
                         choices = as.list(responseChoices)),
             checkboxInput(inputId = 'checkSelect',
                           label = 'Response as Percentage? Check for Yes ',
                           value = FALSE),
             actionButton(inputId = 'buttonSelect',
                          label = 'Run CIComputeR'),
             actionButton(inputId = 'helpSelect',
                          label = 'Help', 
                          style='font-size:80%')
           )),
    column(width = 8,
           DT::dataTableOutput(outputId = 'table') %>%
            shinycssloaders::withSpinner(color = "#0dc5c1"))
  ),
  fluidRow(
    column(width = 12,
           plotOutput(outputId = 'plot1') %>%
            shinycssloaders::withSpinner(color = "#0dc5c1"))
  ),
  fluidRow(
    column(width = 12,
           downloadButton(outputId = 'fileDownload',
                          label = 'Download Result Table'))
  ),
  fluidRow(
    column(width = 12,
           downloadButton(outputId = 'exampleSelect',
                          label = 'Download Example Data'))
  ),
  fluidRow(
    column(width = 12,
           a(href = 'https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4759401/',
                'Reference'))
  )
)

