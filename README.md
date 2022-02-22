# Random Dockerfiles

## Grinder Read simulator
To build,
```
docker build -t nickp60/grinder Grinder-read-simulator/
```

To use:
```
docker run --rm -v $PWD:/data/ -t nickp60/grinder  Grinder-0.5.4/bin/grinder --help
```