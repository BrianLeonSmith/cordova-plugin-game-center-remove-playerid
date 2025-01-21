
//
//  HelloWorld.m
//  Copyright (c) 2025 Brian Leon Smith <hello@brianleonsmith.com> (https://madebyleon.app/)
//

#import "GameCenter.h"
// #import <Foundation/Foundation.h>
// #import <GameKit/GameKit.h>
#import <Cordova/CDV.h>
// #import <Cordova/CDVViewController.h">

@implementation GameCenter

- (void)authenticateUser:(CDVInvokedUrlCommand*)command {
    
    // // Declare a weak reference
    // __weak GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    // // __weak typeof(self) weakSelf = self;
    // __block CDVPluginResult *pluginResult = nil;

    // localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error) {
    //     if (viewController != nil) {
    //         // Show Game Center authentication screen
    //         [self.viewController presentViewController:viewController animated:YES completion:nil];
    //     } else if (localPlayer.isAuthenticated) {
    //         // User successfully authenticated
    //         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"User authenticated"];
    //     } else {
    //         // Authentication failed
    //         pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.localizedDescription];
    //     }
    //     [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    // };

    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Test authenticateUser function"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)showLeaderboard:(CDVInvokedUrlCommand*)command {
    // NSString *leaderboardID = [command.arguments objectAtIndex:0];
    // GKGameCenterViewController *leaderboardController = [[GKGameCenterViewController alloc] init];
    // if (leaderboardController != nil) {
    //     leaderboardController.gameCenterDelegate = self;
    //     leaderboardController.viewState = GKGameCenterViewControllerStateLeaderboards;
    //     leaderboardController.leaderboardIdentifier = leaderboardID;
    //     [self.viewController presentViewController:leaderboardController animated:YES completion:nil];

    // }

    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Test showLeaderboard function"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

// #pragma mark - GKGameCenterControllerDelegate

// - (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController*)gameCenterViewController {
//     [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
// }

@end
