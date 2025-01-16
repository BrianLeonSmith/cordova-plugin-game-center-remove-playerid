//
//  GameCenter.h
//  Copyright (c) 2013-2015 Lee Crossley - http://ilee.co.uk
//

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import <GameKit/GameKit.h>
#import "GameCenter.h"

@interface GameCenter : CDVPlugin <GKGameCenterControllerDelegate>

- (void) auth:(CDVInvokedUrlCommand*)command;
- (void) getPlayerImage:(CDVInvokedUrlCommand*)command;
- (void) submitScore:(CDVInvokedUrlCommand*)command;
- (void) showLeaderboard:(CDVInvokedUrlCommand*)command;
- (void) reportAchievement:(CDVInvokedUrlCommand*)command;
- (void) resetAchievements:(CDVInvokedUrlCommand*)command;
- (void) getAchievements:(CDVInvokedUrlCommand*)command;

@end
