# <font color=Chocolate size=6>Miner and mining pool manual</font>

# 1.Miner




# 2.Mining pool

## system Requirements

os: linux （e.g. ubunutu 16.04>,centos 6>）

node.js enviroment (version >= 10)

redis / mysql / nginx , recommend installing from docker

hlc node (at least 1 node referring to https://github.com/HalalChain/Nox-DAG-test/blob/master/README.md)



## install

### 1. download pool code

https://github.com/HalalChain/hlc-pool/archive/master.zip

### 2. install node enviroment

download binary from https://nodejs.org/zh-cn/download/

install referring to https://github.com/nodejs/help/wiki/Installation

### 3. mysql init

load pol.sql( utils/pol.sql ) file to mysql

### 4. install pool

cd pool code folder and install node modules

```bash
# install c++ dev tools
# ubuntu 
apt-get install build-essential
# centos 
yum groupinstall "Development Tools" 

# install node modules
npm install --save
```

## config pool

you should setup at least 4 config files (path to conf/ ) to run pool,round,payment,pay,admin and api.

the pool system contain 6 precedures:

1. pool procedure, to accept miner connect and find blocks

2. round procedure, to calculate miners share and credit

3. payment procedure, to make pay list for pay

4. pay procedure, to send coin to miner

5. admin procedure, to manage pay list

6. api procedure， to serve json data for pool index page


## server firewall open port

pool port (tcp),to accept mining machine connect (e.g. 3177,80)

## run pool

```bash
# pool 
npm run pool pool.js

# pay
npm run round pay.js
npm run payment pay.js
npm run pay pay.js
npm run admin admin.js

# web api
npm run api api.js
```

## minning machine connection

pool support stratum protocol,so your minning program should config protocol.


```
# exmaple

miner.exe -o stratum+tcp://server_ip:3177 
```
