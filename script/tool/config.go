/**
	HLC FOUNDATION
	james
 */

package tool

import (
	"os"
	"path/filepath"
	"github.com/Qitmeer/qitmeer-docker-test/script/tool/go-flags"
	"strings"
)

type Config struct {
	// Config / log options
	Action string `long:"action" description:"Run action."`
	FromPrivateKey   string `short:"f" long:"privkey" default-mask:"-" description:"private key"`
	FromAddress   string `short:"x" long:"faddress" default-mask:"-" description:"from address"`
	Network   string `short:"o" long:"network" description:"test" default-mask:"-"`
	// RPC connection options
	RPCUser     string `short:"u" long:"rpcuser" description:"RPC username"`
	//Dag     	bool `short:"dag" long:"dag" description:"dag mining"`
	RPCPassword string `short:"P" long:"rpcpass" default-mask:"-" description:"RPC password"`
	RPCServer   string `short:"s" long:"rpcserver" description:"RPC server to connect to"`
	RPCCert     string `short:"c" long:"rpccert" description:"RPC server certificate chain for validation"`
	NoTLS       bool   `long:"notls" description:"Disable TLS"`
	Send       bool   `long:"send" description:"send tx"`
	Height       int   `long:"height" description:"send height"`
	AddressFile   string `short:"q" long:"addressfile" default-mask:"-" description:"from address"`
	TXFile   string `short:"r" long:"txfile" default-mask:"-" description:"from address"`
	FromTransactionHash   string `short:"y" long:"fromtransaction" default-mask:"-" description:"from transaction"`
}

// loadConfig initializes and parses the config using a config file and command
// line options.
//
// The configuration proceeds as follows:
// 	1) Start with a default config with sane settings
// 	2) Pre-parse the command line to check for an alternative config file
// 	3) Load configuration file overwriting defaults with any specified options
// 	4) Parse CLI options and overwrite/add any specified options
//
// The above results in btcd functioning properly without any config settings
// while still allowing the user to override settings with config files and
// command line options.  Command line options always take precedence.
func LoadConfig() (*Config, []string, error) {
	// Default config.
	cfg := Config{
	}

	// Pre-parse the command line options to see if an alternative config
	// file or the version flag was specified.
	preCfg := cfg
	preParser := flags.NewParser(&preCfg, flags.Default)
	_, err := preParser.Parse()
	if err != nil {
		if e, ok := err.(*flags.Error); !ok || e.Type != flags.ErrHelp {
			preParser.WriteHelp(os.Stderr)
		}
		return nil, nil, err
	}

	// Show the version and exit if the version flag was specified.
	appName := filepath.Base(os.Args[0])
	appName = strings.TrimSuffix(appName, filepath.Ext(appName))

	// Load additional config from file.
	parser := flags.NewParser(&cfg, flags.Default)

	// Parse command line options again to ensure they take precedence.
	remainingArgs, err := parser.Parse()
	if err != nil {
		if e, ok := err.(*flags.Error); !ok || e.Type != flags.ErrHelp {
			parser.WriteHelp(os.Stderr)
		}
		return nil, nil, err
	}

	return &cfg, remainingArgs, nil
}
