# DAG Bench test batch create raw transaction script

## script repo 
    git@github.com:jamesvan2019/dag-bench-test-script.git
    
### 1.need a account with address and private key
    
    testnet:
    
        pk :
        base58 addr :
    
    private:
    
        pk :
        base58 addr :
    
### 2.start a node with modify some config up to machine config
    
        maxRequestContentLength = 1024 * 128  to 1024 * 128 * 1024
    
        --rpcmaxclients 10000000    # max rpc request connect up to machine config
    
        MaxSigOpsPerBlock = 10000 / 2 to 100000000 / 2  # this is related the pool transactions size, up to machine config
    
        BaseSubsidy:              50000000000000, //coinbase reward
    
### 3.generate 120 blocks to the account address,to make account has many money
    
### 4.cost the coinbase to create 999 rand address
    
### 6.Run the script to generate raw hash

    params:
        first block height
        end block height
        network private | test
    
    spend block 1 which can cost
        
    ./batch 1 1 private
