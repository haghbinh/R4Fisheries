# library(shiny)
# 
# ui <- fluidPage(
#   titlePanel("Aquaculture Data Explorer")
# )
# 
# server <- function(input, output, session) {
# }
# 
# shinyApp(ui = ui, server = server)

###################################################3

# library(shiny)
# 
# ui <- fluidPage(
#   titlePanel("Researcher Greeting"),
#   sidebarLayout(
#     sidebarPanel(
#       textInput(
#         inputId = "researcher_name",
#         label = "Researcher name:",
#         value = "Researcher"
#       )
#     ),
#     mainPanel(
#       textOutput("greeting_text")
#     )
#   )
# )
# 
# server <- function(input, output, session) {
#   output$greeting_text <- renderText({
#     paste("Welcome,", input$researcher_name)
#   })
# }
# 
# shinyApp(ui = ui, server = server)
# 
# library(shiny)
# 
# farm_data <- data.frame(
#   farm = c("Farm_A", "Farm_B", "Farm_C"),
#   area_ha = c(12, 18, 9),
#   pond_count = c(8, 12, 6),
#   production_ton = c(45.2, 71.5, 32.8),
#   stringsAsFactors = FALSE
# )
# 
# ui <- fluidPage(
#   titlePanel("Shrimp Farm Information"),
#   sidebarLayout(
#     sidebarPanel(
#       selectInput(
#         inputId = "selected_farm",
#         label = "Select farm:",
#         choices = farm_data$farm,
#         selected = farm_data$farm[1]
#       )
#     ),
#     mainPanel(
#       tableOutput("farm_summary")
#     )
#   )
# )
# 
# server <- function(input, output, session) {
#   output$farm_summary <- renderTable({
#     farm_data[farm_data$farm == input$selected_farm, ]
#   })
# }
# 
# shinyApp(ui = ui, server = server)

# 
# library(shiny)
# library(ggplot2)
# 
# water_data <- data.frame(
#   pond = rep(paste0("P", 1:6), each = 4),
#   week = rep(1:4, times = 6),
#   temperature = c(
#     27.1, 27.8, 28.4, 29.0,
#     26.5, 27.0, 27.6, 28.2,
#     28.0, 28.6, 29.1, 29.7,
#     25.8, 26.4, 26.9, 27.5,
#     27.3, 27.9, 28.5, 28.8,
#     26.9, 27.4, 28.0, 28.6
#   ),
#   salinity = c(
#     18.2, 18.5, 18.1, 17.9,
#     20.1, 20.4, 20.0, 19.8,
#     16.8, 17.1, 17.3, 17.0,
#     22.0, 21.7, 21.5, 21.2,
#     19.0, 19.2, 19.5, 19.3,
#     17.8, 18.0, 18.4, 18.2
#   ),
#   dissolved_oxygen = c(
#     5.8, 5.5, 5.2, 4.9,
#     6.2, 5.9, 5.7, 5.4,
#     5.5, 5.2, 4.8, 4.6,
#     6.4, 6.1, 5.8, 5.6,
#     5.9, 5.7, 5.4, 5.1,
#     6.0, 5.8, 5.5, 5.3
#   )
# )
# 
# ui <- fluidPage(
#   titlePanel("Water Quality Explorer"),
#   sidebarLayout(
#     sidebarPanel(
#       selectInput(
#         inputId = "selected_pond",
#         label = "Select pond:",
#         choices = unique(water_data$pond),
#         selected = unique(water_data$pond)[1]
#       ),
#       selectInput(
#         inputId = "selected_variable",
#         label = "Select variable:",
#         choices = c(
#           "Temperature" = "temperature",
#           "Salinity" = "salinity",
#           "Dissolved oxygen" = "dissolved_oxygen"
#         ),
#         selected = "temperature"
#       )
#     ),
#     mainPanel(
#       plotOutput("water_plot"),
#       tableOutput("water_summary")
#     )
#   )
# )
# 
# server <- function(input, output, session) {
#   selected_data <- reactive({
#     water_data[water_data$pond == input$selected_pond, ]
#   })
#   
#   output$water_plot <- renderPlot({
#     data_to_plot <- selected_data()
#     
#     ggplot(
#       data_to_plot,
#       aes(x = week, y = .data[[input$selected_variable]])
#     ) +
#       geom_line(linewidth = 1, color = "steelblue") +
#       geom_point(size = 3, color = "darkred") +
#       labs(
#         x = "Week",
#         y = input$selected_variable,
#         title = paste("Water quality in", input$selected_pond)
#       ) +
#       theme_minimal()
#   })
#   
#   output$water_summary <- renderTable({
#     data_to_summarize <- selected_data()
#     variable_values <- data_to_summarize[[input$selected_variable]]
#     
#     data.frame(
#       minimum = min(variable_values),
#       mean = mean(variable_values),
#       maximum = max(variable_values),
#       standard_deviation = sd(variable_values)
#     )
#   })
# }
# 
# shinyApp(ui = ui, server = server)


