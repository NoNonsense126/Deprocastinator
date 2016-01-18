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
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightSwipeHandle:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [self.tableView addGestureRecognizer:rightRecognizer];
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
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Delete Task" message:@"are you sure?" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirm = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.taskArray removeObjectAtIndex:indexPath.row];
        [self.backgroundColorArray removeObjectAtIndex:indexPath.row];
        [self.tableView reloadData];
    }];
    [alertController addAction:cancel];
    [alertController addAction:confirm];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)rightSwipeHandle:(UISwipeGestureRecognizer*)gestureRecognizer {
    CGPoint location = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:location];
    if ([self.backgroundColorArray objectAtIndex:indexPath.row] == [UIColor greenColor] || [self.backgroundColorArray objectAtIndex:indexPath.row] == [UIColor whiteColor]) {
        [self.backgroundColorArray replaceObjectAtIndex:indexPath.row withObject:[UIColor yellowColor]];

    }else if ([self.backgroundColorArray objectAtIndex:indexPath.row] == [UIColor yellowColor]){
        [self.backgroundColorArray replaceObjectAtIndex:indexPath.row withObject:[UIColor redColor]];
    }else if ([self.backgroundColorArray objectAtIndex:indexPath.row] == [UIColor redColor]){
        [self.backgroundColorArray replaceObjectAtIndex:indexPath.row withObject:[UIColor greenColor]];
    }
        [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    NSString *task = [self.taskArray objectAtIndex:sourceIndexPath.row];
    UIColor *bgColor = [self.backgroundColorArray objectAtIndex:sourceIndexPath.row];
    
    [self.taskArray removeObjectAtIndex:sourceIndexPath.row];
    [self.backgroundColorArray removeObjectAtIndex:sourceIndexPath.row];
    
    [self.taskArray insertObject:task atIndex:destinationIndexPath.row];
    [self.backgroundColorArray insertObject:bgColor atIndex:destinationIndexPath.row];
    
}

@end
