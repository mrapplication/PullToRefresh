//
//  TableViewController.m
//  PullToRefresh
//
//  Created by Milad Shokrkhah on 3/26/16.
//  Copyright © 2016 com.mrapplication. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

@synthesize myRefresh;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupRefreshControl];
}

#pragma mark - Refresh
- (void)setupRefreshControl {
    
    // Programmatically inserting a UIRefreshControl & Get Rect
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.tintColor = [UIColor clearColor];
    CGRect refreshBounds = self.refreshControl.bounds;
    
    // Setup the loading view, which will hold the moving graphics
    self.refreshLoadingView = [[UIView alloc] initWithFrame:refreshBounds];
    self.refreshLoadingView.backgroundColor = [UIColor clearColor];
    self.refreshLoadingView.clipsToBounds = YES;
    
    // Setup the color view, which will display the rainbowed background
    self.refreshColorView = [[UIView alloc] initWithFrame:refreshBounds];
    self.refreshColorView.backgroundColor = [UIColor lightGrayColor];
    self.refreshColorView.alpha = 0.30;
    
    // Add the loading and colors views to our refresh control
    [self.refreshControl addSubview:self.refreshColorView];
    [self.refreshControl addSubview:self.refreshLoadingView];
    
    // Initalize flags
    self.isRefreshAnimating = NO;
    
    // When activated, invoke our refresh function
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    
    // Refresh shapes setup & call draw refresh element
    myRefresh = [[Refresh alloc] init];
    [myRefresh drawRefreshShapes];
    
    // Add it two element of animationsLayers into refreshLoadingView layer
    [self.refreshLoadingView.layer addSublayer:myRefresh.animationLayerCirclePath];
    [self.refreshLoadingView.layer addSublayer:myRefresh.animationLayerStrokePath];
}

- (void)animateRefreshView {
    
    // Animate Refresh shapes
    [myRefresh animateRefreshShapes];
    
    // Flag that we are animating
    self.isRefreshAnimating = YES;
    
    // Background color to loop through for our color view
    NSArray *colorArray = @[
                            [UIColor lightGrayColor],
                            [UIColor greenColor],
                            [UIColor darkGrayColor],
                            [UIColor lightGrayColor],
                            [UIColor orangeColor],
                            [UIColor blueColor],
                            [UIColor lightGrayColor],
                            [UIColor redColor]];
    
    static int colorIndex = 0;
    
    [UIView animateWithDuration:1.5
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         
                         // Change the background color
                         self.refreshColorView.backgroundColor = [colorArray objectAtIndex:colorIndex];
                         colorIndex = (colorIndex + 1) % colorArray.count;
                     }
                     completion:^(BOOL finished) {
                         
                         if (self.refreshControl.isRefreshing)
                         {
                             [self animateRefreshView];
                         }
                         else
                         {
                             self.isRefreshAnimating = NO;
                         }
                     }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // Get the current size of the refresh controller
    CGRect refreshBounds = self.refreshControl.bounds;
    
    // Distance the table has been pulled >= 0
    CGFloat pullDistance = MAX(0.0, -self.refreshControl.frame.origin.y);
    
    // Set the encompassing view's frames
    refreshBounds.size.height = pullDistance;
    
    self.refreshColorView.frame = refreshBounds;
    self.refreshLoadingView.frame = refreshBounds;
    
    // If we're refreshing and the animation is not playing
    if (self.refreshControl.isRefreshing && !self.isRefreshAnimating)
    {
        [self animateRefreshView];
    }
}

- (void)refresh:(id)sender {
    
    double delayInSeconds = 10.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void)
                   {
                       NSLog(@"Done refresh");
                       [self.refreshControl endRefreshing];
                   });
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = @"refresh";
    
    return cell;
}

@end
