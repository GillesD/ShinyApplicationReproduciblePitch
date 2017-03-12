fluidPage(
  # Tire de l'application - Application title
  titlePanel("Nuage de mots (Word Cloud)"),
  
  sidebarLayout(
    # Barre latérale avec un curseur et la sélection des livres
    sidebarPanel(
      selectInput("selection", "Choisir un livre :",
                  choices = books),
      actionButton("update", "Changer"),
      hr(),
      sliderInput("freq",
                  "Fréquence minimum : ",
                  min = 1,  max = 50, value = 15),
      sliderInput("max",
                  "Nombre Mmaximum de mots :",
                  min = 1,  max = 300,  value = 100)
    ),
    
    # Afficher le nuage de mots
    mainPanel(
      plotOutput("plot")
    )
  )
)