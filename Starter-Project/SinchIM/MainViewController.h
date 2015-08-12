#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MainViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *messageView;
@property (weak, nonatomic) IBOutlet UITextField *activeField;
@property (weak, nonatomic) IBOutlet UITextField *destination;
@property (weak, nonatomic) IBOutlet UITextField *message;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

- (IBAction)sendButtonPressed:(id)sender;

@end
