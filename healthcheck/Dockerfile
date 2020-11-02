FROM python:3.8-alpine
ENV SERVER_PORT=8000
COPY healthcheck.py /
CMD ["python", "healthcheck.py"]
EXPOSE $SERVER_PORT