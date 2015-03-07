//
//  profileViewController.m
//  LearnHut
//
//  Created by Robin Malhotra on 07/03/15.
//  Copyright (c) 2015 TeamOSC. All rights reserved.
//

#import "profileViewController.h"
#import <ParseFacebookUtils/PFFacebookUtils.h>
@interface profileViewController ()

@end

@implementation profileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _loadData];
    
    self.imgView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 250)];
    [self.imgView setImage:[UIImage imageNamed:@"s"]];
    UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 250, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-150)];
    self.imgView.contentMode = UIViewContentModeScaleToFill;
    self.cachedImageViewSize = self.imgView.frame;
    [self.view addSubview:scroll];
    [self.view addSubview:self.imgView];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [label setBackgroundColor:[UIColor greenColor]];
    [label setText:@"adsljfnal"];
    [label setTextColor:[UIColor whiteColor]];
    [scroll addSubview:label];
    [scroll setBackgroundColor:[UIColor blueColor]];
    [scroll setContentSize:CGSizeMake(CGRectGetWidth(self.view.frame), 1000)];
    [scroll setDelegate:self];
    
    self.profilePic=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self.profilePic setCenter:CGPointMake(self.view.center.x, self.imgView.center.y)];
    [self.profilePic.layer setCornerRadius:50];
    self.profilePic.layer.masksToBounds=YES;
    [self.view addSubview:self.profilePic];
    
    self.emailLabel=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 25)];
    [self.emailLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0f]];
    [self.emailLabel setCenter:CGPointMake(self.view.center.x, self.imgView.center.y+70)];
    [self.view addSubview:self.emailLabel];
    [self.emailLabel setTextAlignment:NSTextAlignmentCenter];
    [self.emailLabel setTextColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat y = -scrollView.contentOffset.y;
    if (y > 0) {
        self.imgView.frame = CGRectMake(0, 0, self.cachedImageViewSize.size.width+y*CGRectGetWidth(self.view.frame)/150, self.cachedImageViewSize.size.height+y);
        [self.imgView setCenter:CGPointMake(self.view.center.x, self.imgView.center.y)];
        [self.profilePic setCenter:CGPointMake(self.view.center.x, self.imgView.center.y)];
        [self.profilePic setAlpha:(1-y/100)];
        [self.emailLabel setCenter:CGPointMake(self.view.center.x, self.imgView.center.y+70)];
    }
    
}

- (void)_loadData
{
    // ...
    NSArray *permissions = [[NSArray alloc] initWithObjects:@"cover",@"picture",@"user_birthday",@"user_hometown",@"user_location",@"email",@"basic_info", nil];
    [FBSession openActiveSessionWithReadPermissions:permissions
                                       allowLoginUI:YES
                                  completionHandler:^(FBSession *session,
                                                      FBSessionState status,
                                                      NSError *error)
    {
        if (FBSession.activeSession.isOpen)
        {
            [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error)
            {
                NSLog(@"%@", [result objectForKey:@"gender"]);
                NSLog(@"%@", [result objectForKey:@"hometown"]);
                NSLog(@"%@", [result objectForKey:@"birthday"]);
                NSLog(@"%@", [result objectForKey:@"cover"]);
                NSLog(@"%@", [result objectForKey:@"email"]);
                NSLog(@"%@", [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [result objectForKey:@"id"]]);
                [self.profilePic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", [result objectForKey:@"id"]]]];
                [self.emailLabel setText:[result objectForKey:@"email"]];
            }];
            
            [FBRequestConnection startWithGraphPath:@"me?fields=cover"
                                  completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                                      if (!error) {
                                          // Sucess! Include your code to handle the results here
                                          NSLog(@"user events: %@", result);
                                          [self.imgView sd_setImageWithURL:[NSURL URLWithString:[[result objectForKey:@"cover"] objectForKey:@"source"]]];
                                      } else {
                                          // An error occurred, we need to handle the error
                                          // See: https://developers.facebook.com/docs/ios/errors   
                                      }
                                  }];
            
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
