package main

import "fmt"

func main() {
	go func() {
		fmt.Print("firtGO im comeBack")
	}()

	fmt.Println("fistGo v0.1")

	select {}
}
