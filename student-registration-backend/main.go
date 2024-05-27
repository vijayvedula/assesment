package main

import (
	"log"
	"net/http"
	"student-registration-backend/controller"
	"student-registration-backend/model"
	"student-registration-backend/repository"
	"student-registration-backend/service"

	"github.com/golang-migrate/migrate/v4"
	migratePostgres "github.com/golang-migrate/migrate/v4/database/postgres" // Aliased import
	_ "github.com/golang-migrate/migrate/v4/source/file"
	"github.com/gorilla/mux"
	gormPostgres "gorm.io/driver/postgres" // Aliased import
	"gorm.io/gorm"
)

func main() {
	// Sample DSN value
	dsn := "host=mydatabase.cv8a6qycwhd9.us-west-2.rds.amazonaws.com user=myusername password=mypassword dbname=postgres port=5432 sslmode=disable"

	db, err := gorm.Open(gormPostgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal(err)
	}

	// Run database migrations
	runMigrations(dsn)

	db.AutoMigrate(&model.Student{})

	studentRepo := &repository.StudentRepository{DB: db}
	studentService := &service.StudentService{Repo: studentRepo}
	studentController := &controller.StudentController{Service: studentService}

	router := mux.NewRouter()
	router.HandleFunc("/api/students", studentController.CreateStudent).Methods("POST")
	router.HandleFunc("/api/students", studentController.GetAllStudents).Methods("GET")

	log.Println("Server is running on port 8080")
	log.Fatal(http.ListenAndServe(":8080", router))
}

func runMigrations(dsn string) {
	db, err := gorm.Open(gormPostgres.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal("failed to connect database:", err)
	}

	sqlDB, err := db.DB()
	if err != nil {
		log.Fatal("failed to get database handle:", err)
	}

	driver, err := migratePostgres.WithInstance(sqlDB, &migratePostgres.Config{})
	if err != nil {
		log.Fatal("failed to create migration driver:", err)
	}

	m, err := migrate.NewWithDatabaseInstance(
		"file://migrations",
		"postgres", driver)
	if err != nil {
		log.Fatal("failed to create migration instance:", err)
	}

	err = m.Up()
	if err != nil && err != migrate.ErrNoChange {
		log.Fatal("failed to run migrations:", err)
	}

	log.Println("Database migrations applied successfully")
}
