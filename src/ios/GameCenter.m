//
//  HelloWorld.m
//  Copyright (c) 2013-2015 Lee Crossley - http://ilee.co.uk
//  Copyright (c) 2025 Brian Leon Smith <hello@brianleonsmith.com> (https://madebyleon.app/)
//

#import "GameCenter.h"
#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import <Cordova/CDV.h>
#import <Cordova/CDVViewController.h>

@implementation GameCenter

- (void) auth:(CDVInvokedUrlCommand*)command {
    
    // Run the task on a background thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        __weak GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
        __block CDVPluginResult *pluginResult = nil;

        localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error) {
            if (viewController != nil) {
                // Show Game Center authentication screen
                [self.viewController presentViewController:viewController animated:YES completion:nil];
            }
            else if (localPlayer.isAuthenticated) {
                // User successfully authenticated
                NSDictionary* user = @{
                    @"alias":localPlayer.alias ?: @"",
                    @"displayName":localPlayer.displayName ?: @""
                };
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:user];
            }
            else {
                // Authentication failed
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.localizedDescription];
            }
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        };
        
    });
}

- (void) getPlayerImage:(CDVInvokedUrlCommand*)command {
    
    __weak GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    __block CDVPluginResult* pluginResult = nil;

    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent: @"user.jpg" ];

    // Check if the user photo is cached
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:path];

    if (fileExists) {
        // Return it if it does
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:path];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
    else {
        // Else load it from the game center
        [localPlayer loadPhotoForSize:GKPhotoSizeSmall withCompletionHandler:^(UIImage *photo, NSError *error) {
            if (photo != nil) {
                NSData* data = UIImageJPEGRepresentation(photo, 0.8);
                [data writeToFile:path atomically:YES];
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:path];
            }
            if (error != nil) {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error localizedDescription]];
            }
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
    }
}

- (void) submitScore:(CDVInvokedUrlCommand*)command {
    
    NSMutableDictionary *args = [command.arguments objectAtIndex:0];
    int64_t score = [[args objectForKey:@"score"] integerValue];
    NSString *leaderboardId = [args objectForKey:@"leaderboardId"];

    __block CDVPluginResult* pluginResult = nil;

    // Different methods depending on iOS version
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        GKScore *scoreSubmitter = [[GKScore alloc] initWithLeaderboardIdentifier: leaderboardId];
        scoreSubmitter.value = score;
        scoreSubmitter.context = 0;

        [GKScore reportScores:@[scoreSubmitter] withCompletionHandler:^(NSError *error) {
            if (error) {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error localizedDescription]];
            }
            else {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Score submitted"];
            }
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
    }
    else {
        GKScore *scoreSubmitter = [[GKScore alloc] initWithLeaderboardIdentifier:leaderboardId];
        scoreSubmitter.value = score;

        [GKScore reportScores:@[scoreSubmitter] withCompletionHandler:^(NSError *error) {
            if (error) {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error localizedDescription]];
            }
            else {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            }
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
    }
}

- (void) showLeaderboard:(CDVInvokedUrlCommand*)command {

    // Run the task on a background thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

        // Switch to the main thread for GameKit or UI updates
        dispatch_async(dispatch_get_main_queue(), ^{
        
            NSString *leaderboardID = [command.arguments objectAtIndex:0];
            GKGameCenterViewController *leaderboardController = [[GKGameCenterViewController alloc] init];
            if (leaderboardController != nil) {
                leaderboardController.gameCenterDelegate = self;
                leaderboardController.viewState = GKGameCenterViewControllerStateLeaderboards;
                leaderboardController.leaderboardIdentifier = leaderboardID;
                [self.viewController presentViewController:leaderboardController animated:YES completion:nil];
            }

        });
    });
}

- (void) reportAchievement:(CDVInvokedUrlCommand*)command {
    
    NSMutableDictionary *args = [command.arguments objectAtIndex:0];
    NSString *achievementId = [args objectForKey:@"achievementId"];
    NSString *percent = [args objectForKey:@"percent"];

    float percentFloat = [percent floatValue];

    __block CDVPluginResult* pluginResult = nil;

    GKAchievement *achievement = [[GKAchievement alloc] initWithIdentifier: achievementId];
    if (achievement) {
        achievement.percentComplete = percentFloat;
        achievement.showsCompletionBanner = YES;

        NSArray *achievements = [NSArray arrayWithObjects:achievement, nil];

        [GKAchievement reportAchievements:achievements withCompletionHandler:^(NSError *error) {
            if (error != nil) {
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error localizedDescription]];
            }
            else {
                // Achievement notification banners are broken on iOS 7 so we do it manually here if 100%:
                if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 &&
                    [[[UIDevice currentDevice] systemVersion] floatValue] < 8.0 &&
                    floorf(percentFloat) >= 100)
                {
                    [GKNotificationBanner showBannerWithTitle:@"Achievement" message:@"Completed!" completionHandler:^{}];
                }
                
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Achievement reported"];
            }
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
    }
}

- (void) resetAchievements:(CDVInvokedUrlCommand*)command {
    __block CDVPluginResult* pluginResult = nil;

    // Clear all progress saved on Game Center.
    [GKAchievement resetAchievementsWithCompletionHandler:^(NSError *error) {
         if (error != nil) {
             pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[error localizedDescription]];
         }
         else {
             pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Achievements reset"];
         }
         [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
     }
    ];
}

- (void) getAchievements:(CDVInvokedUrlCommand*)command {
    
     __block CDVPluginResult* pluginResult = nil;
     NSMutableArray *earntAchievements = [NSMutableArray array];

     [GKAchievement loadAchievementsWithCompletionHandler:^(NSArray *achievements, NSError *error) {
         if (error == nil) {
             for (GKAchievement* achievement in achievements) {
                 NSMutableDictionary *entry = [NSMutableDictionary dictionary];
                 entry[@"identifier"] = achievement.identifier;
                 entry[@"percentComplete"] = [NSNumber numberWithDouble: achievement.percentComplete];
                 entry[@"completed"] = [NSNumber numberWithBool:achievement.completed];
                 entry[@"lastReportedDate"] = [NSNumber numberWithDouble:[achievement.lastReportedDate timeIntervalSince1970] * 1000];
                 entry[@"showsCompletionBanner"] = [NSNumber numberWithBool:achievement.showsCompletionBanner];

                 [earntAchievements addObject:entry];
             }
             pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray: earntAchievements];
         }
         else {
             pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
         }
         [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
     }];
}

// #pragma mark - GKGameCenterControllerDelegate

- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController*)gameCenterViewController {
   [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
