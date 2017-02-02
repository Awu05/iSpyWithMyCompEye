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
        
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImageJPEGRepresentation(selectedImage, 0.5);
    [self sendToVisionAPI:imageData];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    self.cVC = [[ConfirmationViewController alloc]
                                       initWithNibName:@"ConfirmationViewController" bundle:nil];
    
    self.cVC.imgData = imageData;
    [self presentViewController:self.cVC animated:YES completion:nil];
    
}

- (void)sendToVisionAPI: (NSData*) imageData{
    
    //[self.activityIndicator startAnimating];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURL *url = [NSURL URLWithString:@"https://westus.api.cognitive.microsoft.com/vision/v1.0/analyze?visualFeatures=Description,Tags,Color,Faces,Categories&language=en"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPBody = imageData;
    [request addValue:myKey forHTTPHeaderField:@"Ocp-Apim-Subscription-Key"];
    [request addValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"POST";
    
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //[self.activityIndicator stopAnimating];
        NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        //NSLog(@"WHAT WE GOT BACK: %@", jsonDictionary);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.cVC.dictToParse = jsonDictionary;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"downloadDataComplete" object:nil];
        });

        
        
    }
      ]resume];
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
