module script

go 1.12

replace (
	github.com/Qitmeer/qitmeer-docker-test/script/tool => ./tool
	golang.org/x/crypto => github.com/golang/crypto v0.0.0-20190621222207-cc06ce4a13d4
	golang.org/x/exp => github.com/golang/exp v0.0.0-20190125153040-c74c464bbbf2
	golang.org/x/net => github.com/golang/net v0.0.0-20190503192946-f4e77d36d62c
	golang.org/x/sync => github.com/golang/sync v0.0.0-20180314180146-1d60e4601c6f
	golang.org/x/sys => github.com/golang/sys v0.0.0-20190412213103-97732733099d
	golang.org/x/text => github.com/golang/text v0.3.0
	golang.org/x/tools => github.com/golang/tools v0.0.0-20190511041617-99f201b6807e
        gonum.org/v1/gonum => github.com/gonum/gonum v0.0.0-20190608115022-c5f01565d866
)
