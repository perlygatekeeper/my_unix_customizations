import nltk
from nltk.tokenize import word_tokenize, sent_tokenize
from nltk.corpus import stopwords
from nltk.stem import PorterStemmer, WordNetLemmatizer

# Download required NLTK resources
nltk.download('punkt')
nltk.download('stopwords')
nltk.download('wordnet')

# Tokenization
def tokenize_text(text):
    sentences = sent_tokenize(text)
    tokens = [word_tokenize(sentence) for sentence in sentences]
    return tokens

# Stopword Removal
def remove_stopwords(tokens):
    stop_words = set(stopwords.words('english'))
    filtered_tokens = []
    for sentence_tokens in tokens:
        filtered_tokens.append([token for token in sentence_tokens if token.lower() not in stop_words])
    return filtered_tokens

# Stemming
def perform_stemming(tokens):
    stemmer = PorterStemmer()
    stemmed_tokens = []
    for sentence_tokens in tokens:
        stemmed_tokens.append([stemmer.stem(token) for token in sentence_tokens])
    return stemmed_tokens

# Lemmatization
def perform_lemmatization(tokens):
    lemmatizer = WordNetLemmatizer()
    lemmatized_tokens = []
    for sentence_tokens in tokens:
        lemmatized_tokens.append([lemmatizer.lemmatize(token) for token in sentence_tokens])
    return lemmatized_tokens

# Example usage
text = "NLTK is a powerful library for natural language processing. It provides several useful tools and resources."
tokens = tokenize_text(text)
filtered_tokens = remove_stopwords(tokens)
stemmed_tokens = perform_stemming(filtered_tokens)
lemmatized_tokens = perform_lemmatization(filtered_tokens)

print("Original Tokens:")
print(tokens)
print()
print("Filtered Tokens:")
print(filtered_tokens)
print()
print("Stemmed Tokens:")
print(stemmed_tokens)
print()
print("Lemmatized Tokens:")
print(lemmatized_tokens)
