package models

import (
	"github.com/jinzhu/gorm"
)

type Product struct {
	gorm.Model
	Name  string `json:"name"`
	Price uint   `json:"price"`
}

type User struct {
	ID       uint   `json:"id" gorm:"primary_key"`
	Username string `json:"username"`
	Password string `json:"password"`
	Role     string `json:"role"`
}
