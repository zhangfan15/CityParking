//
//  ViewController.m
//  Gesture_Test
//
//  Created by Josie on 2017/7/4.
//  Copyright © 2017年 Josie. All rights reserved.
//

#import "SecondViewController.h"
#import "public.h"

@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate,UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource>{
    NSArray                       * titleArr;
    NSArray                       * imageNameArr;
    NSArray                       * tableImageArr;
    NSArray                       * tableTitleArr;
    NSArray                       * sctionTitleArr;
    NSArray                       * sctionArr;
    NSMutableArray                * rowsNumber;
    NSArray                       * tableData;
    NSInteger                       collectionIndex;
}

//@property (nonatomic, weak) UISearchBar       *search; // 数据源 存放搜索历史数据

//@property (nonatomic, strong) UISearchBar       *searchBar;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = COLOR_WITH_HEX(0x417293);
    self.view.userInteractionEnabled = YES;
    
    self.view.clipsToBounds = YES;
//    self.view.layer.cornerRadius = 10;
    titleArr = @[@"全部",@"停车",@"共享车位",@"神州租车",@"立体",@"慢行",@"巴士",@"地铁",@"出租车",@""];
    imageNameArr = @[@"markAll",@"markPark",@"markShare",@"markRent",@"markBuilding",@"markBike",@"markBus",@"markTrain",@"markTaxi",@""];
    tableImageArr = @[@"markHome",@"markCompany"];
    tableTitleArr = @[@"带我回家",@"带我上班"];
    sctionTitleArr = @[@"常用公交线路",@"常用停车场",@"常用线路列表",@"本地地图",@"当地时讯"];
    rowsNumber = [NSMutableArray arrayWithObjects:@"1",@"3",@"3",@"2",@"3",@"2",@"2", nil];
    sctionArr = @[@"全部",@"平面库",@"共享车位",@"神州租车",@"立体库",@"慢行",@"巴士",@"地铁",@"出租车",@""];
    [self setTableView];
}
- (void)setTableView
{
    //    self.table.tableHeaderView = self.searchController.searchBar;
    [self.view addSubview:self.table];
}

#pragma mark - UISearchBarDelegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    // 删除text时收键盘
    if (searchText.length == 0) {
        UIButton *cancelBtn = [searchBar valueForKey:@"cancelButton"]; //首先取出cancelBtn
        // 代码触发Button的点击事件
        [cancelBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    
//    NSLog(@"----------- TextDidBeginEditing ------------");
    // 一点击textField时 就调用这个方法。  让self.view的y坐标改变
    
    // 收键盘
//    [self.searchController.searchBar endEditing:YES];
//    UIButton *cancelBtn = [searchBar valueForKey:@"cancelButton"]; //首先取出cancelBtn
//    // 代码触发Button的点击事件
//    [cancelBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [UIView animateWithDuration:0.5 animations:^{
//            self.view.frame = CGRectMake(0, 54, SCREEN_WIDTH, SCREEN_HEIGHT);
//        }];
//    });
    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
//    view.backgroundColor = [UIColor yellowColor];
//    self.searchController.searchBar.inputAccessoryView = view;
}

-(void)didClickTextField:(DidClickTextFieldBlock)block
{
    self.didClickTextFieldBlock = block;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *textStr = searchBar.text;
    NSLog(@"`````` %@ ```````````", textStr);
    // 清空textfield
    searchBar.text = @"";
    
    // 插入路径的同时，要同步插入数据
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.table insertRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationBottom];
}

