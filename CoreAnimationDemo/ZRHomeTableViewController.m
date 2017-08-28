//
//  ZRHomeTableViewController.m
//  CoreAnimationDemo
//
//  Created by GKY on 2017/8/10.
//  Copyright © 2017年 Run. All rights reserved.
//

#import "ZRHomeTableViewController.h"

@interface ZRHomeItem : NSObject
/**
 注释
 */
@property (nonatomic,copy) NSString *title;
/**
 注释
 */
@property (nonatomic,copy) NSString *viewControllerName;
- (instancetype)initWithTitle: (NSString *)title viewControllerName: (NSString *)viewControllerName;

@end

@implementation ZRHomeItem

- (instancetype)initWithTitle: (NSString *)title viewControllerName: (NSString *)viewControllerName{

    self = [super init];
    if (self) {
        _title = title;
        _viewControllerName = viewControllerName;
    }
    return self;
}

@end

@interface ZRHomeTableViewController ()
/**
 注释
 */
@property (nonatomic,strong) NSArray<ZRHomeItem *> *items;

@end

@implementation ZRHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.clearsSelectionOnViewWillAppear = YES;
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:[[ZRHomeItem alloc] initWithTitle:@"CAEmitterLayer" viewControllerName:@"ZREmitterLayerViewController"]];
    [items addObject:[[ZRHomeItem alloc] initWithTitle:@"CABasicAnimation" viewControllerName:@"ZRBasicAnimationViewController"]];
    [items addObject:[[ZRHomeItem alloc] initWithTitle:@"CAKeyframeAnimation" viewControllerName:@"ZRKeyframeAnimationViewController"]];
    [items addObject:[[ZRHomeItem alloc] initWithTitle:@"DrawLayer" viewControllerName:@"ZRDrawLayerViewController"]];
    _items = items;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTaleViewCellIdentifier"];
    cell.textLabel.text = _items[indexPath.row].title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    Class viewControllerClass = NSClassFromString(_items[indexPath.row].viewControllerName);
    UIViewController *viewContr = [[viewControllerClass alloc] init];
    [self.navigationController pushViewController:viewContr animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
