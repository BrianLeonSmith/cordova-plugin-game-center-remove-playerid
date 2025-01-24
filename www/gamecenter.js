var exec = require('cordova/exec');

var GameCenter = {
    auth: function (successCallback, errorCallback) {
        exec(successCallback, errorCallback, 'GameCenter', 'auth', []);
    },
    getPlayerImage: function (successCallback, errorCallback) {
        exec(successCallback, errorCallback, 'GameCenter', 'getPlayerImage', []);
    },
    submitScore: function (successCallback, errorCallback, score) {
        exec(successCallback, errorCallback, "GameCenter", "submitScore", [score]);
    },
    showLeaderboard: function (successCallback, errorCallback, leaderboardID) {
        exec(successCallback, errorCallback, 'GameCenter', 'showLeaderboard', [leaderboardID]);
    },
    reportAchievement: function (successCallback, errorCallback, achievement) {
        exec(successCallback, errorCallback, 'GameCenter', 'reportAchievement', [achievement]);
    },
    resetAchievements: function (successCallback, errorCallback) {
        exec(successCallback, errorCallback, 'GameCenter', 'resetAchievements', []);
    },
    getAchievements: function (successCallback, errorCallback) {
        exec(successCallback, errorCallback, 'GameCenter', 'getAchievements', []);
    }
};

module.exports = GameCenter;