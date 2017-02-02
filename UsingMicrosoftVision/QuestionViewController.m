//
//  QuestionViewController.m
//  UsingMicrosoftVision
//
//  Created by Andy Wu on 2/2/17.
//  Copyright © 2017 sahlitude. All rights reserved.
//

#import "QuestionViewController.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.questionNum = 1;
    
    self.questionNumLabel.text = [NSString stringWithFormat:@"Question: %d", self.questionNum];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startCameraBtn:(UIButton *)sender {
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self noCamera];
        });
        
    }
    else {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        self.imagePickerController = picker;
        
        [self presentViewController:picker animated:YES completion:NULL];
        
        //[self showPhotos];
    }
}

- (IBAction)skipBtn:(UIButton *)sender {
    
}

- (void) noCamera {
    UIAlertController * alert=   [UIAlertController
                                  alertControllerWithTitle:@"Error!"
                                  message:@"Your device does not have a camera!"
                                  preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction
                         actionWithTitle:@"OK"
                         style:UIAlertActionStyleDefault
                         handler:^(UIAlertAction * action)
                         {
                             [alert dismissViewControllerAnimated:YES completion:nil];
                             
                         }];
    
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}
@end
