var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res) {
  res.render('index', { title: 'Express' });
});

/* GET Userlist page. */
router.get('/data', function(req, res) {
    var db = req.db;
    var collection = db.get('usercollection');
    collection.find({},{},function(e,docs){
    	// console.log(docs);
        res.render('data', {
            "data" : docs
        });
    });
});


// Requires time, lon, and lat
router.post('/addData', function(req, res) {
	console.log("hello");
	var db = req.db;
	var collection = db.get('usercollection');
	var post = req.body;
	if (post.time && post.lon && post.lat) {
		console.log(post);
		collection.insert(post,function (err, doc) {});
	}else {
		console.log("Not in");
	}

	res.send("yes");

});


module.exports = router;

