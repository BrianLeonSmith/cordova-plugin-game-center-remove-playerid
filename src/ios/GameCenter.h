//
//  HelloWorld.m
//  Copyright (c) 2013-2015 Lee Crossley - http://ilee.co.uk
//  Copyright (c) 2025 Brian Leon Smith <hello@brianleonsmith.com> (https://madebyleon.app/)
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import <Cordova/CDV.h>

@interface GameCenter : CDVPlugin <GKGameCenterControllerDelegate>

- (void) auth:(CDVInvokedUrlCommand*)command;
- (void) getPlayerImage:(CDVInvokedUrlCommand*)command;
- (void) submitScore:(CDVInvokedUrlCommand*)command;
- (void) showLeaderboard:(CDVInvokedUrlCommand*)command;
- (void) reportAchievement:(CDVInvokedUrlCommand*)command;
- (void) resetAchievements:(CDVInvokedUrlCommand*)command;
- (void) getAchievements:(CDVInvokedUrlCommand*)command;

@end
