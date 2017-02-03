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

//-(void)viewWillAppear:(BOOL)animated {
//               [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"numberOfCorrectAnswers"];
//}


- (IBAction)pickImage:(id)sender {
    /*
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
     */
    
    
}


- (IBAction)sendImageFromURL:(id)sender {
    
    [self.activityIndicator startAnimating];
    NSDictionary *urlBody = @{@"url":self.urlTextField.text};
    NSData *jsonBody = [NSJSONSerialization dataWithJSONObject:urlBody options:kNilOptions error:nil];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURL *url = [NSURL URLWithString:@"https://westus.api.cognitive.microsoft.com/vision/v1.0/analyze?visualFeatures=Tags,Categories&language=en"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPBody = jsonBody;
    [request addValue:myKey forHTTPHeaderField:@"Ocp-Apim-Subscription-Key"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"WHAT WE GOT BACK: %@", jsonDictionary);
        [self.activityIndicator stopAnimating];
    }
      ]resume];
}


-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImageJPEGRepresentation(selectedImage, 0.5);
    [self sendToVisionAPI:imageData];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)sendToVisionAPI: (NSData*) imageData{
    
    [self.activityIndicator startAnimating];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURL *url = [NSURL URLWithString:@"https://westus.api.cognitive.microsoft.com/vision/v1.0/analyze?visualFeatures=Description,Tags,Color,Faces,Categories&language=en"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPBody = imageData;
    [request addValue:myKey forHTTPHeaderField:@"Ocp-Apim-Subscription-Key"];
    [request addValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self.activityIndicator stopAnimating];
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        //NSLog(@"WHAT WE GOT BACK: %@", jsonDictionary);
    }
      ]resume];
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
