//
//  XYInfomationSection.m
//  qyxiaoyou
//
//  Created by 渠晓友 on 2019/5/23.
//  Copyright © 2019年 qyxiaoyou. All rights reserved.
//

#import "XYInfomationSection.h"

@interface XYInfomationSection ()
/** foldIndexs */
@property (nonatomic, strong)       NSMutableArray * foldIndexs;
@end
@implementation XYInfomationSection

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self baseUIConfig:NO];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self baseUIConfig:NO];
}

/**
 创建section样式：根据是否创建初始样式

 @param original 是否为初始样式  YES:无圆角&白色背景  NO:圆角为10，背景色透明
 */
- (void)baseUIConfig:(BOOL)original{
    _foldIndexs = @[].mutableCopy;
    
    if (!original) { // 创建默认style
        self.layer.cornerRadius = 10;
        self.backgroundColor = UIColor.whiteColor;
        self.clipsToBounds = YES;
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }else
    {
        self.layer.cornerRadius = 0;
        self.backgroundColor = UIColor.whiteColor;
        self.clipsToBounds = NO;
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
}

+ (instancetype)sectionWithData:(NSArray<XYInfomationItem *> *)dataArray
{
    XYInfomationSection *section = [XYInfomationSection new];
    section.dataArray = dataArray;
    return section;
}

+ (instancetype)sectionForOriginal{
    return [[XYInfomationSection alloc] initForOriginal];
}
- (instancetype)initForOriginal{
    if (self != [super init])
    {
        self = [XYInfomationSection new];
    }
    [self baseUIConfig:YES];
    return self;
}

- (void)setDataArray:(NSArray *)dataArray
{
    
    _dataArray = dataArray;
    [self setupContent];
    
//    if (_dataArray.count != dataArray.count) {
//        _dataArray = dataArray;
//
//        [self setupContent];
//    }else
//    {
//        _dataArray = dataArray;
//        [self refreshSectionWithDataArray:dataArray];
//    }
    
    // 重置背景色
    [self resetSelfBgColor];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

// 创建内容
static UIView *the_bottom_cell = nil;
- (void)setupContent
{
    // 根据内容数组来创建对应的cells，自己适应高度
    int index = -1;
    for (XYInfomationItem *item in self.dataArray) {
        index++;
        
        XYInfomationCell *cell = [XYInfomationCell cellWithModel:item];
        cell.translatesAutoresizingMaskIntoConstraints = NO;
        cell.tag = index;
        [self addSubview:cell];
        __weak typeof(self) weakSelf = self;
        cell.cellTouchBlock = ^(XYInfomationCell * _Nonnull cell) {
            if (weakSelf.cellClickBlock) {
                weakSelf.cellClickBlock(cell.tag, cell);
            }
        };
        
#warning todo - will add 组内的内距
        NSInteger offset = 0;
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {

            
            if (index == 0) {
                make.top.equalTo(weakSelf).offset(0);
            }else
            {
                make.top.equalTo(the_bottom_cell.mas_bottom).offset(offset);
            }

            make.left.equalTo(weakSelf);
            make.right.equalTo(weakSelf);
        }];
        
        if (offset) {
            cell.backgroundColor = UIColor.greenColor;
        }
        
        // 设置此cell为底部的cell
        the_bottom_cell = cell;
    }
    
    [the_bottom_cell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(0);
    }];
    
    
}

#warning todo - will add 刷新数据
- (void)refreshSectionWithDataArray:(NSArray *)dataArray
{
    if (self.dataArray.count != dataArray) {
        return;
    }
    
    // 刷新内容
}

- (void)resetSelfBgColor{
    
    // 如果内部的cell设置背景图片就，设置
    UIImage *lastBgImage = [UIImage imageNamed:self.dataArray.lastObject.backgroundImage];
    if (lastBgImage) {
        self.backgroundColor = UIColor.clearColor;
    }else
    {
        self.backgroundColor = UIColor.whiteColor;
    }
}

