express = require('express')
router = express.Router()

#GET users listing.
router.get '/', (req, res) ->
	res.send('respond with a resource user')

module.exports = router
