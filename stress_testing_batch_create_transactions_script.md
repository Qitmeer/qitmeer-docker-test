# DAG create sign raw transaction hash script

## The Step

    1.need a account with address and private key

    ··· testnet:

        pk :
        pub :

    ··· simnet:

        pk :
        pub :
        
     ./script --network test --action generate-new-address

    2.start a node with modify some config up to machine config

        maxRequestContentLength = 1024 * 128  to 1024 * 128 * 1024

        --rpcmaxclients 10000000    # max rpc request connect up to machine config

        MaxSigOpsPerBlock = 10000 / 2 to 100000000 / 2  # this is related the pool transactions size, up to machine config

    3.generate 120 blocks to the account address,to make account has many money

    4.cost the coinbase to create 999 rand address

    5.modify the batch script to give the block height Range witch the init account can spend

## Compile
    need golang env
    
    cd $GOPATH/src
    
    git clone git@github.com:HalalChain/qitmeer.git
    
    git clone git@github.com:HalalChain/Nox-DAG-test.git
    
    cd Nox-DAG-test/script
    go build
    
## Run
    create new address 
    
    ./script --network test  --action generate-new-address
    
    create 999 transactions (the height is the coinbase reward to your address which you can cost)
    
    ./script --faddress=(your address which has much money) --privkey=xxxxxx -s (your node rpc server) -u (your node rpc user) -P (your node rpc pass) --addressfile=/tmp/address.csv --txfile=/tmp/tx.csv --notls --network=$network --height=1
    
    above command you can create 999 addresses in /tmp/address.csv1
    
        also you can create 999 signed transactions in /tmp/tx.csv1
        
    you can create more signed transactions with shell script
    
    if add --send true the signed transactions will send to the node rpc,if you want script test ,don't use this
    
    ./batch 1 30 test
    
        first param is start block 
        second param is end block 
        third param is network
        
        also you need modify you config in batch
        
        above command you will cost the start block to end block , and create 30000 signed transactions in txs.tar 30000 addresses in address.tar
        
   
    