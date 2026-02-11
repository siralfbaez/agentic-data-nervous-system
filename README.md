# PoC 2.0: The Agentic Data Nervous System 🧠⚡

An enterprise-grade, real-time streaming architecture designed to feed high-velocity, vectorized context to autonomous AI Agents with sub-second latency.

![Architecture Diagram Placeholder](https://via.placeholder.com/800x400?text=Insert+Architecture+Diagram+Here)

## 📖 Overview
Standard RAG (Retrieval-Augmented Generation) relies on static, batch-loaded databases, creating a "memory lag" for AI applications. This project demonstrates a **Data Nervous System** that bridges the gap between raw data streams and LLM inference. By leveraging **Apache Flink's** stateful processing and **MongoDB Atlas Vector Search**, this architecture provides AI agents with continuous, real-time context.

## 🚀 The Architecture

1. **The Senses (Ingestion - Apache NiFi 2.x):** - Handles multi-source data ingestion, cleansing, and dynamic deduplication before routing to the streaming layer.
2. **The Nervous System (Transport - Confluent Cloud/Kafka):** - Provides a durable, highly-available event backbone using Exactly-Once Semantics (EOS).
3. **The Brain (Processing - Apache Flink 2.2):** - Executes tumbling windows for behavioral sessionization and performs **in-stream vectorization** by calling OpenAI embedding models directly via Flink SQL.
4. **The Memory (Storage - MongoDB Atlas):** - Serves as the Vector Database sink, enabling semantic search and "Agentic Reflection" via `dotProduct` similarity.

## 📂 Repository Structure

* `/nifi` - JOLT transforms and flow definitions for raw data ingestion.
* `/flink_sql` - The core Flink SQL logic for stream-to-vector transformations.
* `/mongodb` - Infrastructure-as-Code for the Atlas Vector Search index.
* `docker-compose.yml` - Local environment setup for the NiFi/Kafka stack.

## 🛠️ Tech Stack
* **Streaming & Compute:** Apache Kafka, Confluent Cloud, Apache Flink 2.2
* **Ingestion:** Apache NiFi 2.x
* **Database & AI:** MongoDB Atlas (Vector Search), OpenAI Embeddings, Agentic RAG Frameworks

## ⚙️ Quick Start
*(Deployment instructions using Docker Compose and Confluent Cloud coming soon...)*
