#import <UIKit/UIKit.h>
#import <Sinch/Sinch.h>
#import <SinchService/SinchService.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) id<SINService> sinch;

@end
