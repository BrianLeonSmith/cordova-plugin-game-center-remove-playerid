var exec = require('cordova/exec');

var GameCenter = {
    authenticateUser: function (successCallback, errorCallback) {
        exec(successCallback, errorCallback, 'GameCenter', 'authenticateUser', []);
    },
    showLeaderboard: function (leaderboardID, successCallback, errorCallback) {
        exec(successCallback, errorCallback, 'GameCenter', 'showLeaderboard', [leaderboardID]);
    }
};

module.exports = GameCenter;
