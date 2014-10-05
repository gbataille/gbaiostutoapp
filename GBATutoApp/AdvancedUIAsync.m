//
//  AdvancedUIAsync.m
//  GBATutoApp
//
//  Created by Gregory Bataille on 05/10/14.
//  Copyright (c) 2014 Gregory Bataille. All rights reserved.
//

#import "AdvancedUIAsync.h"

@interface AdvancedUIAsync ()

@property (strong, nonatomic) NSArray *items;

@end

@implementation AdvancedUIAsync

#pragma mark - UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"facebookCell"];
    NSNumber *facebookId = self.items[indexPath.row];
    
    cell.textLabel.text = [facebookId stringValue];
    
    // Picture to be retrieved on the network - changed to large to introduce some visible load latency
    NSString *fbGraphAPIPicture = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large", facebookId];
    // Puts a static image in the placeholder. This is to alloc for the cell to be displaced with the picture layout.
    [cell.imageView setImage:[UIImage imageNamed:@"icon_facebook_white"]];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperationWithBlock:^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:fbGraphAPIPicture]]];
        // Change the UI components in the mainThread
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            // The following method returns the cell only if it's still visible.
            // If it's still visible, we see that it's still the same cell instance being used for this indexPath
            UITableViewCell *visibleCell = [tableView cellForRowAtIndexPath:indexPath];
            if (visibleCell && [visibleCell isEqual:cell]) {
                [cell.imageView setImage:image];
            }
        }];
    }];
    
    return cell;
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
}

#pragma mark - Controller Lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:50];
    for (int i = 0; i < 50; i++) {
        [arr addObject:[NSNumber numberWithInt:(1111111 + i)]];
    }
    self.items = [NSArray arrayWithArray:arr];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Implem 3" message:@"All good now. No scroll odd issues anymore" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert setTag:2];
    [alert show];

}

@end
