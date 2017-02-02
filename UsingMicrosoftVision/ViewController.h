//
//  ViewController.h
//  UsingMicrosoftVision
//
//  Created by Jesse Sahli on 1/31/17.
//  Copyright © 2017 sahlitude. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "QuestionViewController.h"

@interface ViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
- (IBAction)pickImage:(id)sender;
- (IBAction)sendImageFromURL:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *urlTextField;

@end

