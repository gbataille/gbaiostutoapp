//
//  ViewController.m
//  GBATutoApp
//
//  Created by Gregory Bataille on 05/10/14.
//  Copyright (c) 2014 Gregory Bataille. All rights reserved.
//

#import "TutoTableViewController.h"

@interface TutoTableViewController ()

@property (strong, nonatomic) NSArray *tutos;

@end

@implementation TutoTableViewController

#pragma mark - UITableViewDelegage

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tutos.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:self.tutos[indexPath.row]];
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
    
    NSString *tuto = (NSString*) self.tutos[indexPath.row];
    cell.textLabel.text = tuto;
    
    return cell;
}

#pragma mark - Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tutos = @[@"Advanced UI - Async"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
