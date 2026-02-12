-- The "Memory" Output Stream
CREATE TABLE vectorized_memory (
    agent_id STRING,
    window_start TIMESTAMP(3),
    behavior_summary STRING,
    vector ARRAY<FLOAT>
) WITH (
    'connector' = 'kafka',
    'topic' = 'agent_memory_vectors',
    'properties.bootstrap.servers' = 'local-mock-broker:9092',
    'format' = 'json'
);

-- The "Synapse" Logic: Sessionize Behavior -> Vectorize -> Sink
INSERT INTO vectorized_memory
SELECT 
    agent_id, 
    window_start, 
    LISTAGG(observation, ' | ') AS behavior_summary,
    ML_PREDICT('nervous_system_embedder', LISTAGG(observation, ' | ')) 
FROM TABLE(
    TUMBLE(TABLE raw_agent_context, DESCRIPTOR(event_time), INTERVAL '1' MINUTE)
)
GROUP BY window_start, window_end, agent_id;
