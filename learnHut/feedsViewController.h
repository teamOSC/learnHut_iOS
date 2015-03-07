//
//  feedsViewController.h
//  
//
//  Created by Robin Malhotra on 07/03/15.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <SystemConfiguration/SystemConfiguration.h>
@interface feedsViewController : UITableViewController
@property (nonatomic,strong) NSMutableArray *feedItems;
@end
