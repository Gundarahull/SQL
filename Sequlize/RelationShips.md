> # SEQULIZE

## RELEATIONSHIPS

### TAKE EXAMPLE
```
***********************************************************************************************
// One Brand has many Models
VehicleBrand.hasMany(VehicleModel, { foreignKey: "vehicle_brand_id" });

// One Model belongs to a Brand
VehicleModel.belongsTo(VehicleBrand, { foreignKey: "vehicle_brand_id" });

vehicle_brand_id is need to be present in the VehicleModel, then we need to allign with main model(VehicleBrand)
************************************************************************************************
```



> ### ✨ One-to-One (1:1) Relationship

-     	A person has one passport.
      One passport belongs to exactly one person.

```
// Person Model
const Person = sequelize.define("Person", {
  name: DataTypes.STRING
});
// Sequelize will automatically create id as INTEGER + autoIncrement.

// Passport Model
const Passport = sequelize.define("Passport", {
  number: DataTypes.STRING
});

// Relationship
Person.hasOne(Passport, { foreignKey: "personId" });  // Person → Passport >> hasOne / hasMany → determines where the foreign key lives, Creates a personId column in the Passport table (the target), “Each Person can have one Passport.
Passport.belongsTo(Person, { foreignKey: "personId" }); // Passport → Person // Each Passport belongs to a Person
```

- Query

```
const peopleWithPassports = await Person.findAll({
  include: {
    model: Passport,
  }
});
```

> ### One-to-Many (1:N) relationship

```
const { Sequelize, DataTypes } = require("sequelize");
const sequelize = new Sequelize("sqlite::memory:"); // Example DB

// Teacher Model
const Teacher = sequelize.define("Teacher", {
  name: DataTypes.STRING
});

// Student Model
const Student = sequelize.define("Student", {
  name: DataTypes.STRING
});


// A Teacher can have many Students
Teacher.hasMany(Student, { foreignKey: "teacherId" });

// A Student belongs to one Teacher
Student.belongsTo(Teacher, { foreignKey: "teacherId" });

✅ Key Points

Teacher.hasMany(Student) → target table is Student, foreign key teacherId will live there.

Student.belongsTo(Teacher) → sets up the reverse association and helper methods (student.getTeacher()).

Sequelize automatically creates teacherId in the Student table unless you define it explicitly.



```

- Query

```
const teachersWithStudents = await Teacher.findAll({
  include: Student
});
```

> ### ✨Many-to-Many (M:N) relationship

- Students ↔ Courses
-     A student can enroll in many courses, and a course can have many students.

```
	const { Sequelize, DataTypes } = require("sequelize");
const sequelize = new Sequelize("sqlite::memory:");

// Student Model
const Student = sequelize.define("Student", {
  name: DataTypes.STRING
});

// Course Model
const Course = sequelize.define("Course", {
  title: DataTypes.STRING
});

// Through table is automatically created as "StudentCourses" unless you specify
Student.belongsToMany(Course, { through: "Enrollments" });
Course.belongsToMany(Student, { through: "Enrollments" });

```

HELPER METHODS

| Method                   | Description                                          | Example                                                               |
| ------------------------ | ---------------------------------------------------- | --------------------------------------------------------------------- |
| `getCourses()`           | Fetch all courses for a student                      | `const courses = await student.getCourses();`                         |
| `setCourses(courses)`    | Replace all current courses with new ones            | `await student.setCourses([math, english]);`                          |
| `addCourse(course)`      | Add a single course                                  | `await student.addCourse(math);`                                      |
| `addCourses(courses)`    | Add multiple courses                                 | `await student.addCourses([math, english]);`                          |
| `removeCourse(course)`   | Remove a single course                               | `await student.removeCourse(math);`                                   |
| `removeCourses(courses)` | Remove multiple courses                              | `await student.removeCourses([math, english]);`                       |
| `hasCourse(course)`      | Check if a student is associated with a course       | `const enrolled = await student.hasCourse(math);`                     |
| `hasCourses(courses)`    | Check if student is associated with multiple courses | `const enrolledAll = await student.hasCourses([math, english]);`      |
| `countCourses()`         | Count how many courses a student has                 | `const total = await student.countCourses();`                         |
| `createCourse(values)`   | Create a new course and associate it automatically   | `const newCourse = await student.createCourse({ title: "History" });` |

- Query

```
const bob = await Student.create({ name: "Bob" });
const alice = await Student.create({ name: "Alice" });

const math = await Course.create({ title: "Math" });
const english = await Course.create({ title: "English" });

// Associate students with courses
await bob.addCourse(math);       // Bob → Math
await bob.addCourse(english);    // Bob → English
await alice.addCourse(math);     // Alice → Math

const students = await Student.findAll({ include: Course });
console.log(JSON.stringify(students, null, 2));

// Express API: Add Course to Student
app.post("/student/add-course", async (req, res) => {
  try {
    const { studentId, course } = req.body;

    // 1️⃣ Find the student
    const student = await Student.findByPk(studentId);
    if (!student) {
      return res.status(404).json({ message: "Student not found" });
    }

    // 2️⃣ Create the course (or find existing one if needed)
    const [newCourse, created] = await Course.findOrCreate({
      where: { title: course.title },
      defaults: course
    });

    // 3️⃣ Associate course with student
    await student.addCourse(newCourse);

    // 4️⃣ Fetch updated student with courses
    const updatedStudent = await Student.findByPk(studentId, { include: Course });

    res.json({ message: "Course added successfully", student: updatedStudent });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Internal Server Error" });
  }
});

```

#### JOINS

> LEFT JOIN

```

const peopleWithPassports = await Person.findAll({
  include: {
    model: Passport,
    required: false // LEFT OUTER JOIN
  }
});
```

> RIGHT JOIN

```
const result = await Person.findAll({
  include: {
    model: Passport,
    required: false,
    right: true // not all DBs support this
  }
});
```

### WITHOUT RelationShips

```
const users = await User.findAll({
  include: [
    {
      model: Post,
      on: {
        userId: Sequelize.where(
          Sequelize.col("User.id"),
          "=",
          Sequelize.col("Post.userId")
        )
      },
      required: true   // INNER JOIN
    }
  ]
});

```

```

// in custom join conditions
const peopleWithPassports = await Person.findAll({
  include: [
    {
      model: Passport,
      on: {
        [Sequelize.Op.and]: [
          Sequelize.where(Sequelize.col("Person.id"), "=", Sequelize.col("Passport.personId")),
          Sequelize.where(Sequelize.col("Person.someID"), "=", Sequelize.col("Passport.passportSomeID"))
        ]
      },
      required: true // INNER JOIN
    }
  ]
});


```



