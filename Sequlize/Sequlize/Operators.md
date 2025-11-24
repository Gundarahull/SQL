 #  SEQULIZE

 ## OPERATORS with Aggregate Functions


> Aggregate Functions
 ```

 const { Sequelize } = require("sequelize");
const sequelize = require("./db");
const User = require("./models/User");

 const result = await User.findAll({
  attributes: [
    // COUNT
    [sequelize.fn("COUNT", sequelize.col("id")), "totalUsers"],

    // SUM
    [sequelize.fn("SUM", sequelize.col("age")), "sumAge"],

    // AVG
    [sequelize.fn("AVG", sequelize.col("age")), "avgAge"],

    // MIN
    [sequelize.fn("MIN", sequelize.col("age")), "minAge"],

    // MAX
    [sequelize.fn("MAX", sequelize.col("age")), "maxAge"],

    // COUNT DISTINCT
    [sequelize.fn("COUNT", sequelize.fn("DISTINCT", sequelize.col("branch"))), "uniqueBranches"]
  ]
});
```

> GROUP BY AND ORDER BY 

```
const data = await User.findAll({
  attributes: [
    "branch",
    [sequelize.fn("COUNT", sequelize.col("id")), "total"]
  ],
  group: ["branch"],
  order: [["createdAt", "DESC"]] //its main
  order: [[sequelize.fn("COUNT", sequelize.col("id")), "DESC"]]
});
```

---------------------------------------------------------------------------------------------------------------------------------

> ## Comparison Operators

 | SQL                         | Sequelize Example                        |
| --------------------------- | ---------------------------------------- |
| `age = 25`                  | `{ age: 25 }`                            |
| `age != 25`                 | `{ age: { [Op.ne]: 25 } }`               |
| `age > 25`                  | `{ age: { [Op.gt]: 25 } }`               |
| `age >= 25`                 | `{ age: { [Op.gte]: 25 } }`              |
| `age < 25`                  | `{ age: { [Op.lt]: 25 } }`               |
| `age <= 25`                 | `{ age: { [Op.lte]: 25 } }`              |
| `age BETWEEN 20 AND 30`     | `{ age: { [Op.between]: [20, 30] } }`    |
| `age NOT BETWEEN 20 AND 30` | `{ age: { [Op.notBetween]: [20, 30] } }` |

---------------------------------------------------------------------------------------------------------------------------------

> ## Logical Operators

| SQL                           | Sequelize Example                                             |
| ----------------------------- | ------------------------------------------------------------- |
| `age > 18 AND branch = 'CSE'` | `{ [Op.and]: [{ age: { [Op.gt]: 18 } }, { branch: "CSE" }] }` |
| `age > 18 OR branch = 'ECE'`  | `{ [Op.or]: [{ age: { [Op.gt]: 18 } }, { branch: "ECE" }] }`  |
| `NOT (branch = 'CSE')`        | `{ branch: { [Op.not]: "CSE" } }`                             |


---------------------------------------------------------------------------------------------------------------------------------

> ## Set Operators

| SQL                           | Sequelize Example                            |
| ----------------------------- | -------------------------------------------- |
| `branch IN ('CSE','ECE')`     | `{ branch: { [Op.in]: ["CSE", "ECE"] } }`    |
| `branch NOT IN ('CSE','ECE')` | `{ branch: { [Op.notIn]: ["CSE", "ECE"] } }` |


---------------------------------------------------------------------------------------------------------------------------------

> ## Null Checks

| SQL                  | Sequelize Example                |
| -------------------- | -------------------------------- |
| `branch IS NULL`     | `{ branch: { [Op.is]: null } }`  |
| `branch IS NOT NULL` | `{ branch: { [Op.not]: null } }` |

-----------------------------------------------------------------------------------------------------------------------
