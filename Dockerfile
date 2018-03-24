FROM nvidia/cuda:9.0-runtime

ENV BMINER_RELEASE bminer-v6.0.0-d111154-amd64.tar.xz
ENV BMINER_SHA256  b726bca5cd6ebe9ea921a703f920987670da24a91a7a84d3fb558eb71313ede9

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
