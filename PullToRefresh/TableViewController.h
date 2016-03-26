//
//  TableViewController.h
//  PullToRefresh
//
//  Created by Milad Shokrkhah on 3/26/16.
//  Copyright © 2016 com.mrapplication. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Refresh.h"

@interface TableViewController : UITableViewController

@property (nonatomic, strong) UIView *refreshLoadingView;
@property (nonatomic, strong) UIView *refreshColorView;
@property (assign) BOOL isRefreshAnimating;

@property (nonatomic, strong) Refresh *myRefresh;

@end
