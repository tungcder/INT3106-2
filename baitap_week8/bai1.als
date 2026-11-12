
sig Lecturer {}

sig Course {
    teacher: one Lecturer,
    prereq: set Course
}

sig Student {
    enrolled: set Course,
    advisor: lone Lecturer
}

run {} for 5