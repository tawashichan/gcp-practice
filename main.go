package main

import (
	"fmt"
	"net/http"
)

func healthCheck(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, `{"result": "ok"}`)
}

func main() {
	http.HandleFunc("/health_check", healthCheck)
	http.ListenAndServe(":8080", nil)
}
