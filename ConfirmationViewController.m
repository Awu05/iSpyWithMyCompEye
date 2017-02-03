//
//  ConfirmationViewController.m
//  UsingMicrosoftVision
//
//  Created by Juliana Strawn on 2/2/17.
//  Copyright © 2017 sahlitude. All rights reserved.
//

#import "ConfirmationViewController.h"
#import "Constants.h"
#import "QuestionViewController.h"
#import "FinalScoreViewController.h"

@interface ConfirmationViewController ()

@end

@implementation ConfirmationViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dataReceived:) name:@"downloadDataComplete" object:nil];
    
    self.didItemMatch = false;
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"downloadDataComplete" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note){
        [self dataReceived:note];
    }];
    
}

-(void)viewWillAppear:(BOOL)animated {
    NSString *string = [NSString stringWithFormat:@"%ld/5",(long)self.totalNumberOfAnswers];
    self.numberOfAnswersLabel.text = string;
    self.alreadyRan = NO;
}


- (void)dataReceived:(NSNotification *)note {
    NSLog(@"Received Notification - Data Has Arrived!");
    UIImage *image = [UIImage imageWithData:self.imgData];
    
    self.photo.image = image;
    
    NSLog(@"WHAT WE GOT BACK: %@", self.dictToParse);
    
    [self parseData];
}


- (void) parseData {
    
    NSDictionary *description = [self.dictToParse objectForKey:@"description"];
    
    //NSString *tagString = [description objectForKey:@"tags"];
    
    //NSLog(@"TAGS: %@", tagString);
    
    NSArray *tagArray = [description objectForKey:@"tags"];
    
    NSLog(@"TAG ARRAY: %@", tagArray);
    
    for (NSString *item in tagArray) {
        if ([item isEqualToString:self.itemToFind]) {
            self.didItemMatch = true;
            self.confirmationTextView.text = @"\nYou found it!";
//            self.numberOfCorrectAnswers += 1;
//            self.totalNumberOfAnswers += 1;
            
//            [[NSUserDefaults standardUserDefaults] setInteger:self.numberOfCorrectAnswers forKey:@"numberOfCorrectAnswers"];

        }
    }
    
    if (self.didItemMatch == false) {
        self.confirmationTextView.text = [NSString stringWithFormat:@"\nThat object was not %@-y enough!", self.itemToFind];
//        self.totalNumberOfAnswers += 1;
    } else if (self.didItemMatch == true) {
        
        if (self.alreadyRan == NO) {
            self.numberOfCorrectAnswers += 1;
            
            [[NSUserDefaults standardUserDefaults] setInteger:self.numberOfCorrectAnswers forKey:@"numberOfCorrectAnswers"];
            
            self.alreadyRan = YES;
        }
    }
    
}


- (IBAction)didPressNextButton:(id)sender {
    
    if (self.totalNumberOfAnswers < 5) {
        //push to QuestionViewController
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else  {
        
        //push to the "final results" viewcontroller
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        FinalScoreViewController *myVC = (FinalScoreViewController *)[storyboard instantiateViewControllerWithIdentifier:@"playAgain"];
        
        [self presentViewController:myVC animated:YES completion:nil];
        
    }
    
    
}

@end
