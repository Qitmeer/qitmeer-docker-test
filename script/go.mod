module script

go 1.12

replace (
	golang.org/x/crypto => github.com/golang/crypto v0.0.0-20190621222207-cc06ce4a13d4
	golang.org/x/net => github.com/golang/net v0.0.0-20190503192946-f4e77d36d62c
	golang.org/x/sys => github.com/golang/sys v0.0.0-20190412213103-97732733099d
	golang.org/x/text => github.com/golang/text v0.3.0
	qitmeer-docker-test/script/tool => ./tool
)

require (
	qitmeer-docker-test/script/tool v0.0.0-00010101000000-000000000000
)
