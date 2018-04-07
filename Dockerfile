FROM nvidia/cuda:9.0-runtime

ENV BMINER_RELEASE bminer-v6.1.0-7ea8bbe-amd64.tar.xz 
ENV BMINER_SHA256  ee4c2890427ea504ceb71a55afac1e5618b664cc89d797e22f304ec4a262bf08

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
