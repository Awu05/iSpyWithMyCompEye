//
//  QuestionViewController.h
//  UsingMicrosoftVision
//
//  Created by Andy Wu on 2/2/17.
//  Copyright © 2017 sahlitude. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, retain) UIImagePickerController *imagePickerController;

@property (weak, nonatomic) IBOutlet UILabel *questionNumLabel;

@property (weak, nonatomic) IBOutlet UILabel *objectToFind;

- (IBAction)startCameraBtn:(UIButton *)sender;

- (IBAction)skipBtn:(UIButton *)sender;

@property int questionNum;


@end
