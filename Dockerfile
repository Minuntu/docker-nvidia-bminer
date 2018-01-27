FROM nvidia/cuda

# Install ccminer deps :
RUN apt-get update && apt-get install --no-install-recommends -y curl wget openssl libffi6 libgnutls30 libgssapi-krb5-2 libgssapi3-heimdal \
    libhcrypto4-heimdal libheimbase1-heimdal libheimntlm0-heimdal libhogweed4 libhx509-5-heimdal libidn11 libjansson4 libk5crypto3 \
    libkeyutils1 libkrb5-26-heimdal libkrb5-3 libkrb5support0 libldap-2.4-2 libnettle6 libp11-kit0 libroken18-heimdal librtmp1 \
    libsasl2-2 libsasl2-modules-db libsigsegv2 libsqlite3-0 libssl1.0.0 libtasn1-6 libwind0-heimdal ca-certificates && \
    apt-get clean && rm -Rf /var/lib/apt/lists

RUN mkdir /opt/ccminer
RUN wget https://github.com/tpruvot/ccminer/archive/linux.tar.gz -qO - | tar --strip 1 -xzvC /opt/ccminer

# Default dir /opt/ccminer
WORKDIR /opt/ccminer

# Throw dstm : https://bitcointalk.org/index.php?topic=2021765.0
ADD zm /opt/ccminer/zm
ADD zm.sha1 /opt/ccminer/zm.sha1
RUN sha1sum -c zm.sha1

# Add sm_61 ( GTX 1080, GTX 1070, GTX 1060, GTX 1050, GTX 1030, Titan Xp, Tesla P40, Tesla P4 )
# Why is this not there by default ?
RUN echo 'nvcc_ARCH += -gencode=arch=compute_61,code=\"sm_61,compute_61\"' >> Makefile.am

# Build ccminer
RUN apt-get update && apt-get install -y libcurl4-openssl-dev libssl-dev libjansson-dev automake autotools-dev build-essential gcc-5 g++-5 && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 1 && \
    ./build.sh && \
    apt-get autoremove -y --purge libcurl4-openssl-dev libssl-dev libjansson-dev automake autotools-dev build-essential gcc-5 g++-5 && \
    apt-get clean && rm -Rf /var/lib/apt/lists

