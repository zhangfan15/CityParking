//
//  THDatePickerView.h
//  rongyp-company
//
//  Created by Apple on 2016/11/16.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class THDatePickerView;
@protocol THDatePickerViewDelegate <NSObject>

/**
 保存按钮代理方法
 
 @param timer 选择的数据
 */
- (void)datePickerView:(THDatePickerView *)pickerView SaveBtnClickDelegate:(NSString *)timer;

/**
 取消按钮代理方法
 */
- (void)datePickerViewCancelBtnClickDelegate:(THDatePickerView *)pickerView;

@end

@interface THDatePickerView : UIView

@property (copy, nonatomic) NSString *title;
@property (weak, nonatomic) id <THDatePickerViewDelegate> delegate;

/// 显示
- (void)show;

@end

