u = User.create(username: 'test', email: "test@email.com")
u.password = 'test'
u.save

Pokemon.create(name:"Pikachu", cp: 100)
Pokemon.create(name:"Wartortle", cp: 50)