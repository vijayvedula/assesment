package main

import (
	"productservice/config"
	"productservice/handlers"
	"productservice/middleware"

	"github.com/gin-gonic/gin"
)

func main() {
	config.SetupDatabase()

	r := gin.Default()

	r.POST("/login", handlers.Login)
	r.POST("/generate-token", handlers.GenerateToken)

	auth := r.Group("/")
	auth.Use(middleware.AuthRequired())
	{
		auth.GET("/products", handlers.GetProducts)
		auth.GET("/product/:id", handlers.GetProduct)
		auth.POST("/product", handlers.AddProduct)
	}

	r.Run(":8080")
}
