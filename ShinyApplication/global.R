library(tm)
library(wordcloud)
library(memoise)

# La liste des livres valides
books <<- list("Les Misérables by Victor Hugo" = "Miserables",
               "Siddhartha by Hermann Hesse" = "Siddhartha",
               "Europe in the Middle Age" = "Europe")

# Utilise "memoise" pour mettre en cache automatiquement les résultats
getTermMatrix <- memoise(function(book) {
 
  if (!(book %in% books))
    stop("Livre non dispopnible")
  
  text <- readLines(sprintf("./%s.txt", book),
                    encoding="UTF-8")
  
  myCorpus = Corpus(VectorSource(text))
  myCorpus = tm_map(myCorpus, content_transformer(tolower))
  myCorpus = tm_map(myCorpus, removePunctuation)
  myCorpus = tm_map(myCorpus, removeNumbers)
  myCorpus = tm_map(myCorpus, removeWords,
                    c(stopwords("SMART"), "thy", "thou", "thee", "the", "and", "but"))
  
  myDTM = TermDocumentMatrix(myCorpus,
                             control = list(minWordLength = 1))
  
  m = as.matrix(myDTM)
  
  sort(rowSums(m), decreasing = TRUE)
})
