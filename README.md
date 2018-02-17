# nVidia mining container 

## Contains

- dstm equihash miner ( https://bitcointalk.org/index.php?topic=2021765.0 )

## Requires

- Docker
- nVidia's docker engine ( https://github.com/NVIDIA/nvidia-docker )

## Run

```
docker run --name ccminer --runtime=nvidia --rm minuntu/docker-nvidia-dstm
```
