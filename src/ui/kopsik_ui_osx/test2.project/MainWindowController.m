//
//  MainWindowController.m
//  kopsik_ui_osx
//
//  Created by Tambet Masik on 9/24/13.
//  Copyright (c) 2013 Alari. All rights reserved.
//

#import "MainWindowController.h"
#import "LoginViewController.h"
#import "UIEvents.h"
#import "kopsik_api.h"

@interface MainWindowController ()
@property (nonatomic,strong) IBOutlet LoginViewController *loginViewController;
@end

@implementation MainWindowController

- (id)initWithWindow:(NSWindow *)window
{
  self = [super initWithWindow:window];
  if (self) {
    [[NSNotificationCenter defaultCenter]
      addObserver:self
      selector:@selector(eventHandler:)
      name:kUIEventUserLoggedIn
      object:nil];
    self.loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
  }
  return self;
}

- (void)windowDidLoad
{
  [super windowDidLoad];
    
  char err[KOPSIK_ERR_LEN];
  TogglUser *user = kopsik_user_new();
  if (KOPSIK_API_SUCCESS != kopsik_current_user(err, KOPSIK_ERR_LEN, user)) {
    NSLog(@"Error fetching user: %s", err);
  } else if (!user->ID) {
    [self.contentView addSubview:self.loginViewController.view];
    self.loginViewController.view.frame =self.contentView.bounds;
  } else {
    NSLog(@"Current user: %s", user->Fullname);
  }
  kopsik_user_delete(user);
}

-(void)eventHandler: (NSNotification *) notification
{
  NSLog(@"event triggered");
}

@end
