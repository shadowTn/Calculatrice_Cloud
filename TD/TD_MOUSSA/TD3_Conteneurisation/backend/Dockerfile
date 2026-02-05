FROM debian:latest

RUN apt update && apt install -y bash htop vim net-tools

RUN useradd nonroot
USER nonroot

ENV OWNER="FARIKOU"

CMD ["sleep", "3600"]