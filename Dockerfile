FROM python:3.9-slim

WORKDIR /app

# Copy requirements
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy agent code and assets
COPY agent.py .
COPY agent_base.py .
COPY agent_container.py .
COPY config.yaml .
COPY examples.jsonl .
# Create directory for fine-tuned model (will be populated during build)
RUN mkdir -p ./fine_tuned_model/
# model_weights.pkl will be created during the build process

# Environment variables
ENV AGENT_ID="${AGENT_ID}"
ENV AGENT_NAME="${AGENT_NAME}"
ENV CORE_API_URL="http://host.docker.internal:8000"

# Run the agent
CMD ["python", "agent_container.py"]
