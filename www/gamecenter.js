
var exec = cordova.require("cordova/exec");

var GameCenter = {
    testFunction: function (success, failure, data) {
        exec(success, failure, "GameCenter", "testFunction", [data]);
    }
}

module.exports = GameCenter;





// var GameCenter = function () {
//     this.name = "GameCenter";
// };

// GameCenter.prototype.echo = function (success, failure) {
//     window.cordova.exec(success, failure, "GameCenter", "echo", [data]);
// };

// GameCenter.prototype.auth = function (success, failure) {
//     exec(success, failure, "GameCenter", "auth", []);
// };

// GameCenter.prototype.getPlayerImage = function (success, failure) {
//     exec(success, failure, "GameCenter", "getPlayerImage", []);
// };

// GameCenter.prototype.submitScore = function (success, failure, data) {
//     exec(success, failure, "GameCenter", "submitScore", [data]);
// };

// GameCenter.prototype.showLeaderboard = function (success, failure, data) {
//     exec(success, failure, "GameCenter", "showLeaderboard", [data]);
// };

// GameCenter.prototype.reportAchievement = function (success, failure, data) {
//     exec(success, failure, "GameCenter", "reportAchievement", [data]);
// };
               
// GameCenter.prototype.resetAchievements = function (success, failure) {
//     exec(success, failure, "GameCenter", "resetAchievements", []);
// };

// GameCenter.prototype.getAchievements = function (success, failure) {
//     exec(success, failure, "GameCenter", "getAchievements", []);
// };

// module.exports = new GameCenter();
