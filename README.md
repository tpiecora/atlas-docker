# atlas-docker

Because of some quirkiness with docker, run your build commands from the repo root like this:

```docker build -t tpiecora/atlas-service:0.1 -f ./service/Dockerfile .```
```docker build -t tpiecora/atlas-spark:0.1 -f ./spark/Dockerfile .```
```docker build -t tpiecora/atlas-storage:0.1 -f ./storage/Dockerfile .```
```docker build -t tpiecora/atlas-stream:0.1 -f ./stream/Dockerfile .```
```docker build -t tpiecora/atlas-hdp:0.1 -f ./hdp/Dockerfile .```