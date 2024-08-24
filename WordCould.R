library(tm)
library(wordcloud)
library(readr)

# Step 1: Read the Text File
file_path <- "Q1_responses.txt"
text <- read_file(file_path)
# Create a Corpus
corpus <- Corpus(VectorSource(text))

# Preprocess the text (convert to lower case, remove punctuation, numbers, stopwords)
corpus <- tm_map(corpus, content_transformer(tolower))
corpus <- tm_map(corpus, removePunctuation)
corpus <- tm_map(corpus, removeNumbers)
corpus <- tm_map(corpus, removeWords, stopwords("english"))

# Create a Document-Term Matrix
dtm <- TermDocumentMatrix(corpus)
matrix <- as.matrix(dtm)
word_freq <- sort(rowSums(matrix), decreasing = TRUE)
data <- data.frame(word = names(word_freq), freq = word_freq)

data <- data[data$freq >= 4, ]

words_to_remove <- c("group", "test", "went", "got", "made", "took")
data <- data[!(data$word %in% words_to_remove), ]

# Create the word cloud
wordcloud(words = data$word, freq = data$freq, min.freq = 1, colors = brewer.pal(8, "Dark2"))