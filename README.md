# Dockerfiles
This repo is for the various dockerfiles used by the vdblab.  It takes advantage of GitHub actions to build and publish the packages to the GitHub container registry.

## Build Manifest
The build manifest (`build_manifest.csv`) is a comma-delimited list of packages and the versions. In a perfect world, when a new package is released, the version is changed in this file and then that version string is passed to the docker build command as a `build-arg`, so that the appropriate version of the new package is built.
