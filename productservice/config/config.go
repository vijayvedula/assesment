package config

import (
	"productservice/models"

	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/sqlite"
)

var DB *gorm.DB
var err error

func SetupDatabase() {
	DB, err = gorm.Open("sqlite3", ":memory:")
	if err != nil {
		panic("failed to connect database")
	}
	DB.AutoMigrate(&models.Product{}, &models.User{})

	// Insert initial data into users table
	DB.Create(&models.User{Username: "admin", Password: "adminpass", Role: "admin"})
	DB.Create(&models.User{Username: "user", Password: "userpass", Role: "user"})
}
