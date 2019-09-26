package main

import (
	"net/http"
	"os"
	"regexp"
)

func main() {
	accepted := "[2-4]{1}[0-9]{2}"
	if len(os.Args) > 2 {
		accepted = os.Args[2]
	}

	res, err := http.Head(os.Args[1])
	if err != nil || res == nil {
		os.Exit(1)
	}

	matched, err := regexp.MatchString(accepted, string(res.Status))
	if err != nil || matched == false {
		os.Exit(1)
	}

	os.Exit(0)
}
