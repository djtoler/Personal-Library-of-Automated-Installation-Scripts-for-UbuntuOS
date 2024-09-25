# pip3 install coremltools torch transformers
# pip3 install torch==2.2.0
# pip3 install scikit-learn==1.1.2


import torch
import coremltools as ct
from transformers import AutoModel, AutoTokenizer

# Load the pre-trained Sentence-BERT model
model = AutoModel.from_pretrained("sentence-transformers/paraphrase-MiniLM-L6-v2")
tokenizer = AutoTokenizer.from_pretrained("sentence-transformers/paraphrase-MiniLM-L6-v2")

# Input sentence for tracing
input_text = "What are the key features of data-driven businesses?"

# Tokenize the input sentence
tokens = tokenizer(input_text, return_tensors="pt", padding=True, truncation=True)
example_input = tokens["input_ids"]

# Write a wrapper to return only the embedding output (e.g., pooler_output or last_hidden_state)
class ModelWrapper(torch.nn.Module):
    def __init__(self, model):
        super(ModelWrapper, self).__init__()
        self.model = model

    def forward(self, input_ids):
        # Get the output from the model (e.g., 'last_hidden_state' or 'pooler_output')
        output = self.model(input_ids)
        # You can choose the output you need (e.g., 'pooler_output' or the first token embedding)
        return output['last_hidden_state'][:, 0, :]  # Example: the first token's embedding

# Wrap the model
wrapped_model = ModelWrapper(model)

# Trace the wrapped model
traced_model = torch.jit.trace(wrapped_model, example_input)

# Convert the traced model to CoreML
coreml_model = ct.convert(traced_model, inputs=[ct.TensorType(shape=example_input.shape)])

# Save the CoreML model as .mlpackage
coreml_model.save("SentenceEmbeddingModel.mlpackage")

