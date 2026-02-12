-- The "Neuron" Model Definition
CREATE MODEL `nervous_system_embedder`
INPUT  (input STRING)
OUTPUT (vector ARRAY<FLOAT>)
WITH (
    'task' = 'embedding',
    'provider' = 'openai',
    'openai.api_key' = '${OPENAI_API_KEY}' -- Pulled from your .env file
);
