package repository

import (
	"student-registration-backend/model"

	"gorm.io/gorm"
)

type StudentRepository struct {
	DB *gorm.DB
}

func (r *StudentRepository) Save(student model.Student) (model.Student, error) {
	err := r.DB.Create(&student).Error
	return student, err
}

func (r *StudentRepository) GetAll() ([]model.Student, error) {
	var students []model.Student
	err := r.DB.Find(&students).Error
	return students, err
}
