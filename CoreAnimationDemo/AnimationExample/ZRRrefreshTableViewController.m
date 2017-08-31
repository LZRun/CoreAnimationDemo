//
//  ZRRrefreshTableViewController.m
//  CoreAnimationDemo
//
//  Created by GKY on 2017/8/31.
//  Copyright © 2017年 Run. All rights reserved.
//

#import "ZRRrefreshTableViewController.h"
#define REFRESHING_MIN 60
@interface ZRRrefreshTableViewController (){
    //原始contentInset.top
    CGFloat contentInsetTop;
}
/**
 下拉动画
 */
@property (nonatomic,strong) CAShapeLayer *pullToRefreshShapeLayer;
/**
 正在刷新动画
 */
@property (nonatomic,strong) CAShapeLayer *loadingShapeLayer;
/**
 是否正在刷新,默认为NO
 */
@property (nonatomic,assign) BOOL isRefresh;
/**
 下拉刷新视图
 */
@property (nonatomic,strong) UIView *loadingIndicator;

@end

@implementation ZRRrefreshTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //刷新初始化(刷新状态,刷新视图)
    _isRefresh = NO;
    [self setUpLoadingIndicator];
    //添加下拉动画
    [_pullToRefreshShapeLayer addAnimation:[self pushToRerefreshAnimation] forKey:@"pullWriteWordKey"];
    //主动刷新一次
    __weak typeof (self) weakSelf = self;
    [self startRefreshing:^{
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf endRefresh];
        });
    }];
    
}

#pragma mark - init
- (void)setUpLoadingIndicator{
    self.pullToRefreshShapeLayer = [CAShapeLayer layer];
    _pullToRefreshShapeLayer.path = [self pullToRefreshPath];
    self.loadingShapeLayer = [CAShapeLayer layer];
    _loadingShapeLayer.path = [self loadingPath];
    NSArray *shapeLayers = @[_pullToRefreshShapeLayer,_loadingShapeLayer];
    
    self.loadingIndicator = [[UIView alloc]initWithFrame:CGRectMake(0, -45, 230, 70)];
    [self.tableView addSubview:_loadingIndicator];
    
    for (CAShapeLayer *layer in shapeLayers) {
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.strokeColor = [UIColor blackColor].CGColor;
        layer.lineCap = kCALineCapRound;
        layer.lineJoin = kCALineJoinRound;
        layer.lineWidth = 5.f;
        layer.position = CGPointMake(75.f, 0.f);
        layer.strokeEnd = 0.f;
        [_loadingIndicator.layer addSublayer:layer];
    }
    _pullToRefreshShapeLayer.speed = 0;
}

#pragma mark - animation
- (CAAnimation *)pushToRerefreshAnimation{
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    basicAnimation.fromValue = @0;
    basicAnimation.toValue = @1;
    
    CABasicAnimation *positionBsAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    positionBsAnimation.byValue = @(-22);
    positionBsAnimation.toValue = @0;
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[basicAnimation,positionBsAnimation];
    animationGroup.duration = 1;
    return animationGroup;
}
- (CABasicAnimation *)loadingAnimation{
    CABasicAnimation *write2 = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    write2.fromValue = @0;
    write2.toValue   = @1;
    write2.fillMode = kCAFillModeBoth;
    write2.removedOnCompletion = NO;
    write2.duration = 0.4;
    return write2;
}

