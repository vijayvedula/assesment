package test

import (
	"bytes"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"productservice/config"
	"productservice/handlers"
	"productservice/models"
	"testing"

	"github.com/gin-gonic/gin"
	"github.com/stretchr/testify/assert"
)

func setupRouter() *gin.Engine {
	r := gin.Default()
	r.POST("/login", handlers.Login)
	r.GET("/products", handlers.GetProducts)
	r.GET("/product/:id", handlers.GetProduct)
	r.POST("/product", handlers.AddProduct)
	return r
}

func TestLogin(t *testing.T) {
	router := setupRouter()

	config.DB.Create(&models.User{Username: "admin", Password: "adminpass", Role: "admin"})

	payload := map[string]string{
		"username": "admin",
		"password": "adminpass",
	}
	jsonPayload, _ := json.Marshal(payload)

	w := httptest.NewRecorder()
	req, _ := http.NewRequest("POST", "/login", bytes.NewBuffer(jsonPayload))
	req.Header.Set("Content-Type", "application/json")
	router.ServeHTTP(w, req)

	assert.Equal(t, http.StatusOK, w.Code)
	var response map[string]string
	err := json.Unmarshal(w.Body.Bytes(), &response)
	assert.Nil(t, err)
	assert.NotEmpty(t, response["token"])
}

func TestAddProduct(t *testing.T) {
	router := setupRouter()

	config.DB.Create(&models.User{Username: "admin", Password: "adminpass", Role: "admin"})

	loginPayload := map[string]string{
		"username": "admin",
		"password": "adminpass",
	}
	jsonLoginPayload, _ := json.Marshal(loginPayload)

	w := httptest.NewRecorder()
	req, _ := http.NewRequest("POST", "/login", bytes.NewBuffer(jsonLoginPayload))
	req.Header.Set("Content-Type", "application/json")
	router.ServeHTTP(w, req)

	var loginResponse map[string]string
	json.Unmarshal(w.Body.Bytes(), &loginResponse)
	token := loginResponse["token"]

	productPayload := map[string]interface{}{
		"name":  "TestProduct",
		"price": 100,
	}
	jsonProductPayload, _ := json.Marshal(productPayload)

	w = httptest.NewRecorder()
	req, _ = http.NewRequest("POST", "/product", bytes.NewBuffer(jsonProductPayload))
	req.Header.Set("Content-Type", "application/json")
	req.Header.Set("Authorization", token)
	router.ServeHTTP(w, req)

	assert.Equal(t, http.StatusOK, w.Code)
	var productResponse models.Product
	json.Unmarshal(w.Body.Bytes(), &productResponse)
	assert.Equal(t, "TestProduct", productResponse.Name)
	assert.Equal(t, uint(100), productResponse.Price)
}