# library(shiny)
# library(dplyr)
# library(ggplot2)
# 
# pond_data <- data.frame(
#   pond = paste0("P", 1:10),
#   treatment = rep(c("Control", "Supplement"), each = 5),
#   mean_oxygen = c(4.8, 5.1, 5.4, 5.7, 6.0, 5.0, 5.6, 6.1, 6.4, 6.8),
#   survival = c(68, 72, 75, 78, 80, 74, 79, 83, 86, 88)
# )
# 
# ui <- fluidPage(
#   titlePanel("Pond Survival Analysis"),
#   sidebarLayout(
#     sidebarPanel(
#       sliderInput(
#         inputId = "oxygen_range",
#         label = "Mean dissolved oxygen range:",
#         min = min(pond_data$mean_oxygen),
#         max = max(pond_data$mean_oxygen),
#         value = range(pond_data$mean_oxygen),
#         step = 0.1
#       )
#     ),
#     mainPanel(
#       plotOutput("survival_plot"),
#       tableOutput("selected_ponds")
#     )
#   )
# )
# 
# server <- function(input, output, session) {
#   filtered_ponds <- reactive({
#     pond_data %>%
#       filter(
#         mean_oxygen >= input$oxygen_range[1],
#         mean_oxygen <= input$oxygen_range[2]
#       )
#   })
#   
#   output$survival_plot <- renderPlot({
#     ggplot(
#       filtered_ponds(),
#       aes(x = mean_oxygen, y = survival, color = treatment)
#     ) +
#       geom_point(size = 3) +
#       geom_smooth(method = "lm", se = FALSE) +
#       labs(
#         x = "Mean dissolved oxygen",
#         y = "Survival percentage",
#         color = "Treatment"
#       ) +
#       theme_minimal()
#   })
#   
#   output$selected_ponds <- renderTable({
#     filtered_ponds()
#   })
# }
# 
# shinyApp(ui = ui, server = server)


library(shiny)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(plotly)
library(DT)

set.seed(123)

shrimp_data <- expand.grid(
  pond = paste0("P", 1:8),
  week = 1:6
)

shrimp_data$treatment <- rep(
  c("Control", "Supplement"),
  length.out = nrow(shrimp_data)
)

shrimp_data$weight <- round(
  2 + shrimp_data$week * 1.8 +
    ifelse(shrimp_data$treatment == "Supplement", 1.2, 0) +
    rnorm(nrow(shrimp_data), 0, 0.5),
  2
)

shrimp_data$survival <- round(
  70 + shrimp_data$week * 1.5 +
    ifelse(shrimp_data$treatment == "Supplement", 4, 0) +
    rnorm(nrow(shrimp_data), 0, 2),
  1
)

ui <- dashboardPage(
  dashboardHeader(title = "Shrimp Production Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem(
        "Overview",
        tabName = "overview",
        icon = icon("dashboard")
      ),
      menuItem(
        "Growth",
        tabName = "growth",
        icon = icon("chart-line")
      ),
      menuItem(
        "Data",
        tabName = "data",
        icon = icon("table")
      )
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "overview",
        fluidRow(
          valueBoxOutput("mean_weight_box"),
          valueBoxOutput("mean_survival_box")
        ),
        fluidRow(
          box(
            width = 12,
            title = "Survival trend",
            plotlyOutput("survival_plot")
          )
        )
      ),
      tabItem(
        tabName = "growth",
        fluidRow(
          box(
            width = 4,
            selectInput(
              inputId = "selected_treatment",
              label = "Select treatment:",
              choices = c("All", unique(shrimp_data$treatment)),
              selected = "All"
            )
          )
        ),
        fluidRow(
          box(
            width = 12,
            title = "Growth trend",
            plotlyOutput("growth_plot")
          )
        )
      ),
      tabItem(
        tabName = "data",
        fluidRow(
          box(
            width = 12,
            title = "Shrimp data",
            DTOutput("data_table")
          )
        )
      )
    )
  )
)

server <- function(input, output, session) {
  filtered_data <- reactive({
    if (input$selected_treatment == "All") {
      shrimp_data
    } else {
      shrimp_data %>%
        filter(treatment == input$selected_treatment)
    }
  })
  
  output$mean_weight_box <- renderValueBox({
    valueBox(
      value = round(mean(filtered_data()$weight), 2),
      subtitle = "Mean weight",
      icon = icon("weight"),
      color = "blue"
    )
  })
  
  output$mean_survival_box <- renderValueBox({
    valueBox(
      value = paste0(round(mean(filtered_data()$survival), 1), "%"),
      subtitle = "Mean survival",
      icon = icon("check"),
      color = "green"
    )
  })
  
  output$growth_plot <- renderPlotly({
    growth_plot <- ggplot(
      filtered_data(),
      aes(
        x = week,
        y = weight,
        color = treatment,
        group = interaction(pond, treatment),
        text = paste(
          "Pond:", pond,
          "<br>Week:", week,
          "<br>Weight:", weight
        )
      )
    ) +
      geom_line(alpha = 0.6) +
      geom_point() +
      labs(
        x = "Week",
        y = "Weight",
        color = "Treatment"
      ) +
      theme_minimal()
    
    ggplotly(growth_plot, tooltip = "text")
  })
  
  output$survival_plot <- renderPlotly({
    survival_summary <- filtered_data() %>%
      group_by(week, treatment) %>%
      summarise(
        mean_survival = mean(survival),
        .groups = "drop"
      )
    
    survival_plot <- ggplot(
      survival_summary,
      aes(
        x = week,
        y = mean_survival,
        color = treatment,
        group = treatment
      )
    ) +
      geom_line(linewidth = 1) +
      geom_point(size = 2) +
      labs(
        x = "Week",
        y = "Mean survival",
        color = "Treatment"
      ) +
      theme_minimal()
    
    ggplotly(survival_plot)
  })
  
  output$data_table <- renderDT({
    datatable(
      filtered_data(),
      options = list(
        pageLength = 10,
        scrollX = TRUE
      )
    )
  })
}

shinyApp(ui = ui, server = server)