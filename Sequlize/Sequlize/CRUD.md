 #  SEQULIZE

 ## CRUD

  
 > CREATE

``await User.create({ name: req.body.name, branch: req.body.branch });``

> READ
```
await User.findByPk(id);
await User.findOne({ where: { name: "rahul" } });
await User.findAll();  // returns []
```

> UPDATE
```
const user = await User.findByPk(id);
if (user) await user.update({ name: "Looser" });
// or
await User.update({ name: "Looser" }, { where: { id } });
```

> DELETE

`await User.destroy({ where: { id } });`



## RAW QUERIES

```
const [sortedUsers] = await sequelize.query(`
  SELECT u.id, u.name, COUNT(p.id) AS totalPosts
  FROM "Users" u
  LEFT JOIN "Posts" p
    ON u.id = p.userId
  GROUP BY u.id, u.name
  ORDER BY totalPosts DESC
`);
```

> Replacements

```
// NAMED PARAMTERS
await sequelize.query(
  `SELECT * FROM "Users" WHERE id = :id AND status = :status`,
  { replacements: { id: 1, status: "active" }, type: sequelize.QueryTypes.SELECT }
);

// Positional
await sequelize.query(
  `SELECT * FROM "Users" WHERE id = ? AND status = ?`,
  { replacements: [1, "active"], type: sequelize.QueryTypes.SELECT } //type: sequelize.QueryTypes.RAW without specifying the things like SELECT , UPDATE, directly sequlize can handle what it is...
);
```