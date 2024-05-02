FROM python:3.8-slim

WORKDIR /app

COPY hello.py .

CMD ["python", "hello.py"]

