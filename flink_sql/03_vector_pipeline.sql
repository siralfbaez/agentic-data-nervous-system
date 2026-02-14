-- The "Memory" Output Stream (Direct to MongoDB Atlas)
CREATE TABLE vector_memory (
    agent_id STRING,
    window_start TIMESTAMP(3),
    behavior_summary STRING,
    vector ARRAY<FLOAT>
) WITH (
    'connector' = 'mongodb',
    'uri' = '${MONGO_URI}',
    'database' = 'agentic_nervous_system',
    'collection' = 'vector_memory'
);

-- The "Synapse" Logic: Sessionize Behavior -> Vectorize -> Sink
INSERT INTO vector_memory
SELECT
    agent_id,
    window_start,
    LISTAGG(observation, ' | ') AS behavior_summary,
    ML_PREDICT('nervous_system_embedder', LISTAGG(observation, ' | '))
FROM TABLE(
    TUMBLE(TABLE raw_agent_context, DESCRIPTOR(event_time), INTERVAL '1' MINUTE)
)
GROUP BY window_start, window_end, agent_id;
