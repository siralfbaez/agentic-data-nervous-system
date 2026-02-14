FROM flink:1.18.0-java11

USER root

# 1. Install build essentials and Python
RUN apt-get update -y && \
    apt-get install -y python3 python3-pip python3-dev build-essential openjdk-11-jdk && \
    rm -rf /var/lib/apt/lists/*

# 2. Hard-set the Java environment variables
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-arm64
ENV PATH=$JAVA_HOME/bin:$PATH

# 3. Upgrade pip and install libraries
RUN pip3 install --upgrade pip setuptools && \
    pip3 install --no-cache-dir openai apache-flink==1.18.0

# 4. BAKE THE UDF INTO THE IMAGE
# This ensures it's physically present on JobManager & TaskManager
COPY ./flink_sql/udf/embeddings.py /opt/flink/usrlib/embeddings.py
ENV PYTHONPATH=/opt/flink/usrlib

USER flink