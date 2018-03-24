FROM nvidia/cuda:9.0-runtime

ENV BMINER_RELEASE bminer-v5.4.0-ae18e12-amd64.tar.xz
ENV BMINER_SHA256  e292a0c1c45179d3dc9a18bf671beb10c2b106b37513cb2094958ef9f665c166

# Install ccminer deps :
RUN apt-get update && apt-get install --no-install-recommends -y wget ca-certificates xz-utils && \
    apt-get clean && rm -Rf /var/lib/apt/lists

RUN mkdir /opt/bminer

# Default dir /opt/bminer
WORKDIR /opt/bminer

RUN echo ${BMINER_SHA256} ${BMINER_RELEASE} > ${BMINER_RELEASE}.sha256

RUN wget -q https://www.bminercontent.com/releases/${BMINER_RELEASE} && \
    sha256sum -c ${BMINER_RELEASE}.sha256 && \
    tar --strip=1 -xJvf ${BMINER_RELEASE} && \
    rm ${BMINER_RELEASE} ${BMINER_RELEASE}.sha256

ENTRYPOINT [ "/opt/bminer/bminer" ]
