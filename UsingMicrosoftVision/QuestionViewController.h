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

@property (nonatomic, retain) NSString *item;

- (IBAction)startCameraBtn:(UIButton *)sender;

- (IBAction)skipBtn:(UIButton *)sender;

@property int questionNum;

@property BOOL isOfficeObjects;
@property BOOL isHomeFurnishings;
@property BOOL isChallengeObjects;

@property (strong, nonatomic) NSMutableArray *officeObjects;
@property (strong, nonatomic) NSMutableArray *homeFurnishings;
@property (strong, nonatomic) NSMutableArray *challengeObjects;

@property (weak, nonatomic) IBOutlet UIButton *quitButton;
- (IBAction)didPressQuitButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *heart1;
@property (weak, nonatomic) IBOutlet UIImageView *heart2;
@property (weak, nonatomic) IBOutlet UIImageView *heart3;
@property int numberOfSkips;

@property int r;

@property (weak, nonatomic) IBOutlet UILabel *numberOfAnswersCounter;
@property int numberOfAnswers;

@property BOOL isSecondTimeAppearing;


@end
