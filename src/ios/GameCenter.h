//
//  HelloWorld.m
//  Copyright (c) 2025 Brian Leon Smith <hello@brianleonsmith.com> (https://madebyleon.app/)
//

// #import <Foundation/Foundation.h>
// #import <GameKit/GameKit.h>
#import <Cordova/CDV.h>

@interface GameCenter : CDVPlugin // <GKGameCenterControllerDelegate>

- (void)authenticateUser:(CDVInvokedUrlCommand*)command;
- (void)showLeaderboard:(CDVInvokedUrlCommand*)command;

@end
