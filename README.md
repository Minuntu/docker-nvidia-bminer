# nVidia mining container 

## Contains

- bminer equihash miner ( https://www.bminer.me/ )

## Requires

- Docker
- nVidia's docker engine ( https://github.com/NVIDIA/nvidia-docker )

## Run

```
docker run --name bminer -p 3336:3336 --runtime=nvidia --rm minuntu/nvidia-bminer -uri stratum+ssl://t1ZBtpkUy1y1deYsNJnzdW4tk7HiJEcfUzr.worker%2Ffoo%40gmail.com:x@zec-eu1.nanopool.org:6633 -api 0.0.0.0:3336
```
