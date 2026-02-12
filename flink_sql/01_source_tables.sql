-- The "Senses" Input Stream
CREATE TABLE raw_agent_context (
    agent_id STRING,
    ts BIGINT,
    observation STRING,
    -- Convert epoch to native timestamp for accurate time-travel and windowing
    event_time AS TO_TIMESTAMP_LTZ(ts, 3),
    WATERMARK FOR event_time AS event_time - INTERVAL '5' SECOND
) WITH (
    'connector' = 'kafka',
    'topic' = 'raw_agent_context',
    'properties.bootstrap.servers' = 'local-mock-broker:9092',
    'format' = 'json',
    'scan.startup.mode' = 'latest-offset'
);
