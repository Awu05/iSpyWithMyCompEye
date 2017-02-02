//
//  ConfirmationViewController.h
//  UsingMicrosoftVision
//
//  Created by Juliana Strawn on 2/2/17.
//  Copyright © 2017 sahlitude. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

//The object the user just tried to take a picture of
@property (weak, nonatomic) IBOutlet UILabel *currentObject;

//The photo the user just took
@property (weak, nonatomic) IBOutlet UIImageView *photo;

//This displays whether the user got the item correct or not
@property (weak, nonatomic) IBOutlet UITextView *confirmationTextView;

//This button either tells you the next object to take a picture of, or if the user has already taken 10 photos, it brings them to the screen with their final score
@property (weak, nonatomic) IBOutlet UIButton *nextObject;
- (IBAction)didPressNextButton:(id)sender;

@property (retain, nonatomic) NSData *imgData;

@property (retain, nonatomic) NSDictionary *dictToParse;

@property (retain, nonatomic) NSString *itemToFind;

@property BOOL didItemMatch;

@end
