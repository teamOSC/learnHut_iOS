//
//  signUpViewController.m
//  LearnHut
//
//  Created by Robin Malhotra on 07/03/15.
//  Copyright (c) 2015 TeamOSC. All rights reserved.
//

#import "signUpViewController.h"
#import <Parse/Parse.h>
#import <TPKeyboardAvoiding/TPKeyboardAvoidingScrollView.h>
@interface signUpViewController ()

@end

@implementation signUpViewController
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden=YES;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    TPKeyboardAvoidingScrollView *scroll=[[TPKeyboardAvoidingScrollView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:scroll]; 
    UILabel *emailLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 200, 89, 21)];
    [emailLabel setText:@"email ID"];
    [scroll addSubview:emailLabel];
    
    UILabel *passwordLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 238, 89, 21)];
    [passwordLabel setText:@"password"];
    [scroll addSubview:passwordLabel];
    
    self.emailTextField=[[UITextField alloc]initWithFrame:CGRectMake(102, 200, CGRectGetWidth(self.view.frame)-110, 21)];
    self.passwordTextField=[[UITextField alloc]initWithFrame:CGRectMake(102, 238, CGRectGetWidth(self.view.frame)-110, 21)];
    [self.emailTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [self.passwordTextField setBorderStyle:UITextBorderStyleRoundedRect];
    [scroll addSubview:self.emailTextField];
    [scroll addSubview:self.passwordTextField];
    self.passwordTextField.secureTextEntry = YES;


    
    UIButton *signUpButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 30)];
    [signUpButton setCenter:CGPointMake(CGRectGetWidth(self.view.frame)/2,CGRectGetMaxY(self.passwordTextField.frame)+20)];
    [scroll addSubview:signUpButton];
    [signUpButton setTitle:@"Sign Up" forState:UIControlStateNormal];
    [signUpButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [signUpButton addTarget:self action:@selector(signUp:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

- (void)signUp:(id)sender
{
    NSString *email=[self.emailTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password=[self.passwordTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if ([email length]==0|| [password length]==0)
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"oops" message:@"make sure you enter non empty stuff" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    else
    {
        PFUser *newUser=[PFUser user];
        newUser.username=email;
        newUser.password=password;
        
        [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
