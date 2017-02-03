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


- (IBAction)officeSupplyBtn:(UIButton *)sender;
- (IBAction)homeFurnishingsBtn:(id)sender;
- (IBAction)challengeBtn:(id)sender;



@end

