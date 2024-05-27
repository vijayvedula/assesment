package controller

import (
	"encoding/json"
	"net/http"
	"student-registration-backend/model"
	"student-registration-backend/service"
)

type StudentController struct {
	Service *service.StudentService
}

func (c *StudentController) CreateStudent(w http.ResponseWriter, r *http.Request) {
	var student model.Student
	json.NewDecoder(r.Body).Decode(&student)
	createdStudent, err := c.Service.CreateStudent(student)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	json.NewEncoder(w).Encode(createdStudent)
}

func (c *StudentController) GetAllStudents(w http.ResponseWriter, r *http.Request) {
	students, err := c.Service.GetAllStudents()
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	json.NewEncoder(w).Encode(students)
}
