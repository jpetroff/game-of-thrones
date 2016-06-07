sqlite3 = require('sqlite3').verbose()

db = new sqlite3.Database './chars.db'

db.each "SELECT fullname, name, die, survive FROM characters", (err, row) ->
	
