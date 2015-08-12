#import "MainViewController.h"

// This category for the MainViewController serves only to separate code that
// is directly related to the usage of the Sinch SDK, from code that is used
// for improving the look and feel of the sample app.

// Nothing magic here, just regular code interacting with the iOS SDK.

@interface MainViewController (UIAdjustments) <UITextFieldDelegate>

@end

@implementation MainViewController (UIAdjustments)

- (void)viewDidLoad {
  [super viewDidLoad];

  self.messageView.dataSource = self;
  self.messageView.delegate = self;

  // Remove separator lines in table view
  self.messageView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  self.destination.delegate = self;
  self.message.delegate = self;

  // Add keyboard related logic
  [self registerForKeyboardNotifications];

  UITapGestureRecognizer *tap;
  tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
  [self.view addGestureRecognizer:tap];
}

#pragma mark - Keyboard handling

- (void)registerForKeyboardNotifications {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillBeHidden:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
}

- (void)keyboardWillShow:(NSNotification *)note {
  // Adjust the bottom constraint to make room for the keyboard.
  CGRect keyboardFrameEnd = [[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
  self.bottomConstraint.constant = keyboardFrameEnd.size.height;
}

- (void)keyboardWillBeHidden:(NSNotification *)aNotification {
  // Restores the bottom constraint to zero, making the view span the screen.
  self.bottomConstraint.constant = 0;
  [self.messageView reloadData];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
  self.activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
  self.activeField = nil;
}

- (void)dismissKeyboard {
  [self.activeField resignFirstResponder];
}

@end