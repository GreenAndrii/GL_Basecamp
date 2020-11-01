FROM python:3.8-alpine
ENV SERVER_PORT=8000
WORKDIR /httpserver
COPY requirements.txt healthcheck.py ./
RUN pip install  -r requirements.txt


CMD ["python", "healthcheck.py"]
EXPOSE $SERVER_PORT