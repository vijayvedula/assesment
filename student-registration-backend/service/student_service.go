package service

import (
	"student-registration-backend/model"
	"student-registration-backend/repository"
)

type StudentService struct {
	Repo *repository.StudentRepository
}

func (s *StudentService) CreateStudent(student model.Student) (model.Student, error) {
	return s.Repo.Save(student)
}

func (s *StudentService) GetAllStudents() ([]model.Student, error) {
	return s.Repo.GetAll()
}
