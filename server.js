var express= require ("express");
var app = express();

app.get("/url",(req,res,next) => {
res.json({"message":"Automate all the things yesterday!","timestamp":Math.floor(Date.now() / 1000)});
});

//app.listen (3000, () => {
//    console.log("Server running on port 3000")
//});

module.exports = app;

