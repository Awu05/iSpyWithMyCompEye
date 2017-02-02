//
//  ConfirmationViewController.m
//  UsingMicrosoftVision
//
//  Created by Juliana Strawn on 2/2/17.
//  Copyright © 2017 sahlitude. All rights reserved.
//

#import "ConfirmationViewController.h"
#import "Constants.h"

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


- (void)dataReceived:(NSNotification *)note {
    NSLog(@"Received Notification - Data Has Arrived!");
    UIImage *image = [UIImage imageWithData:self.imgData];
    
    self.photo.image = image;
    
    NSLog(@"WHAT WE GOT BACK: %@", self.dictToParse);
    
    [self parseData];
}


- (void) parseData {
//    for (NSDictionary *item in self.dictToParse) {
//        
//    }
    
    NSDictionary *description = [self.dictToParse objectForKey:@"description"];
    
    //NSString *tagString = [description objectForKey:@"tags"];
    
    //NSLog(@"TAGS: %@", tagString);
    
    NSArray *tagArray = [description objectForKey:@"tags"];
    
    NSLog(@"TAG ARRAY: %@", tagArray);
    
    for (NSString *item in tagArray) {
        if ([item isEqualToString:self.itemToFind]) {
            self.didItemMatch = true;
            self.confirmationTextView.text = @"You found it!";
        }
    }
    
    if (self.didItemMatch == false) {
        self.confirmationTextView.text = [NSString stringWithFormat:@"That object was not %@-y enough!", self.itemToFind];
    }
}


- (IBAction)didPressNextButton:(id)sender {
}

@end
