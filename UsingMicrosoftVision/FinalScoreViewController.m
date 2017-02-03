//
//  FinalScoreViewController.m
//  UsingMicrosoftVision
//
//  Created by Emiko Clark on 2/2/17.
//  Copyright © 2017 sahlitude. All rights reserved.
//

#import "FinalScoreViewController.h"

@interface FinalScoreViewController ()

@end

@implementation FinalScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.confirmationVC = [[ConfirmationViewController alloc] init];
    NSString  *feedback;
    
    NSString *correctAnswers = [[NSUserDefaults standardUserDefaults]valueForKey:@"numberOfCorrectAnswers"];
    int number = (int)correctAnswers;
    // give user feedback based on numOfCorrectAnswers
    switch (number) {
        case 10:
        case 9:
            feedback = @"Great going";
            break;
        case 8:
        case 7:
            feedback = @"Okay.";
            break;
        case 6:
        case 5:
            feedback = @"Hmm....";
            break;
        default:
            feedback = @"You desperately need to take classes";
            break;
    }
    
    // display final score and feedback to user
    self.finalScoreLabel.text = [NSString stringWithFormat:@"\n\nYou got %d out of 5.\n\n%@",self.confirmationVC.numberOfCorrectAnswers, feedback ];
}


- (IBAction)playAgainButtonTapped:(UIButton *)sender {
//    [self dismissViewControllerAnimated:YES completion:nil];
    [self performSegueWithIdentifier: @"playAgain" sender: nil];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
