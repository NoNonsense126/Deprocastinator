//
//  RootViewController.m
//  Deprocastinator
//
//  Created by Wong You Jing on 18/01/2016.
//  Copyright © 2016 NoNonsense. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property NSMutableArray *taskArray;
@property NSMutableArray *backgroundColorArray;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.taskArray = [NSMutableArray new];
    self.backgroundColorArray = [NSMutableArray new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    cell.textLabel.text = [self.taskArray objectAtIndex:indexPath.row];
    cell.backgroundColor = [self.backgroundColorArray objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.taskArray.count;
}

- (IBAction)onAddButtonTapped:(UIButton *)sender {
    [self.taskArray addObject:self.textField.text];
    [self.backgroundColorArray addObject:[UIColor whiteColor]];
    [self.tableView reloadData];
    self.textField.text = @"";
    [self.view endEditing:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if([self.editButton.title isEqualToString:@"Edit"]){
    if([[self.backgroundColorArray objectAtIndex:indexPath.row] isEqual:[UIColor whiteColor]]){
        [self.backgroundColorArray replaceObjectAtIndex:indexPath.row withObject:[UIColor greenColor]];
    }else{
        [self.backgroundColorArray replaceObjectAtIndex:indexPath.row withObject:[UIColor whiteColor]];
    }
//    }else{
//        [self.taskArray removeObjectAtIndex:indexPath.row];
//        [self.backgroundColorArray removeObjectAtIndex:indexPath.row];
//    }
    
    [self.tableView reloadData];

}

- (IBAction)onEditButtonTapped:(UIBarButtonItem *)sender {
    if(self.editing == YES){
        self.editing = NO;
        [self.tableView setEditing:NO animated:YES];
        sender.style = UIBarButtonItemStylePlain;
        [sender setTitle:@"Edit"];
    }else{
        self.editing = YES;
        [self.tableView setEditing:YES animated:YES];
        sender.style = UIBarButtonItemStyleDone;
        [sender setTitle:@"Done"];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.taskArray removeObjectAtIndex:indexPath.row];
    [self.backgroundColorArray removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

@end
