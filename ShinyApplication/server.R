# Texte des livres téléchargés depuis :
# Paris: A Sketch-Book :
#  http://www.gutenberg.org/cache/epub/54323/pg54323.txt
# London: A Sketch-Book :
#  http://www.gutenberg.org/cache/epub/54320/pg54320.txt
# Europe in the Middle Age :
#  http://www.gutenberg.org/cache/epub/54334/pg54334-0.txt

function(input, output, session) {
  # Définir une expression réactive pour la matrice de termes du document
  terms <- reactive({
    # Change quand le bouton "Changer" est pressé...
    input$update
    # ...Mais pas pour autre chose
    isolate({
      withProgress({
        setProgress(message = "Traitement en cours...")
        getTermMatrix(input$selection)
      })
    })
  })
  
  # Permet le nuage de mots prévisible lors d'une session
  wordcloud_rep <- repeatable(wordcloud)
  
  output$plot <- renderPlot({
    v <- terms()
    wordcloud_rep(names(v), v, scale=c(4,0.5),
                  min.freq = input$freq, max.words=input$max,
                  colors=brewer.pal(8, "Dark2"))
  })
}