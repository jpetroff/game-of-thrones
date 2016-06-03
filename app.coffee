express = require 'express'
bodyParser = require 'body-parser'
cors = require 'cors'
sqlite3 = require('sqlite3').verbose()

app = do express

db = new sqlite3.Database './chars.db'

# MIDDLEWARES
app.use bodyParser.json()
app.use bodyParser.urlencoded { extended: true }

app.post '/change-stats', (req, res) ->
	return if not req.body

	name = req.body.name
	prediction = req.body.prediction

	console.log req.body

	db.run "UPDATE characters SET " + prediction + " = " + prediction + " + 1 WHERE name = $name", {
			$name: name
		}, (err) ->
			if err
				console.log err
				res.send 'error ' + err
				return

			res.send 'OK'


app.get '/stats', (req, res) ->
	db.all 'SELECT `_rowid_`,* FROM `characters` ORDER BY `_rowid_` ASC LIMIT 0, 50000;', (err, rows) ->
		if err
			console.log err
			res.send 'error '+err
			return

		res.send rows

app.listen '80', '0.0.0.0', () ->
	 console.log '[express-server]: started'
