package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/joho/godotenv"
	_ "github.com/lib/pq"
)

func main(){
	fmt.Printf("This is the Api for the Iris project !")

	godotenv.Load()

	portStr:= os.Getenv("PORT")

	if portStr == "" {
		log.Fatal("PORT is not found in environment")
	}

	log.Printf("Server running on port %v", portStr)

	dbURL := os.Getenv("DB_URL")

	if dbURL == "" {
		log.Fatal("DB_URL is not found in the environment")
	}


	srv := &http.Server{
		Addr: ":" + portStr,
	}

	err := srv.ListenAndServe()
	if err != nil{
		log.Fatal(err)
	}
}