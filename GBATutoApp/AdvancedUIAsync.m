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
    
    // Picture to be retrieved on the network
    NSString *fbGraphAPIPicture = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=normal", facebookId];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:fbGraphAPIPicture]]];
    [cell.imageView setImage:image];
    
    return cell;
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

@end