#pragma mark - refresh
- (void)endRefresh{
    _pullToRefreshShapeLayer.timeOffset = 0;
    [_loadingShapeLayer removeAllAnimations];
    self.tableView.contentInset = UIEdgeInsetsMake(contentInsetTop, 0, 0, 0);
    _isRefresh = NO;
}
- (void)startRefreshing: (void(^)())handler{
    _isRefresh = YES;
    [_loadingShapeLayer addAnimation:self.loadingAnimation forKey:@"loadingWriteWord"];
    contentInsetTop = self.tableView.contentInset.top;
    self.tableView.contentInset = UIEdgeInsetsMake(contentInsetTop + _loadingIndicator.height, 0, 0, 0);
    if (handler) {
        handler();
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 0;
}

/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y + scrollView.contentInset.top;
    if (offsetY < 0 && !_isRefresh) {
        CGFloat fractionDragged = - offsetY / REFRESHING_MIN;
        fractionDragged = MIN(fractionDragged, 1);
        _pullToRefreshShapeLayer.timeOffset = fractionDragged;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
}
#pragma mark - path
- (CGPathRef)pullToRefreshPath{
    CGMutablePathRef path = CGPathCreateMutable();
    // load
    CGPathMoveToPoint(path,     NULL, 7.50878897, 25.2871097);
    CGPathAddCurveToPoint(path, NULL, 7.50878897, 25.2871097,  21.7333976, 26.7812495, 29.6894527, 20.225586);
    CGPathAddCurveToPoint(path, NULL, 37.6455074, 13.6699219,  39.367189,  3.85742195, 31.9697262, 1.25976564);
    CGPathAddCurveToPoint(path, NULL, 24.5722639, -1.33789083, 21.99707,   10.9072268, 21.99707,   22.2255862);
    CGPathAddCurveToPoint(path, NULL, 21.9970685, 33.5439456,  15.9355469, 45.8212894, 8.99707031, 47.7294922);
    CGPathAddCurveToPoint(path, NULL, 2.05859375, 49.637695,   3.67187498, 44.0332034, 7.50878897, 44.0332034);
    CGPathAddCurveToPoint(path, NULL, 11.3457029, 44.0332034,  16.9277345, 44.234375,  25.5234372, 47.7294925);
    CGPathAddCurveToPoint(path, NULL, 30.55635,   49.7759358,  37.9023439, 49.5410159, 44.1259762, 35.9140628);
    CGPathAddCurveToPoint(path, NULL, 50.349609,  22.2871097,  55.3105465, 25.2871099, 60.7128903, 25.2871097);
    CGPathAddCurveToPoint(path, NULL, 66.481445,  25.2871097,  56.192383,  22.6435549, 50.8017578, 26.6455078);
    CGPathAddCurveToPoint(path, NULL, 45.4111325, 30.6474606,  43.4619148, 37.8193362, 46.0097656, 43.7333984);
    CGPathAddCurveToPoint(path, NULL, 48.5576169, 49.6474606,  57.0488304, 50.0810555, 61.8876968, 43.0097659);
    CGPathAddCurveToPoint(path, NULL, 66.7265637, 35.9384765,  65.6816424, 31.5634772, 64.4834,    27.8232425);
    CGPathAddCurveToPoint(path, NULL, 63.2851574, 24.0830078,  59.8876972, 27.8076178, 59.8876968, 31.4882815);
    CGPathAddCurveToPoint(path, NULL, 59.8876965, 35.1689453,  69.1025406, 37.2509768, 74.9531265, 32.7333987);
    CGPathAddCurveToPoint(path, NULL, 80.8037132, 28.2158207,  80.1298793, 27.0527347, 84.4970703, 25.3574219);
    CGPathAddCurveToPoint(path, NULL, 88.8642613, 23.6621091,  93.7460906, 25.37793,   96.1650391, 28.8349609);
    CGPathAddCurveToPoint(path, NULL, 96.1650391, 28.8349609,  91.6679688, 24.28711,   88.085941,  24.2871097);
    CGPathAddCurveToPoint(path, NULL, 84.5039132, 24.2871093,  74.9824181, 33.0332029, 78.5166016, 43.3417969);
    CGPathAddCurveToPoint(path, NULL, 82.0507847, 53.6503909,  92.167965,  42.5078128, 95.0117188, 38.9140625);
    CGPathAddCurveToPoint(path, NULL, 97.8554722, 35.3203122,  100.327144, 27.9042972, 100.327148, 23.3740234);
    CGPathAddCurveToPoint(path, NULL, 100.327152, 18.8437497,  96.499996,  26.5527347, 96.5,       32.7333984);
    CGPathAddCurveToPoint(path, NULL, 96.5000035, 38.9140622,  92.6337871, 53.1660163, 101.700195, 46.0400391);
    CGPathAddCurveToPoint(path, NULL, 110.766605, 38.9140622,  112.455075, 29.5751958, 118.345703, 26.9746094);
    CGPathAddCurveToPoint(path, NULL, 124.236332, 24.3740231,  129.221685, 27.5800787, 131.216798, 30.1386722);
    CGPathAddCurveToPoint(path, NULL, 131.216798, 30.1386722,  125.394529, 25.9746094, 121.82422,  25.9746097);
    CGPathAddCurveToPoint(path, NULL, 118.253911, 25.9746099,  110.588871, 32.4130862, 112.661136, 41.7500003);
    CGPathAddCurveToPoint(path, NULL, 114.733402, 51.0869143,  119.810543, 48.9121097, 125.347656, 43.0097656);
    CGPathAddCurveToPoint(path, NULL, 130.884769, 37.1074216,  137.702153, 21.0126953, 139.335938, 12.4980469);
    CGPathAddCurveToPoint(path, NULL, 140.969722, 3.98339847,  140.637699,-2.27636688, 136.845703, 7.984375);
    CGPathAddCurveToPoint(path, NULL, 134.586089, 14.0986513,  131.676762, 31.5527347, 129.884769, 38.9140628);
    CGPathAddCurveToPoint(path, NULL, 128.092777, 46.2753909,  130.551236, 50.2217745, 135.211914, 46.2753906);
    CGPathAddCurveToPoint(path, NULL, 146.745113, 36.5097659,  142.116211, 40.75,      142.116211, 40.75);
    
    CGAffineTransform t = CGAffineTransformMakeScale(0.7, 0.7); // It was slighly to big and I didn't feel like redoing it :D
    return CGPathCreateCopyByTransformingPath(path, &t);
}
- (CGPathRef)loadingPath{
    CGMutablePathRef path = CGPathCreateMutable();
    // ing (minus dot)
    CGPathMoveToPoint(path,     NULL, 139.569336, 42.9423837);
    CGPathAddCurveToPoint(path, NULL, 139.569336, 42.9423837, 149.977539, 32.9609375, 151.100586, 27.9072266);
    CGPathAddCurveToPoint(path, NULL, 152.223633, 22.8535156, 149.907226, 21.5703124, 148.701172, 26.5419921);
    CGPathAddCurveToPoint(path, NULL, 147.495117, 31.5136718, 142.760742, 50.8046884, 149.701172, 48.2763681);
    CGPathAddCurveToPoint(path, NULL, 156.641602, 45.7480478, 166.053711, 33.5791017, 167.838867, 29.5136719);
    CGPathAddCurveToPoint(path, NULL, 169.624023, 25.4482421, 169.426758, 20.716797,  167.455078, 26.1152344);
    CGPathAddCurveToPoint(path, NULL, 165.483398, 31.5136718, 165.618164, 42.9423835, 163.97168,  48.2763678);
    CGPathAddCurveToPoint(path, NULL, 163.97168,  48.2763678, 163.897461, 41.4570313, 168.141602, 35.9375);
    CGPathAddCurveToPoint(path, NULL, 172.385742, 30.4179687, 179.773438, 21.9091796, 183.285645, 26.6875);
    CGPathAddCurveToPoint(path, NULL, 186.797851, 31.4658204, 177.178223, 48.2763684, 184.285645, 48.2763678);
    CGPathAddCurveToPoint(path, NULL, 191.393066, 48.2763678, 196.006836, 38.8701172, 198.850586, 34.0449218);
    CGPathAddCurveToPoint(path, NULL, 201.694336, 29.2197264, 207.908203, 19.020508,  216.71875,  28.4179687);
    CGPathAddCurveToPoint(path, NULL, 216.71875,  28.4179687, 211.086914, 23.5478516, 206.945312, 24.6738281);
    CGPathAddCurveToPoint(path, NULL, 202.803711, 25.7998046, 194.8125,   40.1455079, 201.611328, 47.2763672);
    CGPathAddCurveToPoint(path, NULL, 208.410156, 54.4072265, 220.274414, 30.9111327, 221.274414, 26.6874999);
    CGPathAddCurveToPoint(path, NULL, 222.274414, 22.4638672, 220.005859, 20.3759766, 218.523438, 28.5419922);
    CGPathAddCurveToPoint(path, NULL, 217.041016, 36.7080077, 216.630859, 64.7705084, 209.121094, 71.012696);
    CGPathAddCurveToPoint(path, NULL, 201.611328, 77.2548835, 197.109375, 65.0654303, 202.780273, 60.9287116);
    CGPathAddCurveToPoint(path, NULL, 208.451172, 56.7919928, 224.84668,  51.0244147, 228.638672, 38.6855466);
    
    // dot
    CGPathMoveToPoint(path,     NULL, 153.736328, 14.953125);
    CGPathAddCurveToPoint(path, NULL, 153.736328, 14.953125,  157.674805, 12.8178626, 155.736328, 10.2929688);
    CGPathAddCurveToPoint(path, NULL, 153.797852, 7.76807493, 151.408203, 12.2865614, 152.606445, 14.9531252);
    
    CGAffineTransform t = CGAffineTransformMakeScale(0.7, 0.7); // It was slighly to big and I didn't feel like redoing it :D
    return CGPathCreateCopyByTransformingPath(path, &t);
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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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
