//
//  ViewController.m
//  UsingMicrosoftVision
//
//  Created by Jesse Sahli on 1/31/17.
//  Copyright © 2017 sahlitude. All rights reserved.
//

#import "ViewController.h"
#include <stdlib.h>


@interface ViewController ()

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"numberOfCorrectAnswers"];
}


- (IBAction)officeSupplyBtn:(UIButton *)sender {
    QuestionViewController *qVC = [[QuestionViewController alloc]
                                   initWithNibName:@"QuestionViewController" bundle:nil];
    qVC.isOfficeObjects = YES;
    
    [self presentViewController:qVC animated:YES completion:nil];
    
    
    

}

- (IBAction)homeFurnishingsBtn:(id)sender {
    QuestionViewController *qVC = [[QuestionViewController alloc]
                                   initWithNibName:@"QuestionViewController" bundle:nil];
    qVC.isHomeFurnishings = YES;
    
    [self presentViewController:qVC animated:YES completion:nil];

}

- (IBAction)challengeBtn:(id)sender {
    QuestionViewController *qVC = [[QuestionViewController alloc]
                                   initWithNibName:@"QuestionViewController" bundle:nil];
    qVC.isChallengeObjects = YES;
    
    [self presentViewController:qVC animated:YES completion:nil];

}

@end
