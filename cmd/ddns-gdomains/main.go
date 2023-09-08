package main

import (
	"ddns-gdomains/internal/config"
	"fmt"
	"log"
)

func main() {
	cnf, err := config.New()
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println(cnf)
}
