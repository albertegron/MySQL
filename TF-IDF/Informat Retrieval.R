install.packages("tm")
install.packages("NLP")
install.packages("SnowballC")
install.packages("slam")

library(tm)
library(SnowballC)
library(slam)

doc1 <- "Stray cats are running all over the place. I see 10 a day!"
doc2 <- "Cats are killers. They kill billions of animals a year."
doc3 <- "The best food in Columbus, OH is   the North Market."
doc4 <- "Brand A is the best tasting cat food around. Your cat will love it."
doc5 <- "Buy Brand C cat food for your cat. Brand C makes healthy and happy cats."
doc6 <- "The Arnold Classic came to town this weekend. It reminds us to be healthy."
doc7 <- "I have nothing to say. In summary, I have told you nothing."

doc.list <- list(doc1, doc2, doc3, doc4, doc5, doc6, doc7)
N.docs <- length(doc.list)
names(doc.list) <- paste0("doc", c(1:N.docs))

query <- "Healthy cat food"

my.docs <- VectorSource(c(doc.list, query))
my.docs$Names <- c(names(doc.list), "query")

my.corpus <- Corpus(my.docs)
my.corpus

getTransformations()
my.corpus <- tm_map(my.corpus, removePunctuation)
content(my.corpus[[1]])


my.corpus <- tm_map(my.corpus, stemDocument)
content(my.corpus[[1]])

my.corpus <- tm_map(my.corpus, removeNumbers)
my.corpus <- tm_map(my.corpus, content_transformer(tolower))
my.corpus <- tm_map(my.corpus, stripWhitespace)
content(my.corpus[[1]])

term.doc.matrix.stm <- TermDocumentMatrix(my.corpus)
inspect(term.doc.matrix.stm[0:14, ])

term.doc.matrix <- as.matrix(term.doc.matrix.stm)

cat("Dense matrix representation costs", object.size(term.doc.matrix), "bytes.\n", 
    "Simple triplet matrix representation costs", object.size(term.doc.matrix.stm), 
    "bytes.")

get.tf.idf.weights <- function(tf.vec) {
  # Computes tfidf weights from term frequency vector
  n.docs <- length(tf.vec)
  doc.frequency <- length(tf.vec[tf.vec > 0])
  weights <- rep(0, length(tf.vec))
  weights[tf.vec > 0] <- (1 + log2(tf.vec[tf.vec > 0])) * log2(n.docs/doc.frequency)
  return(weights)
}

# For a word appearing in 4 of 6 documents, occurring 1, 2, 3, and 6 times"
get.tf.idf.weights(c(1, 2, 3, 0, 0, 6))

tfidf.matrix <- t(apply(term.doc.matrix, 1,
                        FUN = function(row) {get.tf.idf.weights(row)}))
colnames(tfidf.matrix) <- colnames(term.doc.matrix)

tfidf.matrix[0:3, ]

##Dot Product Geometry

angle <- seq(-pi, pi, by = pi/16)
plot(cos(angle) ~ angle, type = "b", xlab = "angle in radians",
     main = "Cosine similarity by angle")


tfidf.matrix <- scale(tfidf.matrix, center = FALSE,
                      scale = sqrt(colSums(tfidf.matrix^2)))
tfidf.matrix[0:3, ]


query.vector <- tfidf.matrix[, (N.docs + 1)]
tfidf.matrix <- tfidf.matrix[, 1:N.docs]

doc.scores <- t(query.vector) %*% tfidf.matrix

results.df <- data.frame(doc = names(doc.list), score = t(doc.scores),
                         text = unlist(doc.list))
results.df <- results.df[order(results.df$score, decreasing = TRUE), ]

options(width = 2000)
print(results.df, row.names = FALSE, right = FALSE, digits = 2)

## We now calculate precision, recall and F-Score


#recall is the number of correct results(doc5) divided by the number of results that should have been returned.
recall<-1/2

#50%.
#It is trivial to achieve recall of 100% by returning all documents in response to any query. 
#Therefore, recall alone is not enough but one needs to measure the number of non-relevant documents also, 
#for example by computing the precision.

#precision=Fraction of the retrieved documents that are relevant to the query. Let us consider the top-most
#results of our search to deicde on relevant documents. As we did ranking of all the documents, we
#doc5 and doc4 are relevant to our query.The retrieved documents are 7.

precision<-2/7
#28.5%

# The F1 score (also F-score or F-measure) is a measure of a test's accuracy 
# It is the harmonic mean of precision and recall which is given by-
# 2*[(precision*recall)/(precision+recall)]
F.score<-2*((precision*recall)/(precision+recall))
F.score
#--------------------------------------
