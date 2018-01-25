FROM nvidia/cuda

# Install build deps :
RUN apt-get update && apt-get install --no-install-recommends -y libcurl4-openssl-dev libssl-dev libjansson-dev automake autotools-dev build-essential wget ca-certificates gcc-5 g++-5 && apt-get clean 
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-5 1
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
RUN ./build.sh
