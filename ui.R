library(DT)
library(magrittr)
library(shinycssloaders)
library(bslib)

theme <- bslib::bs_theme(
  bg = "#eeeeee", fg = "#252e3c",
  primary = "#b6d7a8", secondary = "#b6d7a8",
  base_font = font_google("Roboto Serif", local = TRUE),
  code_font = c("Courier", "monospace"),
  heading_font = font_google("Roboto Serif", local = TRUE),
  "input-border-color" = "#aaaaaa"
)

responseChoices <- c('Viability', 'Inhibition')

fluidPage(
  theme = theme,
  titlePanel('CIComputeR: drug combination analysis',
             windowTitle = 'CIComputeR by snowoflondon'),
  tabsetPanel(
    tabPanel(div('Single Analysis', style = "color: #2f4f4f"),
      fluidRow(
        column(width = 4,
               verticalLayout(
                 p('Upload your file here!', style = "margin-top:10px;"),
                 fileInput(inputId = 'fileSelect',
                           accept = c('text/csv', 'text/comma-separated-values', '.csv'),
                           label = 'Open'),
                 textInput(label = 'Conc. A column header',
                           inputId = 'concaSelect',
                           value = NULL),
                 textInput(label = 'Conc. B column header',
                           inputId = 'concbSelect',
                           value = NULL),
                 textInput(label = 'Response column header',
                           inputId = 'resSelect',
                           value = NULL),
                 selectInput(inputId = 'responseSelect',
                             label = 'Cell Response Metric: ',
                             choices = as.list(responseChoices)),
                 checkboxInput(inputId = 'checkSelect',
                               label = 'Response as Percentage? Check for Yes ',
                               value = FALSE),
                 actionButton(inputId = 'buttonSelect',
                              label = 'Run CIComputeR',
                              style = "margin-top:5px;"),
                 actionButton(inputId = 'helpSelect',
                              label = 'Help', 
                              style = "margin-top:5px;")
               )),
        column(width = 8,
               DT::dataTableOutput(outputId = 'table') %>%
                 shinycssloaders::withSpinner(color = "#0dc5c1"))
      ),
      fixedRow(
        column(width = 5,
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
      ),
      fluidRow(
        column(width = 12,
               a(href = 'https://github.com/snowoflondon/CIComputeR_WEB',
                    'Shiny app source code'))
      )
    ),
    tabPanel(div('Batch analysis', style = "color: #2f4f4f"),
      fluidRow(
        column(width = 4,
          verticalLayout(
            p('Upload your file here!', style = "margin-top:10px;"),
            fileInput(inputId = 'fileSelectBatch',
                      accept = c('text/csv', 'text/comma-separated-values', '.csv'),
                      label = 'Open'),
            textInput(label = 'ID column header',
                      inputId = 'idSelectBatch',
                      value = NULL),
            textInput(label = 'Conc. A column header',
                      inputId = 'concaSelectBatch',
                      value = NULL),
            textInput(label = 'Conc. B column header',
                      inputId = 'concbSelectBatch',
                      value = NULL),
            textInput(label = 'Response column header',
                      inputId = 'resSelectBatch',
                      value = NULL),
            selectInput(inputId = 'responseSelectBatch',
                        label = 'Cell Response Metric: ',
                        choices = as.list(responseChoices)),
            checkboxInput(inputId = 'checkSelectBatch',
                          label = 'Response as Percentage? Check for Yes',
                          value = FALSE),
            actionButton(inputId = 'buttonSelectBatch',
                         label = 'Run CIComputeR Batch Mode'),
            actionButton(inputId = 'helpSelectBatch',
                         label = 'Help',
                         style = "margin-top:5px;"),
            downloadButton(outputId = 'fileDownloadBatch',
                           label = 'Download Result File',
                           style = "margin-top:5px;")
          )),
        column(width = 8,
            DT::dataTableOutput(outputId = 'tableBatch') %>%
              shinycssloaders::withSpinner(color = "#0dc5c1"))
      )
    )
  )
)

