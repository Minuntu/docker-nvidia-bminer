# nVidia mining container 

## Contains

- dstm equihash miner ( https://bitcointalk.org/index.php?topic=2021765.0 )

## Requires

- Docker
- nVidia's docker engine ( https://github.com/NVIDIA/nvidia-docker )

## Run

```
docker run --name ccminer -p 3336:3336 --runtime=nvidia --rm minuntu/nvidia-dstm --telemetry 3336 --server ssl://my-pool.com --port 3335 --user address --pass x
```
