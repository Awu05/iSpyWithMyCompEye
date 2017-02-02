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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(parseData:) name:@"downloadDataComplete" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"downloadDataComplete" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note){
        [self parseData:note];
    }];
    
    
}


- (void)parseData:(NSNotification *)note {
    NSLog(@"Received Notification - Data Has Arrived!");
    UIImage *image = [UIImage imageWithData:self.imgData];
    
    self.photo.image = image;
    
    NSLog(@"WHAT WE GOT BACK: %@", self.dictToParse);
}

- (IBAction)didPressNextButton:(id)sender {
}

@end
