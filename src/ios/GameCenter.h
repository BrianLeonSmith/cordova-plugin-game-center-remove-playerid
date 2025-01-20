//
//  HelloWorld.m
//  Copyright (c) 2025 Brian Leon Smith <hello@brianleonsmith.com> (https://madebyleon.app/)
//

#import <Cordova/CDVPlugin.h>
#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@interface GameCenter : CDVPlugin <GKGameCenterControllerDelegate>

- (void) authenticateUser:(CDVInvokedUrlCommand*)command;
- (void) showLeaderboard:(CDVInvokedUrlCommand*)command;

@end
