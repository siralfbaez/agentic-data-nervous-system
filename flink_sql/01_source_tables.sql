CREATE TABLE raw_agent_context (
    agent_id STRING,
    observation STRING,
    event_time TIMESTAMP(3),
    WATERMARK FOR event_time AS event_time - INTERVAL '5' SECOND
) WITH (
    'connector' = 'kafka',
    'topic' = 'agent_observations',
    'properties.bootstrap.servers' = 'local-mock-broker:9092',
    'properties.group.id' = 'testGroup',
    'scan.startup.mode' = 'earliest-offset',
    'format' = 'json',
    'properties.allow.auto.create.topics' = 'true',
    -- Corrected name below (use a string like '10 s' or '10000 ms')
    'scan.topic-partition-discovery.interval' = '10 s'
);