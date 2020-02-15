# RNAseqv2
A collection of functions to execute RNAseq analysis wrapped in docker containers

### Install
To install **RNAseqv2** you can use use **devtools**:

```
install.packages("devtools")
library(devtools)
install_github("https://github.com/qBioTurin/RNAseqv2", ref="master")
```

#### Download Containers
To download all the docker images exploited by **RNAseqv2**  you can use:

```
library(RNAseq2)
downloadContainers()
```


### Requirements
You need to have docker installed on your machine, for more info see this document:
https://docs.docker.com/engine/installation/.

Ensure your user has the rights to run docker (witout the use of ```sudo```). To create the docker group and add your user:

* Create the docker group.

```
  $ sudo groupadd docker
```
* Add your user to the docker group.

```
  $ sudo usermod -aG docker $USER
```
* Log out and log back in so that your group membership is re-evaluated.

### Reproducible Bioinformatics Community
**RNAseqv2** is one of the tools developed under the umbrella of the Reproducible Bioinformatics project (http://www.reproducible-bioinformatics.org/), an open-source community aimed at providing to biologists and medical scientists an easyto-use and flexible framework, which also guarantees the ability to reproduce results independently by the underlying hardware, using Docker containerization (computational reproducibility).

### Disclaimer:
**RNAseqv2**  developers have no liability for any use of **RNAseqv2**  functions, including without limitation, any loss of data, incorrect results, or any costs, liabilities, or damages that result from use of **RNAseqv2**.
