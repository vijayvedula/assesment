package model

type Student struct {
	ID     int    `json:"id" gorm:"primaryKey"`
	Name   string `json:"name"`
	Email  string `json:"email"`
	Course string `json:"course"`
}
