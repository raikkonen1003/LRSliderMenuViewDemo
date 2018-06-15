//
//  SliderMenuDemoViewController.m
//  LRSliderMenuViewDemo
//
//  Created by liliansi on 2018/6/15.
//  Copyright © 2018年 liliansi. All rights reserved.
//

#import "SliderMenuDemoViewController.h"
#import "Header.h"

#define TITLES @[@"标题1",@"标题2",@"标题3",@"标题4"]

static NSString * KYAInfoTableViewCellIdentifier = @"KYAInfoTableViewCell";


@interface SliderMenuDemoViewController ()<UITableViewDelegate,UITableViewDataSource,LRSliderMenuViewDelegate>


@property (nonatomic,strong) NSMutableArray *tableViewArray;
@property (nonatomic,strong) NSMutableArray *sourceListArray;
@property (nonatomic,strong) NSMutableArray *pageNumArray;

@property (nonatomic,strong) LRSliderMenuView *sliderMenuView;

//当前页数
@property (nonatomic,assign) NSInteger currentPageNum;
@property (nonatomic,strong) UITableView *currentTableView;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,strong) NSMutableArray *currentListArray;

@property (nonatomic,strong) NSMutableArray *clickTimeArray;
@property (nonatomic,strong) NSMutableArray *infoViewArray;

@end

@implementation SliderMenuDemoViewController

