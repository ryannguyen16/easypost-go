package main

import (
	"encoding/json"
	"fmt"
	"os"

	"github.com/EasyPost/easypost-go/v2"
)

func main() {
	apiKey := os.Getenv("EASYPOST_API_KEY")
	if apiKey == "" {
		fmt.Fprintln(os.Stderr, "missing API key")
		os.Exit(1)
		return
	}
	client := easypost.New(apiKey)

	// Retrieve a list of addresses
	address, err := client.ListAddresses(
		&easypost.ListOptions{
			// options here
		},
	)
	if err != nil {
		fmt.Fprintln(os.Stderr, "error retrieving addresses:", err)
		os.Exit(1)
		return
	}

	prettyJSON, err := json.MarshalIndent(address, "", "    ")
	if err != nil {
		fmt.Fprintln(os.Stderr, "error creating JSON:", err)
		os.Exit(1)
		return
	}
	fmt.Println(string(prettyJSON))
}
