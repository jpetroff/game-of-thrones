sqlite3 = require('sqlite3').verbose()

db = new sqlite3.Database './chars.db'

ROWS = 39

seed_die = 20
spread_die = 10

seed_survive = 40
spread_survive = 20

for i in [1..ROWS]
	new_die = Math.floor(seed_die + (Math.random() * 2 * spread_die) - spread_die)
	new_survive = Math.floor(seed_survive + (Math.random() * 2 * spread_survive) - spread_survive)

	console.log '[' + i + ']',new_die, new_survive
	db.run "UPDATE characters SET die=$die, survive=$survive WHERE rowid=$id", {
			$id: i
			$die: new_die
			$survive: new_survive
		}, (err) ->	console.log err if err
