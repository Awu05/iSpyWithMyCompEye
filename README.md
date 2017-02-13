# iSpyWithMyCompEye

TurnToTech Hack-a-Thon

Our App:

This is a simple iSpy game which involves taking a picture of a random specified object. 
The image will then be evaluated by the Microsoft Computer Vision Engine (https://www.microsoft.com/cognitive-services/en-us/).
With the data returned from Microsoft, we then parsed the data returned and matched it with the currect object that you are trying to find.
You will have 5 objects to look for and 3 skips available. 
Once you have used all 3 skips or answered all 5 questions, your score will be shown and you can play again.
There are 3 categories, Office Supplies, Home Furnishings and Ultimate (Ultimate being the most difficult one).


To Run Our App:

To run our app, you will need to register for an API Key at https://www.microsoft.com/cognitive-services/en-us/ and 
sign up for a Microsoft Computer Vision API Key. 
Once you have the API Key, you then need to clone our Repo and create a Constants.h and Constants.m file and paste this inside:

You may delete the current Constants.h and paste this inside:

Constants.h: 
extern NSString *const myKey;

Constants.m: 
NSString *const myKey = @"API KEY HERE";
              
You then need to replace "API KEY HERE" with the API Key you got from Microsoft.

Now you should be able to run our app. 

** Dont forget to change the bundle identifier to one that you own!! **
