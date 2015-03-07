//
//  feedsViewController.m
//  LearnHut
//
//  Created by Robin Malhotra on 07/03/15.
//  Copyright (c) 2015 TeamOSC. All rights reserved.
//

#import "feedsViewController.h"
#import <Parse/Parse.h>
@interface feedsViewController ()

@end

@implementation feedsViewController
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden=NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tabBarController.tabBar.hidden=NO;

    PFUser *currentUser=[PFUser currentUser];
    if (currentUser)
    {
        NSLog(@"logged in %@",currentUser.username);
    }
    else
    {
        [self performSegueWithIdentifier:@"showLogin" sender:self];
        
    }

    
    // Do any additional setup after loading the view.
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
