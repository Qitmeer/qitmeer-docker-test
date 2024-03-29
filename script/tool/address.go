package tool

import (
	"fmt"
	"github.com/Qitmeer/qitmeer/common/encode/base58"
	"github.com/Qitmeer/qitmeer/common/hash"
	"github.com/Qitmeer/qitmeer/core/address"
	"github.com/Qitmeer/qitmeer/crypto/bip32"
	"github.com/Qitmeer/qitmeer/crypto/ecc"
	"github.com/Qitmeer/qitmeer/crypto/seed"
	"github.com/Qitmeer/qitmeer/params"
	"log"
	"encoding/hex"
)

//create address
func CreateNoxAddr(network string) (priKey string ,base58Addr string ){
	seed1 := NewEntropy(32)
	privateKey := EcNew("secp256k1",seed1)
	publicKey := EcPrivateKeyToEcPublicKey(false,privateKey)
	log.Println("public key",publicKey)
	param := params.PrivNetParams
	switch network {
	case "private":
	case "test":
		param = params.TestNetParams
	case "mix":
		param = params.MixNetParams
	case "main":
		param = params.MainNetParams
	}

	//param := params.MainNetParams
	addr := EcPubKeyToAddress(param.PubKeyHashAddrID[:],publicKey)
	addres,err := address.DecodeAddress(addr)
	if err != nil{
		log.Fatalln("verify failed",err)
		return
	}
	return privateKey,addres.String()
}
//generate seed
func NewEntropy(size uint) string{
	s,err :=seed.GenerateSeed(uint16(size))
	if err!=nil {
		log.Fatal(err)
		return ""
	}
	return fmt.Sprintf("%x",s)
}
//secp256k1 generate private key
func EcNew(curve string, entropyStr string) string{
	entropy, err := hex.DecodeString(entropyStr)
	if err!=nil {
		log.Fatalln("error",entropyStr,err)
		return ""
	}
	switch curve {
	case "secp256k1":
		masterKey,err := bip32.NewMasterKey(entropy)
		if err!=nil {
			log.Fatalln(err)
			return ""
		}
		return fmt.Sprintf("%x",masterKey.Key[:])
	default:
	}
	return ""
}

//from private key to public key
func EcPrivateKeyToEcPublicKey(uncompressed bool, privateKeyStr string) string{
	data, err := hex.DecodeString(privateKeyStr)
	if err!=nil {
		log.Fatalln(err)
		return ""
	}
	_, pubKey := ecc.Secp256k1.PrivKeyFromBytes(data)
	var key []byte
	if uncompressed {
		key = pubKey.SerializeUncompressed()
	}else {
		key = pubKey.SerializeCompressed()
	}
	return fmt.Sprintf("%x",key[:])
}

// public key to bas58 address
func EcPubKeyToAddress(version []byte, pubkey string) string{
	data, err :=hex.DecodeString(pubkey)
	if err != nil {
		log.Println(err)
		return ""
	}
	h := hash.Hash160(data)

	addr := base58.QitmeerCheckEncode(h, version[:])
	return fmt.Sprintf("%s",addr)
}

