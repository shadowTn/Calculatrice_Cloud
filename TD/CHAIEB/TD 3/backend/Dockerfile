FROM debian:latest
RUN apt-get update && apt-get install -y \
    bash \ 
    htop \
    vim \
    net-tools

ENV OWNER=Amen
RUN useradd nonroot
USER nonroot

CMD [ "sleep", "3600" ]