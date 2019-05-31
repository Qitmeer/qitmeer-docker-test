# <font color=Chocolate size=6>Miner and mining pool manual</font>

## 1.Miner

### (1) Enviroment
- Windows 10
  
  - install opencl sdk ,recommend cuda v10.1 see [here](https://developer.nvidia.com/cuda-downloads) 
  
- Ubuntu 19 

   - need display card
    
```bash
$ sudo apt-get install beignet-dev nvidia-cuda-dev nvidia-cuda-toolkit 
```        
 
    
### (2) Run

- Download miner from the release [here](https://github.com/jamesvan2019/Nox-DAG-test/releases)

- Unzip the file

- Run with config file `halachainminer.conf`

    - modify the config params 
        
        - `mineraddress`=TmRvuqtjb3DsYQJTcEZQZD5qfJWcMggdEYP
        - `rpcserver`=127.0.0.1:1234
        - `rpcuser`=test
        - `rpcpass`=test
        
        ===========pool config ==========
        
         - `pool`=stratum+tcp://127.0.0.1:3177
         - `pooluser`=RmN4SADy42FKmN8ARKieX9iHh9icptdgYNn.1 (address.worknum)
         - `poolpass`=
    
    - open `cmd` tools
    
    - cd miner directory
    
```bash
# run
$ cd (miner directory)
$ ./hlc-miner
```
![dir](images/miner.png)   
- Run with solo command line
    
```bash
#run 
$ cd (miner directory)
$ ./hlc-miner -s 127.0.0.1:1234 -u test -P test --symbol HLC --notls -i 24 -W 256 --mineraddress RmN4SADy42FKmN8ARKieX9iHh9icptdgYNn 
```
- Run with pool command line

```bash
#run 
$ cd (miner directory)
$ ./hlc-miner -o stratum+tcp://127.0.0.1:3177 -m RmN4SADy42FKmN8ARKieX9iHh9icptdgYNn --symbol HLC --notls -i 24 -W 256
``` 

### Param Description 
          
- `--dag` the node is dag node
- `-s` the node rpc listen address
- `-u` the node rpc username
- `-P` the node rpc password
- `--symbol` now just `HLC` is supported
- `--i` Intensities (the work size is 2^intensity) up to device
- `--W` The explicitly declared sizes of the work to do up to device (overrides intensity)
- `--mineraddress` the miner address
- `-o` the pool address
- `-m` the pool user account address


## 2.Mining pool
