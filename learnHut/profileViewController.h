//
//  profileViewController.h
//  LearnHut
//
//  Created by Robin Malhotra on 07/03/15.
//  Copyright (c) 2015 TeamOSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface profileViewController : UIViewController<UIScrollViewDelegate>
@property (nonatomic,strong) UIImageView *imgView;
@property CGRect cachedImageViewSize;
@property (nonatomic,strong) UIImageView *profilePic;
@property (nonatomic,strong) UILabel *emailLabel;
@end
