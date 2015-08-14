#import "LoginViewController.h"
#import "AppDelegate.h"

@implementation LoginViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  [self.nameTextField becomeFirstResponder];
}

- (IBAction)onLoginButtonPressed:(id)sender {

    if ([self.nameTextField.text length] == 0) {
        return;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UserDidLoginNotification"
                                                        object:nil
                                                      userInfo:@{@"userId" : self.nameTextField.text}];

    id<SINManagedPush> push = [[(AppDelegate *)[[UIApplication sharedApplication] delegate] sinch] push];
    [push setDisplayName:self.nameTextField.text];
    
    [self performSegueWithIdentifier:@"mainView" sender:nil];
}

@end
