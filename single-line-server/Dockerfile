FROM busybox
CMD while true; do { echo -e 'HTTP/1.1 200 OK\n\nVersion:v3.0.0'; }|nc -vlp 8000; done
EXPOSE 8000