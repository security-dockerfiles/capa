FROM python:2-slim
LABEL maintainer "ilya@ilyaglotov.com"

ARG COMMIT=v1.1.0

RUN apt-get update \
  && apt-get install -y git \
  && pip install https://github.com/fireeye/capa/archive/$COMMIT.tar.gz \
  && git clone --branch=master --depth=1 https://github.com/fireeye/capa-rules.git \
  && rm -rf /capa-rules/.git \
  && apt-get purge -y git \
  && useradd -m capa

USER capa
WORKDIR /home/capa
ENTRYPOINT ["capa", "-r", "/capa-rules"]
CMD ["--help"]
