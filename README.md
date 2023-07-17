# Fee Management System - Flutter Project
This repository contains a Flutter project for a Fee Management System. The system allows you to manage classes, students, and fee logs. It provides features such as adding classes and students, logging fee payments, deleting classes and students, undoing the last fee log, displaying fee pending status in a list view, viewing log history on the details page, and searching for students.

The project is implemented using the Riverpod state management library and the SqfLite database.

## Project Visuals

###  ----- >>    [Project Demonstration Video]([https://www.example.com](https://youtu.be/K0JE6y_gVjg))  https://youtu.be/K0JE6y_gVjg << -----

### Screenshots

| Home Screen                                | Add Batch                                    | New Student Screen                            |
| ----------------------------------------- | -------------------------------------------- | --------------------------------------------- |
| ![Home Screen](https://github.com/Mr-Manpreet-Singh/studentFeeManagement/blob/main/github_readme_screenshots/home_screen.png) | ![Add Batch](https://github.com/Mr-Manpreet-Singh/studentFeeManagement/blob/main/github_readme_screenshots/add_batch.png) | ![New Student Screen](https://github.com/Mr-Manpreet-Singh/studentFeeManagement/blob/main/github_readme_screenshots/new_student_screen.png) |

| Student List                                | Student Details Screen                                    | Add Log Popup                            |
| ----------------------------------------- | -------------------------------------------- | --------------------------------------------- |
| ![Student List](https://github.com/Mr-Manpreet-Singh/studentFeeManagement/blob/main/github_readme_screenshots/student_list.png) | ![Student Details Screen](https://github.com/Mr-Manpreet-Singh/studentFeeManagement/blob/main/github_readme_screenshots/student_details_screen.png) | ![Add Log Popup](https://github.com/Mr-Manpreet-Singh/studentFeeManagement/blob/main/github_readme_screenshots/add_log_popup.png) |



## Features
- ***Add Class:*** You can add classes to the system by providing the necessary details such as class name, section, and teacher.
- ***Add Student:*** You can add students to a class by providing their details including name, roll number, and contact information.
- ***Add Fee Log:*** You can log fee payments for students, specifying the student, class, payment date, and amount.
- ***Delete Class:*** You have the option to delete a class along with all its associated students and fee logs.
- ***Delete Student:*** You can delete individual students from a class, removing their associated fee logs.
- ***Undo Last Log:*** In case of an accidental fee log entry, you can undo the last payment log and revert the changes.
- ***Fee Pending Status:*** The list view builder displays the fee pending status as a subtitle for each student. It helps you quickly identify students with pending fees.
- ***Log History:*** The details page of a student displays a history of fee logs, allowing you to track their payment records.
- ***Search Student:*** You can search for students by their name, roll number, or any other relevant details. The search functionality helps you find students quickly.


## Dependencies
The project utilizes the following dependencies:

- `flutter_riverpod`: A state management library that provides simple and efficient dependency injection and state management capabilities.
- `sqflite`: A Flutter plugin for SQLite database, used for storing and retrieving data.
- `uuid`: A library for generating unique identifiers (UUIDs).
- `intl`: A Flutter package providing internationalization and localization support.
- `path`: A package for working with file and directory paths.
other necessary Flutter dependencies


## Contributing
Contributions are welcome! If you find any issues or have suggestions for improvements, please feel free to submit a pull request or open an issue.


## License
This project is licensed under the MIT License. You are free to use, modify, and distribute the code for personal and commercial purposes.
