# <font color=Chocolate size=6>Nox-DAG</font>

## Abstract
Introduce how to quickly establish the Nox-DAG Network

---

## What is Nox-DAG?
Nox-DAG is a DAG network based on Nox project. So it's very powerful, and you can even connect your own mining program to it for mining, or you can connect your wallet application to it for transfer transactions.

---

## Install
Here's how to install it quickly.
### From docker:
#### ***1.Install docker:***
* First you have to make sure that you have docker installed on your machine.And make sure you are a member of the user group docker.If you're all right, you can ignore this and jump right into ***step 2***.

#### ***2.Deployment image:***
* First we need to initialize the image, Of course, when you want the latest image, you can also use the following command.
```
docker pull halalchain/nox-dag
```
* <font color=Chocolate size=3>Finally, we can run this every time we start it up.</font>
```
docker run -it -p 18130:18130 -p 18131:18131 halalchain/nox-dag --miningaddr=[Your]
```

---

## CLI
* If you have some advanced requirements, or just want to test your full node, you can use the `cli` we carefully prepared for you.
```
docker run --rm halalchain/nox-dag cli [commands]
```
* For example, if you want to get the current total number of blocks, you can use the following command:
```
docker run --rm halalchain/nox-dag cli block
```
---

## About configuration
| Field | Explain |
| --- | --- |
| miningaddr | Miner account address |
| debuglevel | Logging level {trace, debug, info, warn, error, critical} |
| addpeer | Add a peer to connect with at startup |
| connect | Connect only to the specified peers at startup |

## Full nodes
| Server Name | IP Address | Describe |
| --- | --- | ---|
| Dagfans | 47.103.194.115:18130 | Shanghai |
| Pool | 42.51.64.58:38130 | Shanghai |
| ??? | ??? | Xi'an |

<font color=Gray size=3>If you haven't turned on DNS Seed service, you can use "addpeer" to add the above servers manually as your peers.</font>


* For example:
```
docker run -it -p 18130:18130 -p 18131:18131 halalchain/nox-dag --miningaddr=[Your] --addpeer=47.103.194.115:18130
```


---

## Remarks
### Install docker on ubuntu:
```
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
sudo apt-get update
sudo apt-get install docker-ce
```
* If you are already a root user, you can ignore next step
```
# Add docker user group and add the logged-in user to the docker user group.

sudo groupadd docker
sudo gpasswd -a $USER docker
newgrp docker
docker ps
```
* You can use `docker -v` to test whether the installation is successful or not.
Other systems platforms are similar.You can go [docker](https://www.docker.com/get-started)

---

***Welcome to submit issues to me.***
