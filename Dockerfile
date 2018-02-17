FROM nvidia/cuda:9.0-runtime

RUN mkdir /opt/dstm

# Default dir /opt/dstm
WORKDIR /opt/dstm

# Throw dstm : https://bitcointalk.org/index.php?topic=2021765.0
ADD zm /opt/dstm/zm
ADD zm.sha1 /opt/dstm/zm.sha1
RUN sha1sum -c zm.sha1

ENTRYPOINT /opt/dstm/zm