/**
      每次点击searchBar的textField时，都会走这个方法
 
 *      返回false时， searchBar的textField点击没有反应
 *      默认返回true
 */
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
//    _search.showsCancelButton = YES;
    if (!self.offsetY) {
        self.offsetY = Y3;
    }
    
    // 如果点击时，shadowView的y坐标 在Y2 Y3的位置，
    if (self.offsetY > Y1) {
//        NSLog(@"----------- y = %f ------------",self.offsetY);
        // ============ 触发block =============
        if (self.didClickTextFieldBlock) {
            self.didClickTextFieldBlock();
        }
        return false;
    }
    
    
    return true;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_showParkTable) {
        return tableData.count;
    }
    return rowsNumber.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_showParkTable) {
        return 1;
    }
    NSInteger rows = [rowsNumber[section] integerValue];
    return rows;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_showParkTable) {
        return 86;
    }
    switch (indexPath.section) {
        case 0:
            return 54;
            break;
        case 1:
            return 40;
            break;
        default:{
            if (indexPath.row == 0) {
                return 40;
            }
            return 54;
        }
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_showParkTable) {
        MapParkDataCell * cell = [self.table dequeueReusableCellWithIdentifier:@"MapParkDataCell" forIndexPath:indexPath];
        MarkModel * model = [tableData objectAtIndex:indexPath.section];
        cell.parkImage.image = [UIImage imageNamed:model.tp];
        cell.parkDistance.text = [NSString stringWithFormat:@"%@米",model.juli];
        cell.parkName.text = model.cname;
        cell.parkAdress.text = model.dz;
        if (model.time != nil && [model.time isKindOfClass:[NSString class]]) {
            cell.parkTime.text = [NSString stringWithFormat:@"时间：%@",model.time];
        }else {
            cell.parkTime.text = @"时间：00:00-23:59";
        }
        
        cell.parkNumber.text = [NSString stringWithFormat:@"车位：%@/%.lf",model.totalNumber,model.sycw];
        cell.parkPrice.text = [NSString stringWithFormat:@"¥%@／h",model.charge];
        
        return cell;
    }else {
        switch (indexPath.section) {
            case 0:{
                MapSearchCell * cell = [self.table dequeueReusableCellWithIdentifier:@"MapSearchCell" forIndexPath:indexPath];
                cell.searchBar.delegate = self;
                _search = cell.searchBar;
                return cell;
            }
                break;
            case 1:{
                if (indexPath.row == 2) {
                    MapAddCell * cell = [self.table dequeueReusableCellWithIdentifier:@"MapAddCell" forIndexPath:indexPath];
                    return cell;
                }
                MapEditCell * cell = [self.table dequeueReusableCellWithIdentifier:@"MapEditCell" forIndexPath:indexPath];
                cell.cellImage.image = [UIImage imageNamed:tableImageArr[indexPath.row]];
                cell.cellTitle.text  = tableTitleArr[indexPath.row];
                return cell;
            }
                break;
            default:{
                if (indexPath.row == 0) {
                    SectionTitleCell * cell = [self.table dequeueReusableCellWithIdentifier:@"SectionTitleCell" forIndexPath:indexPath];
                    cell.contentView.backgroundColor = UIColor.greenColor;
                    cell.cellTitle.text  = sctionTitleArr[indexPath.section-2];
                    if (indexPath.section == 3) {
                        [cell.cellButton setTitle:@"" forState:UIControlStateNormal];
                        [cell.cellButton setImage:[UIImage imageNamed:@"mapNearby"] forState:UIControlStateNormal];
                    }else if (indexPath.section == 5) {
                        [cell.cellButton setTitle:@"" forState:UIControlStateNormal];
                        [cell.cellButton setImage:[UIImage imageNamed:@"mapDownload"] forState:UIControlStateNormal];
                    }else {
                        [cell.cellButton setTitle:@"more..." forState:UIControlStateNormal];
                        [cell.cellButton setImage:nil forState:UIControlStateNormal];
                    }
                    return cell;
                }
                BusLineCell * cell = [self.table dequeueReusableCellWithIdentifier:@"BusLineCell" forIndexPath:indexPath];
                //            cell.cellImage.image = [UIImage imageNamed:tableImageArr[indexPath.row]];
                //            cell.cellTitle.text  = tableTitleArr[indexPath.row];
                return cell;
            }
                break;
        }
    }
    return nil;
}

// ************************
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (_showParkTable && !section) {
        return 50;
    }
    if (section ==0) {
        return CollectionHeight+20;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (_showParkTable) {
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 50)];
        backgroundView.backgroundColor = COLOR_WITH_HEX(0x417293);
        UIImage * image = [UIImage imageNamed:@"markPark"];
        CGSize rect = image.size;
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (50-rect.height)/2, rect.width, rect.height)];
        [imageView setImage:[UIImage imageNamed:imageNameArr[collectionIndex]]];
        [backgroundView addSubview:imageView];
        UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(rect.width+5, 0, backgroundView.frame.size.width-rect.width-5, 50)];
        lable.font = [UIFont systemFontOfSize:15.f];
        lable.textColor = [UIColor whiteColor];
        lable.text = sctionArr[collectionIndex];
        [backgroundView addSubview:lable];
        return backgroundView;
    }
    if (section == 0) {
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, CollectionHeight+20)];
        backgroundView.backgroundColor = COLOR_WITH_HEX(0x417293);
        
        UIImageView *image = [[UIImageView alloc] init];
        image.frame = CGRectMake((SCREEN_WIDTH-40)/2.0, -2, 40, 28);
        image.image = [UIImage imageNamed:@"横线"];
        [backgroundView addSubview:image];
        
        [backgroundView addSubview:self.collection];
        
        return backgroundView;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (_showParkTable) {
        return 10;
    }
    if (section) {
        return 10;
    }
    return 0;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 10)];
    backgroundView.backgroundColor = COLOR_WITH_HEX(0x417293);
    return backgroundView;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // searchBar收起键盘
    UIButton *cancelBtn = [self.search valueForKey:@"cancelButton"]; //首先取出cancelBtn
//    UIButton *cancelBtn = [self.searchBar valueForKey:@"cancelButton"];
    // 代码触发Button的点击事件
    [cancelBtn sendActionsForControlEvents:UIControlEventTouchUpInside];
