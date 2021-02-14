//
//  XYInfomationSection.m
//  qyxiaoyou
//
//  Created by 渠晓友 on 2019/5/23.
//  Copyright © 2019年 qyxiaoyou. All rights reserved.
//

#import "XYInfomationSection.h"
#import "Masonry.h"

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
        self.clipsToBounds = YES;
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
    
    // 重置背景色
    [self resetSelfBgColor];
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

// 创建内容
static UIView *the_bottom_cell = nil;
- (void)setupContent
{
    // 移除之前内容
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
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
        
        // cell 底部分割线颜色和内边距
        if (self.separatorColor) {
            UIView *lineView = cell.subviews.lastObject;
            lineView.backgroundColor = self.separatorColor;
        }
        if (!UIEdgeInsetsEqualToEdgeInsets(self.separatorInset, UIEdgeInsetsZero)) {
            UIView *lineView = cell.subviews.lastObject;
            [lineView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lineView.superview).offset(self.separatorInset.left);
                make.right.equalTo(lineView.superview).offset(-self.separatorInset.right);
            }];
        }
        
        // cell 间隔的间距
        NSInteger offset = self.separatorHeight ?: 0;
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
        
        // 如设置cell内部间距，默认self.bgColor=.clear 且 cell.bgColor=.white
        UIView *lineView = cell.subviews.lastObject;
        lineView.hidden = (offset);
        if (offset) {
            self.backgroundColor = UIColor.clearColor;
            cell.backgroundColor = cell.model.backgroundColor ?: UIColor.whiteColor;
        }
        
        // 设置此cell为底部的cell
        the_bottom_cell = cell;
    }

    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(the_bottom_cell).offset(0);
    }];
}

#warning todo - will add 刷新数据
- (void)refreshSectionWithDataArray:(NSArray *)dataArray
{
//    if (self.dataArray.count != dataArray) {
//        return;
//    }
    if (dataArray.count == 0) {
        return;
    }
    
    // 刷新内容
    
    self.dataArray = dataArray;
    
}

- (void)resetSelfBgColor{
    
    // 如果内部的cell设置背景图片就，设置
    UIImage *lastBgImage = [UIImage imageNamed:self.dataArray.lastObject.backgroundImage];
    if (lastBgImage) {
        self.backgroundColor = UIColor.clearColor;
    }
}

/** 折叠数据 */
- (void)foldCellWithIndexs:(NSArray <NSNumber *>*)indexsArr
{
    
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
- (void)unfoldAllCells
{
    [self foldCellWithIndexs:@[]];
}


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
    // 2.1 更新item，防止脏数据
    for (XYInfomationItem *item in self.dataArray) {
        item.fold = NO;
    }
    // 2.2 更新最新 fold 状态
    for (NSNumber *indexNumber in self.foldIndexs) {
        NSInteger index = [indexNumber integerValue];
        XYInfomationItem *item = self.dataArray[index];
        item.fold = YES;
    }
    
    // 3.刷新页面
    // 3.1 移除自己之前的约束
    for (NSLayoutConstraint *cons in self.constraints) {
        cons.active = NO;
    }
    
    // 3.2 重新刷新数据
    self.dataArray = self.dataArray;
    
    
    // 4.不保存当前折叠状态
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
