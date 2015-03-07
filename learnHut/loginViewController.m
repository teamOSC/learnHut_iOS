//
//  loginViewController.m
//  LearnHut
//
//  Created by Robin Malhotra on 06/03/15.
//  Copyright (c) 2015 TeamOSC. All rights reserved.
//

#import "loginViewController.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>
#import "signUpViewController.h"
#import <TPKeyboardAvoiding/TPKeyboardAvoidingScrollView.h>

@interface loginViewController ()


@end

@implementation loginViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.tabBarController.tabBar.hidden=YES;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    TPKeyboardAvoidingScrollView *scroll=[[TPKeyboardAvoidingScrollView alloc]initWithFrame:self.view.frame];
    [scroll addGestureRecognizer:tap];
        [self.view addSubview:scroll];
    UILabel *emailLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 200, 89, 21)];
    [emailLabel setText:@"email ID"];
    [scroll addSubview:emailLabel];
    
    UILabel *passwordLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 238, 89, 21)];
    [passwordLabel setText:@"password"];
    [scroll addSubview:passwordLabel];

    UIButton *fbLoginButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 25)];
    [fbLoginButton setCenter:CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)-200)];
    [fbLoginButton addTarget:self action:@selector(loginButtonTouchHandler:) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:fbLoginButton];

    [fbLoginButton setTitle:@"Login with Facebook" forState:UIControlStateNormal];
    [fbLoginButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    UIButton *loginButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.view.frame) , 25)];
    [loginButton setCenter:CGPointMake(CGRectGetWidth(self.view.frame)/2, 234+80)];
    [scroll addSubview:loginButton];
    [loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

    [loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *signUpButton=[[UIButton alloc] initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.view.frame) , 25)];
    [signUpButton setCenter:CGPointMake(CGRectGetWidth(self.view.frame)/2, 234+160)];
    [scroll addSubview:signUpButton];
    [signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [signUpButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    
    
    
    [signUpButton addTarget:self action:@selector(signUp:) forControlEvents:UIControlEventTouchUpInside];

    self.emailTextField=[[UITextField alloc]initWithFrame:CGRectMake(102, 200, CGRectGetWidth(self.view.frame)-110, 21)];
    self.passwordTextField=[[UITextField alloc]initWithFrame:CGRectMake(102, 238, CGRectGetWidth(self.view.frame)-110, 21)];
    [self.emailTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.passwordTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [scroll addSubview:self.emailTextField];
    [scroll addSubview:self.passwordTextField];
    self.passwordTextField.secureTextEntry = YES;

}
// Do any additional setup after loading the view.

-(void)signUp:(id)sender
{
    [self performSegueWithIdentifier:@"showSignUp" sender:self];
}
-(void)login:(id)sender
{
    [self.view endEditing:YES];
    NSString *username=[self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password=[self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if ([username length]==0|| [password length]==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"oops" message:@"make sure you enter non empty stuff" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser *user, NSError *error) {
            if (error)
            {
                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"sorry" message:[error.userInfo objectForKey:@"error"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
            else
            {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
        }];
    }

}


-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loginButtonTouchHandler:(id)sender
{
    [PFFacebookUtils initializeFacebook];
    NSLog(@"adskfhbajkdsbfkjabwjf");
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        
        if (!user) {
            NSString *errorMessage = nil;
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                errorMessage = @"Uh oh. The user cancelled the Facebook login.";
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                errorMessage = [error localizedDescription];
            }
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error"
                                                            message:errorMessage
                                                           delegate:nil
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"Dismiss", nil];
            [alert show];
        } else {
            if (user.isNew)
            {
                NSLog(@"User with facebook signed up and logged in!");
                
            } else
            {
                NSLog(@"User with facebook logged in!");
            }
            [self.navigationController popToRootViewControllerAnimated:YES];

        }
    }];
    
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
