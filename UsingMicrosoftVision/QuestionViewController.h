//
//  QuestionViewController.h
//  UsingMicrosoftVision
//
//  Created by Andy Wu on 2/2/17.
//  Copyright © 2017 sahlitude. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "ConfirmationViewController.h"

@interface QuestionViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, retain) UIImagePickerController *imagePickerController;

@property (nonatomic, retain) ConfirmationViewController *cVC;

@property (weak, nonatomic) IBOutlet UILabel *questionNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *objectToFind;

- (IBAction)startCameraBtn:(UIButton *)sender;

- (IBAction)skipBtn:(UIButton *)sender;

@property int questionNum;

@property BOOL isOfficeObjects;
@property BOOL isHomeFurnishings;
@property BOOL isChallengeObjects;

@property (strong, nonatomic) NSMutableArray *officeObjects;
@property (strong, nonatomic) NSMutableArray *homeFurnishings;
@property (strong, nonatomic) NSMutableArray *challengeObjects;

@property int r;



@end
