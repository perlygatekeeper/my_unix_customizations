import spacy

# Load the pre-trained English model
nlp = spacy.load("en_core_web_sm")

# Define a function for processing text
def process_text(text):
    # Parse the text
    doc = nlp(text)

    # Tokenization
    tokens = [token.text for token in doc]

    # Part-of-speech tagging
    pos_tags = [(token.text, token.pos_) for token in doc]

    # Named entity recognition
    named_entities = [(ent.text, ent.label_) for ent in doc.ents]

    return tokens, pos_tags, named_entities

# Example usage
text = "Apple Inc. is looking to acquire a startup in the AI industry."
tokens, pos_tags, named_entities = process_text(text)

print("Tokens:")
print(tokens)
print()
print("Part-of-Speech Tags:")
print(pos_tags)
print()
print("Named Entities:")
print(named_entities)
