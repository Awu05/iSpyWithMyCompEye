//
//  QuestionViewController.m
//  UsingMicrosoftVision
//
//  Created by Andy Wu on 2/2/17.
//  Copyright © 2017 sahlitude. All rights reserved.
//

#import "QuestionViewController.h"
#import "FinalScoreViewController.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.questionNum = 1;
    
    self.questionNumLabel.text = [NSString stringWithFormat:@"Question: %d", self.questionNum];
    
    self.numberOfSkips = 3;
    
    if (self.isOfficeObjects == YES) {
        
        self.officeObjects = [[NSMutableArray alloc]initWithObjects:@"stapler", @"laptop", @"writing implement", @"cup", @"keyboard", @"scissors", @"chair", @"suit", @"cellphone", @"book", nil];
        
    } else if (self.isHomeFurnishings == YES) {
        
        self.homeFurnishings = [[NSMutableArray alloc]initWithObjects:@"chair", @"bed", @"table", @"book", @"plant", @"orange", @"bread", @"cup", @"sofa", @"pillow", nil];
        
        
    } else if (self.isChallengeObjects == YES) {
        
        self.challengeObjects = [[NSMutableArray alloc]initWithObjects:@"flying", @"holding", @"wooden", @"green", @"yellow", @"stacked", @"silver", @"leather", @"beautiful", @"water", nil];
        
        
    }
    
    self.numberOfAnswers = 0;
    self.isSecondTimeAppearing = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    
    if (self.isSecondTimeAppearing == YES) {
        //do nothing
        self.isSecondTimeAppearing = NO;
    } else if (self.isSecondTimeAppearing == NO) {
        
        self.numberOfAnswers += 1;
        NSString *numberOfAnswers = [NSString stringWithFormat:@"%d/5", self.numberOfAnswers];
        self.numberOfAnswersCounter.text = numberOfAnswers;
        
        if (self.isOfficeObjects == YES) {
            
            
            int i = (int) self.officeObjects.count;
            self.r = arc4random_uniform(i-1);
            
            self.objectToFind.text = [self.officeObjects objectAtIndex:self.r];
            
            
        } else if (self.isHomeFurnishings == YES) {
            
            int i = (int) self.homeFurnishings.count;
            self.r = arc4random_uniform(i-1);
            
            self.objectToFind.text = [self.homeFurnishings objectAtIndex:self.r];

            
            
        } else if (self.isChallengeObjects == YES) {
            
            
            int i = (int) self.challengeObjects.count;
            self.r = arc4random_uniform(i-1);
            
            self.objectToFind.text = [self.challengeObjects objectAtIndex:self.r];
        }
        
        self.item = self.objectToFind.text;
        NSLog(@"Label Object: %@", self.item);
    }
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
        
        self.isSecondTimeAppearing = YES;
        
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
    
    self.cVC.itemToFind = self.item;
    self.cVC.totalNumberOfAnswers = self.numberOfAnswers;
    
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
            
            NSLog(@"OBJ TO FIND: %@", self.cVC.itemToFind);
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"downloadDataComplete" object:nil];
        });
        
        
        
    }
      ]resume];
}

- (IBAction)skipBtn:(UIButton *)sender {
    
    if (self.isOfficeObjects == YES) {
        
        [self.officeObjects removeObject:self.objectToFind.text];
        
        int i = (int) self.officeObjects.count;
        self.r = arc4random_uniform(i);
        
        self.objectToFind.text = [self.officeObjects objectAtIndex:self.r];
        
        
    } else if (self.isHomeFurnishings == YES) {
        
        [self.homeFurnishings removeObject:self.objectToFind.text];

        int i = (int) self.homeFurnishings.count;
        self.r = arc4random_uniform(i);
        
        self.objectToFind.text = [self.homeFurnishings objectAtIndex:self.r];
        
        
        
    } else if (self.isChallengeObjects == YES) {
        
        [self.challengeObjects removeObject:self.objectToFind.text];
        
        
        int i = (int) self.challengeObjects.count;
        self.r = arc4random_uniform(i);
        
        self.objectToFind.text = [self.challengeObjects objectAtIndex:self.r];
    }
    
    self.item = self.objectToFind.text;
    NSLog(@"Label Object: %@", self.item);
    
    if (self.numberOfSkips == 3) {
        [self.heart1 setHidden:YES];
    } else if (self.numberOfSkips == 2) {
        [self.heart1 setHidden:YES];
        [self.heart2 setHidden:YES];
    } else if (self.numberOfSkips == 1) {
        //push to the "you lose" viewcontroller
#pragma mark this doesn't work for some reason
//        FinalScoreViewController *fsVC = [[FinalScoreViewController alloc]init];
//        [self presentViewController:fsVC animated:YES completion:nil];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        FinalScoreViewController *myVC = (FinalScoreViewController *)[storyboard instantiateViewControllerWithIdentifier:@"playAgain"];
        
        [self presentViewController:myVC animated:YES completion:nil];
        
        
    }
    
    self.numberOfSkips = (self.numberOfSkips-1);
    
    
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


- (IBAction)didPressQuitButton:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
@end
