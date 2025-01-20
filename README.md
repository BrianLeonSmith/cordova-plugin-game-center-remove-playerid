## Game Center Plugin for Apache Cordova

#### ⚠️ Please note this is a work in progress and may not work as intended

This plugin allows developers to utilise the iOS Game Center in their Cordova app.

### Before you start

Adding Game Center support requires more than simple coding changes. To create a Game Center-aware game, you need to understand these basics before you begin writing code. The full outline of all the Game Center concepts and impacts can be viewed [here](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/GameKit_Guide/GameCenterOverview/GameCenterOverview.html).

## Install

#### Latest published version on npm (with Cordova CLI >= 6.0.0)

```
cordova plugin add cordova-plugin-game-center-remove-playerid
```

#### Latest version from GitHub

```
cordova plugin add https://github.com/BrianLeonSmith/cordova-plugin-game-center-remove-playerid.git
```

You **do not** need to reference any JavaScript, the Cordova plugin architecture will add a gamecenter object to your root automatically when you build. It will also automatically add the GameKit framework dependency.

## Usage

### Authentication

Call this after your deviceready event has fired.

```
var successCallback = (success) => {
    alert("Success: " + success);
};

var failureCallback = (err) => {
    alert("Error: " + err);
};

GameCenter.authenticateUser(successCallback, failureCallback);
```

### Show leaderboard

Launches the native Game Center leaderboard view controller for a leaderboard.

```
GameCenter.showLeaderboard("board1", successCallback, failureCallback);
```

## Platforms

- ios
