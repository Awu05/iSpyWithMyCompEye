//
//  FinalScoreViewController.h
//  UsingMicrosoftVision
//
//  Created by Emiko Clark on 2/2/17.
//  Copyright © 2017 sahlitude. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConfirmationViewController.h"

@interface FinalScoreViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *finalScoreLabel;
//@property (weak, nonatomic) IBOutlet UIButton *playAgainButtonTapped;
@property (strong, nonatomic) ConfirmationViewController  *confirmationVC;
@property int numOfCorrectAnswers;

@end
