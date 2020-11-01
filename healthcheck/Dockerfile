FROM python:3.8-alpine as base

FROM base as builder
WORKDIR /install
COPY requirements.txt /requirements.txt
RUN pip install --prefix=/install --no-warn-script-location -r /requirements.txt

FROM base
ENV SERVER_PORT=8000
COPY --from=builder /install /usr/local
WORKDIR /healthcheck
COPY healthcheck.py ./
CMD ["python", "healthcheck.py"]
EXPOSE $SERVER_PORT