- (NSMutableArray *)clickTimeArray {
    if (!_clickTimeArray) {
        _clickTimeArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _clickTimeArray;
}
- (NSMutableArray *)tableViewArray {
    if (!_tableViewArray) {
        _tableViewArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _tableViewArray;
}
- (NSMutableArray *)sourceListArray {
    if (!_sourceListArray) {
        _sourceListArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _sourceListArray;
}
- (NSMutableArray *)pageNumArray {
    if (!_pageNumArray) {
        _pageNumArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _pageNumArray;
}

- (UITableView *)currentTableView {
    if (!_currentTableView) {
        _currentTableView = [[UITableView alloc]init];
        _currentTableView.delegate = self;
        _currentTableView.dataSource = self;
    }
    return _currentTableView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    
    //必须加上一个无用的视图  再添加_sliderMenuView才不会标题显示异常  ？？？
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor orangeColor];
    view.frame = CGRectMake(0, 0, SCREEN_WIDTH, 20);
    [self.view addSubview:view];
    
    [self createContentView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createContentView {
    
    
    _sliderMenuView = [[LRSliderMenuView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) titleArray:TITLES titleHeight:NAVIGATIONBAR_HEIGHT normalColor:COLOR_WITH_HEX(0x98A4B8, 1.0) selectedColor:[UIColor whiteColor] normalFont:[UIFont cy_PingFangSC_RegularFontOfSize:RESIZE(14)] selectedFont:[UIFont cy_PingFangSC_RegularFontOfSize:RESIZE(16)] normalFontSize:14.0 selectedFontSize:16.0];
    
    _sliderMenuView.titleViewBackgroundColor = COLOR_WITH_HEX(0x1C3764, 1.0);
    _sliderMenuView.delegate = self;
    
    [self.view addSubview:self.sliderMenuView];
    
    for (int i = 0; i < TITLES.count; i++) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH,SCREEN_HEIGHT-NAVIGATIONBAR_HEIGHT)];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        
        [tableView registerClass:[InfoTableViewCell class] forCellReuseIdentifier:KYAInfoTableViewCellIdentifier];
        
//        if (i == 0) {
//            KYAInfoDetailViewController *detailVc = [[KYAInfoDetailViewController alloc]init];
//            detailVc.contentHtmlUrl = [KYACommonConfigurationManager sharedManager].commonConfigurationModel.aboutkyzc_h5link;
//            detailVc.isFromInfoVc = YES;
//            [self addChildViewController:detailVc];//保证子vc正常的生命周期调用
//            [self.sliderMenuView.contentScrollView addSubview:detailVc.view];
//            [self.tableViewArray addObject:detailVc.view];
//        }else{
//            [self.sliderMenuView.contentScrollView addSubview:tableView];
//            [self.tableViewArray addObject:tableView];
//        }

        [self.sliderMenuView.contentScrollView addSubview:tableView];
        [self.tableViewArray addObject:tableView];
        
        
        
        NSMutableArray *listArray = [NSMutableArray arrayWithCapacity:0];
        //创建数据
        for (int i = 0; i < 10; i++) {
            InfoModel *model = [[InfoModel alloc]init];
            model.theme = [NSString stringWithFormat:@"theme-%d",i];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            dateFormat.dateFormat = @"yyyy-MM-dd HH:mm:ss";
            model.add_time = [NSString stringWithFormat:@"%@%d",[dateFormat stringFromDate:[NSDate date]],i];
            [listArray addObject:model];
        }
        
        [self.sourceListArray addObject:listArray];
        
        NSNumber *pageNum = [NSNumber numberWithInteger:1];
        [self.pageNumArray addObject:pageNum];
        
        NSNumber *clickNum = [NSNumber numberWithInteger:0];
        if (i == 0) {
            clickNum = [NSNumber numberWithInteger:1];
        }
        [self.clickTimeArray addObject:clickNum];
        
        if (i == 0) {
            self.currentTableView = tableView;
            self.currentListArray = listArray;
            self.currentIndex = i;
        }
        
        self.currentPageNum = 1;
        
//        WEAKSELF
//        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            weakSelf.currentPageNum = 1;
//            [weakSelf.pageNumArray replaceObjectAtIndex:weakSelf.currentIndex withObject:[NSNumber numberWithInteger:weakSelf.currentPageNum]];
//            [weakSelf requestDataWithKYAInfoType:[weakSelf typeFromIndex:weakSelf.currentIndex] append:NO];
//        }];
        //        [tableView addLegendHeaderWithRefreshingBlock:^{
        //            weakSelf.currentPageNum = 1;
        //            [weakSelf.pageNumArray replaceObjectAtIndex:weakSelf.currentIndex withObject:[NSNumber numberWithInteger:weakSelf.currentPageNum]];
        //            [weakSelf requestDataWithKYAInfoType:[weakSelf typeFromIndex:weakSelf.currentIndex] append:NO];
        //        }];
        //        [tableView addLegendFooterWithRefreshingBlock:^{
        //            [weakSelf requestMoreData];
        //        }];
    }
    
//    if (_isFromHome) {
//        NSInteger selectIndex = [self indexFromType:self.selectInfoType];
//        self.sliderMenuView.selectIndex = selectIndex;
//    }
    
}


#pragma mark- LRSliderMenuViewDelegate
- (void)sliderMenuView:(LRSliderMenuView *)sliderMenuView didClickMenuItemAtIndex:(NSInteger)index {
    self.currentTableView = self.tableViewArray[index];
    NSNumber *pageNum = self.pageNumArray[index];
    self.currentPageNum = pageNum.integerValue;
    self.currentIndex = index;
    self.currentListArray = self.sourceListArray[index];
    
    
    NSNumber *clickNum = self.clickTimeArray[index];
    NSInteger clickIndex = clickNum.integerValue;
    if (clickIndex > 0) {
        return;
    }
    clickIndex++;
    clickNum = [NSNumber numberWithInteger:clickIndex];
    [self.clickTimeArray replaceObjectAtIndex:index withObject:clickNum];
    //只有第一次点击才可以请求 @[@"坤元动态",@"行业新闻",@"政策法规"]
//    switch (index) {
//        case 0+1:
//        {
//            [self requestDataWithKYAInfoType:KYAInfoTypeCompanyState append:NO];
//
//        }
//            break;
//        case 1+1:
//        {
//            [self requestDataWithKYAInfoType:KYAInfoTypeTradeNews append:NO];
//        }
//            break;
//        case 2+1:
//        {
//            [self requestDataWithKYAInfoType:KYAInfoTypePolicies append:NO];
//        }
//            break;
//
//        default:
//            break;
//    }
}


#pragma mark- UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    //    array = self.sourceListArray[self.currentIndex];
    return self.currentListArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KYAInfoTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[InfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KYAInfoTableViewCellIdentifier];
    }
    //    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    //    array = self.sourceListArray[self.currentIndex];
    cell.model = self.currentListArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    //    array = self.sourceListArray[self.currentIndex];
    WEAKSELF
    return [tableView fd_heightForCellWithIdentifier:KYAInfoTableViewCellIdentifier configuration:^(InfoTableViewCell *cell) {
        cell.model = weakSelf.currentListArray[indexPath.row];
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    NSMutableArray *array = [NSMutableArray arrayWithCapacity:0];
    //    array = self.sourceListArray[self.currentIndex];
    
//    KYAInfoDetailViewController *detailVc = [[KYAInfoDetailViewController alloc]init];
//    KYAInfoModel *infoModel = self.currentListArray[indexPath.row];
//    detailVc.contentHtmlUrl = infoModel.url;
//    detailVc.title = [NSString stringWithFormat:@"%@详情",TITLES[self.currentIndex]];
//    [self.navigationController pushViewController:detailVc animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
