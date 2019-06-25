//
//  HLLSmallViewController.m
//  HLLEmptyData
//
//  Created by  bochb on 2019/6/25.
//  Copyright © 2019 com.heron. All rights reserved.
//

#import "HLLSmallViewController.h"
#import "UIScrollView+HLLScrollView.h"

@interface HLLSmallViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *data;
@end

static NSString *cellID = @"cellID";
@implementation HLLSmallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_tableView hll_setUp];
    __weak typeof(self) weakSelf = self;
    self.data = [NSMutableArray array];
    // Do any additional setup after loading the view from its nib.
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    _tableView.shouldPullLoadMore = true;
    _tableView.shouldPullRefresh = true;
    _tableView.isEmpty = true;
    _tableView.noDataType = HLLNodataTypeNoNetworking;
    _tableView.emptyBackgroundColor = UIColor.lightGrayColor;
    _tableView.loadNewDataBlock = ^(void (^ _Nonnull completion)(void)) {
        sleep(1);
        completion();
        weakSelf.tableView.isEmpty = false;
        weakSelf.data = @[@"one",@"one",@"one",@"one",@"one"];
        [weakSelf.tableView reloadData];
    };
    _tableView.loadMoreDataBlock = ^(void (^ _Nonnull completion)(BOOL)) {
        sleep(1);
        weakSelf.tableView.isEmpty = false;
        weakSelf.data = @[@"one",@"one",@"one",@"one",@"one",@"one",@"one",@"one",@"one",@"one",@"one",@"one",@"one"];
        completion(weakSelf.data.count == 13);
        [weakSelf.tableView reloadData];
    };
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = _data[indexPath.row];
    return cell;
}

@end