//    NSLog(@"+++++++ didSelect ++++++++");
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(tintColor)]) {
        
        CGFloat cornerRadius = 5.f;
        
        cell.backgroundColor = UIColor.clearColor;
        
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        
        CGMutablePathRef pathRef = CGPathCreateMutable();
        
        CGRect bounds = CGRectInset(cell.bounds, 0, 0);
        
        if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            
        } else if (indexPath.row == 0) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
            
            
        } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            
        } else {
            CGPathAddRect(pathRef, nil, bounds);
        }
        
        layer.path = pathRef;
        
        CFRelease(pathRef);
        
        //颜色修改
        
        layer.fillColor = [UIColor whiteColor].CGColor;
        
        //        layer.strokeColor=[UIColor blueColor].CGColor;
        
        
        UIView *testView = [[UIView alloc] initWithFrame:bounds];
        
        [testView.layer insertSublayer:layer atIndex:0];
        
        testView.backgroundColor = UIColor.clearColor;
        NSLog(@"%ld",indexPath.section);
        cell.backgroundView = testView;
    }
}

#pragma mark UICollectionViewDelegate,UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    //重用cell
    MarkCell *cell=[self.collection dequeueReusableCellWithReuseIdentifier:@"MarkCellIdentifier" forIndexPath:indexPath];
    cell.textLabel.text = titleArr[indexPath.item];
    NSString *imageName = imageNameArr[indexPath.item];
    cell.imageView.image = [UIImage imageNamed:imageName];
    if (indexPath.item == 4) {
        cell.verticalLine.hidden = YES;
    } else {
        cell.verticalLine.hidden = NO;
    }
    
    if (indexPath.item == 5 || indexPath.item == 6 || indexPath.item ==7 || indexPath.item ==8) {
        cell.horizontalLine.hidden = YES;
    } else {
        cell.horizontalLine.hidden = NO;
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    collectionIndex = indexPath.item;
    if ([self.delegate respondsToSelector:@selector(collectionDidSelectWithIndex:)]) {
        [self.delegate collectionDidSelectWithIndex:indexPath.item];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableView:) name:GetMapDataSuccessed object:nil];
}

- (void)reloadTableView:(NSNotification *)notification {
    tableData = [notification object];
    if (collectionIndex == 1 || collectionIndex == 3 || collectionIndex == 4 || collectionIndex == 5) {
        if (tableData != nil && tableData.count) {
            _showParkTable = YES;
            [_table reloadData];
        }
    }
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:GetMapDataSuccessed object:nil];
}

#pragma mark - 懒加载
- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, SCREEN_HEIGHT-50) style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        _table.bounces = NO;
        _table.backgroundColor = COLOR_WITH_HEX(0x417293);
        _table.userInteractionEnabled = YES;
        _table.scrollEnabled = NO; // 让table默认禁止滚动
        _table.showsVerticalScrollIndicator = NO;
        _table.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero]; // 去掉table的尾部
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_table registerNib:[UINib nibWithNibName:@"MapSearchCell" bundle:nil] forCellReuseIdentifier:@"MapSearchCell"];
        [_table registerNib:[UINib nibWithNibName:@"MapEditCell" bundle:nil] forCellReuseIdentifier:@"MapEditCell"];
        [_table registerNib:[UINib nibWithNibName:@"MapAddCell" bundle:nil] forCellReuseIdentifier:@"MapAddCell"];
        [_table registerNib:[UINib nibWithNibName:@"SectionTitleCell" bundle:nil] forCellReuseIdentifier:@"SectionTitleCell"];
        [_table registerNib:[UINib nibWithNibName:@"BusLineCell" bundle:nil] forCellReuseIdentifier:@"BusLineCell"];
        [_table registerNib:[UINib nibWithNibName:@"MapParkDataCell" bundle:nil] forCellReuseIdentifier:@"MapParkDataCell"];
    }
    return _table;
}

-(UICollectionView *)collection {
    if (!_collection) {
        UICollectionViewFlowLayout * customLayout = [[UICollectionViewFlowLayout alloc] init]; // 自定义的布局对象
        [customLayout setItemSize:CGSizeMake(CollectionHeight/2, CollectionHeight/2)];
        [customLayout setScrollDirection:UICollectionViewScrollDirectionVertical];//设置其布局方向
        customLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);//设置其边界
        customLayout.minimumInteritemSpacing=0;
        customLayout.minimumLineSpacing=0;
        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH-20, CollectionHeight) collectionViewLayout:customLayout];
        _collection.layer.cornerRadius = 5;
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.backgroundColor = UIColor.whiteColor;
        _collection.scrollEnabled = NO;
        [self.collection registerNib:[UINib nibWithNibName:@"MarkCell" bundle:nil] forCellWithReuseIdentifier:@"MarkCellIdentifier"];
    }
    return _collection;
}

@end