/** 折叠数据 */
- (void)foldCellWithIndexs:(NSArray <NSNumber *>*)indexsArr
{
    if (indexsArr.count) { // 传入有数据
        for (XYInfomationCell *cell in self.subviews) {
            
            for (NSLayoutConstraint *layout in cell.constraints) {
                if ([layout respondsToSelector:@selector(uninstall)]) {
                    [layout performSelector:@selector(uninstall)];
                }else
                {
                    [NSLayoutConstraint deactivateConstraints:cell.constraints];
                }
            }
            
            [cell removeFromSuperview];
        }
    }
    
    
    // 更新内部 foldIndexs
    for (NSNumber *index in indexsArr) {
        if (![self.foldIndexs containsObject:index]) {
            [self.foldIndexs addObject:index];
        }
    }
    
    // 跟新折叠UI
    [self updateFoldUI];

}

// 要避免折叠的项目
- (void)foldCellWithoutIndexs:(NSArray <NSNumber *>*)indexsArr
{
    if (indexsArr.count) { // 传入有数据
        for (XYInfomationCell *cell in self.subviews) {
            
            for (NSLayoutConstraint *layout in cell.constraints) {
                if ([layout respondsToSelector:@selector(uninstall)]) {
                    [layout performSelector:@selector(uninstall)];
                }else
                {
                    [NSLayoutConstraint deactivateConstraints:cell.constraints];
                }
            }
            
            [cell removeFromSuperview];
        }
    }
    
    // 更新内部 foldIndexs
    for (id obj in self.dataArray) {
        NSInteger index = [self.dataArray indexOfObject:obj];
        if ([indexsArr containsObject:[NSNumber numberWithInteger:index]]) {
            continue;
        }
        [self.foldIndexs addObject:[NSNumber numberWithInteger:index]];
    }
    
    // 跟新折叠UI
    [self updateFoldUI];
}

/////** 展开数据 */
//- (void)unfoldCellWithIndexs:(NSArray <NSNumber *>*)indexs{
//
//}
// 要展开的项目
//- (void)unfoldCellWithoutIndexs:(NSArray <NSNumber *>*)indexs;  // 要避免展开的项目

/// 更新展开，合并的UI
- (void)updateFoldUI{
    
    // 1. 处理是否越界
    for (NSNumber *index in self.foldIndexs) {
        if ([index integerValue] >= self.dataArray.count) {
            NSException *e = [NSException exceptionWithName:@"更新数据的数组越界" reason:nil userInfo:nil];
            [e raise];
        }
    }
    
    // 2.更新数据
    for (NSNumber *indexNumber in self.foldIndexs) {
        NSInteger index = [indexNumber integerValue];
        XYInfomationItem *item = self.dataArray[index];
        item.fold = YES;
    }
    
    // 3.刷新页面
    self.dataArray = self.dataArray;
    
    
    // 4.不保存当前折叠状态
    for (NSNumber *indexNumber in self.foldIndexs) {
        NSInteger index = [indexNumber integerValue];
        XYInfomationItem *item = self.dataArray[index];
        if (item.isFold) {
            item.fold = !item.isFold;
        }
    }
    [_foldIndexs removeAllObjects];
}


#pragma mark - public getter
/// 返回内容中所有keyValues
- (NSDictionary *)contentKeyValues{
    
    NSMutableDictionary *dict = @{}.mutableCopy;
    for (XYInfomationCell *cell in self.subviews) {
        XYInfomationItem *model = cell.model;
        
        if ([[cell valueForKey:@"cell_type"] integerValue] == XYInfoCellTypeChoose) {
            if (model.valueCode) {
                [dict setObject:model.valueCode forKey:model.titleKey];
            }else
            {
                [dict setObject:@"" forKey:model.titleKey];
            }
            
        }else // input 类型也优先取 code，一般情况不会存在，如果有即用户特意添加的
        {
            if (model.valueCode) {
                [dict setObject:model.valueCode forKey:model.titleKey];
            }else
            {
                if (model.value) {
                    [dict setObject:model.value forKey:model.titleKey];
                }else
                {
                    [dict setObject:@"" forKey:model.titleKey];
                }
            }
        }
    }
    
    return [dict copy];
}

- (void)dealloc
{
    the_bottom_cell = nil;
}

@end
