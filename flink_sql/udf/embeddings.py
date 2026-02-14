from pyflink.table import DataTypes
from pyflink.table.udf import udf
import openai
import os

@udf(result_type=DataTypes.ARRAY(DataTypes.DOUBLE()))
def get_openai_embedding(text):
    # Initialize the client INSIDE the function 
    # This prevents the "cannot pickle RLock" error
    client = openai.OpenAI(api_key=os.environ.get('OPENAI_API_KEY'))
    
    if not text:
        return [0.0] * 1536
        
    try:
        response = client.embeddings.create(
            input=text,
            model="text-embedding-3-small"
        )
        return response.data[0].embedding
    except Exception as e:
        print(f"OpenAI Error: {e}")
        return [0.0] * 1536
