#import "AppDelegate.h"

@interface AppDelegate () <SINServiceDelegate>
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    
    id config = [[SinchService configWithApplicationKey:@"<YOUR_APP_KEY>"
                                      applicationSecret:@"<YOUR_APP_SECRET>"
                                        environmentHost:@"sandbox.sinch.com"]
                 pushNotificationsWithEnvironment:SINAPSEnvironmentAutomatic];
    
    id<SINService> sinch = [SinchService serviceWithConfig:config];
    sinch.delegate = self;
    
    void (^onUserDidLogin)(NSString *) = ^(NSString *userId) {
        [sinch logInUserWithId:userId];
    };
    
    self.sinch = sinch;
    
    
    [[NSNotificationCenter defaultCenter]
     addObserverForName:@"UserDidLoginNotification"
     object:nil
     queue:nil
     usingBlock:^(NSNotification *note) { onUserDidLogin(note.userInfo[@"userId"]); }];
    
    return YES;
}

#pragma mark - SINServiceDelegate

- (void)service:(id<SINService>)service didFailWithError:(NSError *)error {
    NSLog(@"%@", [error localizedDescription]);
}

- (void)service:(id<SINService>)service
     logMessage:(NSString *)message
           area:(NSString *)area
       severity:(SINLogSeverity)severity
      timestamp:(NSDate *)timestamp {
    if (severity == SINLogSeverityCritical) {
        NSLog(@"%@", message);
    }
}

#pragma mark - push

- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [self.sinch.push application:application didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [self.sinch.push application:application didReceiveRemoteNotification:userInfo];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"%@:%@", NSStringFromSelector(_cmd), error);
}

@end
