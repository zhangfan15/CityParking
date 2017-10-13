//
//  SecondViewController.h
//  Gesture_Test
//
//  Created by Josie on 2017/7/4.
//  Copyright © 2017年 Josie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidClickTextFieldBlock)();

@protocol SecondViewControllerDelegate <NSObject>
@optional
- (void)collectionDidSelectWithIndex:(NSInteger)index;
@end

@interface SecondViewController : UIViewController
@property (nonatomic, weak)     id                      delegate;
@property (nonatomic, strong)   UITableView             *table;
@property (nonatomic, strong)   UICollectionView        *collection;
@property (nonatomic, strong)   UISearchBar             *search;
@property (nonatomic, copy)     DidClickTextFieldBlock  didClickTextFieldBlock;
@property (nonatomic, assign)   CGFloat                 offsetY; // shadowView在第一个视图中的位置  就3个位置：Y1 Y2 Y3;     offsetY初始值为0 无所谓 不影响结果
@property (nonatomic, assign)   BOOL                    showParkTable;

- (void)didClickTextField: (DidClickTextFieldBlock)block;

@end
