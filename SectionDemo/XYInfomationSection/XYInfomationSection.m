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

/** cell 长按移动相关 */
@property (nonatomic, strong)       UILongPressGestureRecognizer *longPress;
@property (nonatomic, assign)       CGPoint lastPoint;
@property (nonatomic, strong)       UIImageView *snapCell;
@property (nonatomic, strong)       NSMutableArray <XYInfomationItem *>*tempDataArray;
@property (nonatomic, strong)       NSMutableArray <UIImageView*>*tempSnapCells;
@end

@interface XYInfomationSection (CellMove)
- (void)addGesture;
- (void)moveCellSnapFrom:(NSInteger)fromIndex to:(NSInteger)toIndex;
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
    
    [self addGesture];
    
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
        // 对于折叠的数据，直接过滤，提升性能
        if (self.isImprovePerformance && item.isFold) {
            continue;
        }
        
        
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

- (void)moveCellFrom:(NSInteger)fromIndex to:(NSInteger)toIndex{
    [self moveCellSnapFrom:fromIndex to:toIndex];
    [self refreshSectionWithDataArray:self.tempDataArray];
}

- (void)dealloc
{
    the_bottom_cell = nil;
}

@end

@implementation XYInfomationSection (CellMove)

static NSTimeInterval CellMoveAnimationTime = 0.25;

- (void)setEditMode:(BOOL)editMode{
    _editMode = editMode;
    self.longPress.enabled = editMode;
}

- (void)addGesture
{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(procesLongPress:)];
    longPress.enabled = self.editMode;
    self.longPress = longPress;
    longPress.minimumPressDuration = 1.0f;
    [self addGestureRecognizer:longPress];
}

- (void)procesLongPress:(UILongPressGestureRecognizer *)press {
//    NSLog(@"longPress ---- %zd",press.state);
//    NSLog(@"longPressView = %@",press.view);
    CGPoint currentPoint = [press locationInView:press.view];
//    NSLog(@"longPressView.loacation = %@",NSStringFromCGPoint(currentPoint));
    
    switch (press.state) {
        case UIGestureRecognizerStateBegan:
            [self procesLongPressBeginWithCurrentPoint:currentPoint];
            break;
        case UIGestureRecognizerStateChanged:
            [self procesLongPressMovedWithCurrentPoint:currentPoint];
            break;
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            [self procesLongPressEndWithCurrentPoint:currentPoint];
            break;
        default:
            break;
    }
}

- (XYInfomationCell *)cellWithCurrentPoint:(CGPoint)point{
    XYInfomationCell *thePressCell = nil;
    for (XYInfomationCell *cell in self.subviews) {
        if (CGRectContainsPoint(cell.frame, point) && [cell isKindOfClass:XYInfomationCell.class]) {
            thePressCell = cell;
        }
    }
    return thePressCell;
}

- (UIImageView *)cellSnapWithCurrentPoint:(CGPoint)point{
    UIImageView *cellSnap = nil;
    for (UIView *cell in self.subviews) {
        if (CGRectContainsPoint(cell.frame, point) && [cell isKindOfClass:UIImageView.class] && cell != self.snapCell) {
            cellSnap = (UIImageView*)cell;
        }
    }
    return cellSnap;
}

- (void)makeAllCell2Snap{
    
    NSMutableArray *snaps = @[].mutableCopy;
    for (XYInfomationCell *cell in self.subviews) {
        UIImageView *snap = [self snapshotViewWithInputView:cell];
        if (snap) {
            snap.tag = cell.tag;
            [snaps addObject:snap];
            snap.frame = cell.frame;
            cell.hidden = YES;
        }
    }
    
    for (UIView *snap in snaps) {
        [self addSubview:snap];
    }
    
    self.tempSnapCells = snaps;
}

- (UIImageView *)snapshotViewWithInputView:(UIView *)inputView
{
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *snapshot = [[UIImageView alloc] initWithImage:image];
    return snapshot;
}

- (NSMutableArray<XYInfomationItem *> *)tempDataArray{
    if (_tempDataArray == nil) {
        _tempDataArray = @[].mutableCopy;
        for (XYInfomationItem *item in self.dataArray) {
            [_tempDataArray addObject:item.mutableCopy];
        }
    }
    return _tempDataArray;
}
- (NSMutableArray<UIImageView *> *)tempSnapCells{
    if (!_tempSnapCells) {
        [self makeAllCell2Snap];
    }
    return _tempSnapCells;
}

- (void)procesLongPressBeginWithCurrentPoint:(CGPoint)point{
    
    self.lastPoint = point;
    [self makeAllCell2Snap];
    
    UIImageView *snapView = [self cellSnapWithCurrentPoint:point];
    if (self.customMovableCellwithSnap) {
        UIView *customSnap = self.customMovableCellwithSnap(snapView);
        if (customSnap == snapView) { // 修改后的原来cellSnap
            // 直接使用，无需额外操作
        }else{
            UIView *contentView = [[UIView alloc] initWithFrame:snapView.bounds];
            [snapView addSubview:contentView];
            
            [contentView addSubview:customSnap];
            customSnap.frame = contentView.bounds;
        }
    }else{
        snapView.backgroundColor = UIColor.whiteColor;
        snapView.layer.shadowColor = [UIColor grayColor].CGColor;
        snapView.layer.masksToBounds = NO;
        snapView.layer.cornerRadius = 0;
        snapView.layer.shadowOffset = CGSizeMake(-5, 0);
        snapView.layer.shadowOpacity = 0.4;
        snapView.layer.shadowRadius = 5;
    }

    [self bringSubviewToFront:snapView];
    self.snapCell = snapView;
    self.snapCell.tag = [self getCellIndexWithCurrentPoint:point];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.snapCell.center = CGPointMake(snapView.center.x, snapView.center.y - 5); // 上移5pt,模拟动画
    }];
}

- (void)procesLongPressMovedWithCurrentPoint:(CGPoint)point{
    
    // 禁止出界
    CGFloat snapHeight = self.snapCell.bounds.size.height;
    if (point.y < snapHeight/2) {
        point.y = snapHeight/2;
    }
    if (point.y > self.bounds.size.height - snapHeight/2) {
        point.y = self.bounds.size.height - snapHeight/2;
    }
    
    // cell 跟手移动
    self.snapCell.center = CGPointMake(self.snapCell.center.x, point.y - 5);
    
    // 后面的cell 也要根据当前point 配合滑动动画
//    UIImageView *bgSnapCell = [self cellSnapWithCurrentPoint:point];
//    if (!bgSnapCell) { return; }
    
//    CGRect cellTopRect = CGRectMake(bgSnapCell.frame.origin.x, bgSnapCell.frame.origin.y, bgSnapCell.frame.size.width, bgSnapCell.frame.size.height/2);
//    CGRect cellBottomRect = CGRectMake(bgSnapCell.frame.origin.x, bgSnapCell.frame.origin.y + bgSnapCell.frame.size.height/2, bgSnapCell.frame.size.width, bgSnapCell.frame.size.height/2);
//
//    if (CGRectContainsPoint(bgSnapCell.frame, self.lastPoint) &&
//        !CGRectContainsPoint(cellTopRect, self.lastPoint) &&
//        CGRectContainsPoint(cellTopRect, point)) { // 从下到上
//        [UIView animateWithDuration:CellMoveAnimationTime animations:^{
//            CGPoint center = bgSnapCell.center;
//            center.y += self.snapCell.bounds.size.height;
//            bgSnapCell.center = center;
//        }];
//    }
//    if (CGRectContainsPoint(bgSnapCell.frame, self.lastPoint) &&
//              !CGRectContainsPoint(cellBottomRect, self.lastPoint) &&
//              CGRectContainsPoint(cellBottomRect, point)){ // 从上到下
//        [UIView animateWithDuration:CellMoveAnimationTime animations:^{
//            CGPoint center = bgSnapCell.center;
//            center.y -= self.snapCell.bounds.size.height;
//            bgSnapCell.center = center;
//        }];
//    }
    
    
    NSInteger toIndex = [self getCellIndexWithCurrentPoint:point];
    if (toIndex < 0 || toIndex >= self.tempSnapCells.count) {
        return;
    }
    
    NSInteger fromIndex = self.snapCell.tag;
    if (toIndex != self.snapCell.tag) {
        [self moveCellSnapFrom:fromIndex to:toIndex];
    }
    
    // 数据源处理
    self.lastPoint = point;
}

- (void)procesLongPressEndWithCurrentPoint:(CGPoint)point{
    
    self.snapCell.hidden = YES;
    [self.snapCell removeFromSuperview];
    
    // NSLog(@"原本数据源 %@",self.dataArray);
    // NSLog(@"最新数据源 %@",self.tempDataArray);
    if (self.sectionCellHasMoved) { // 外界处理是否移动成功，使用新旧数据源
        NSMutableArray *oldData = @[].mutableCopy;
        for (XYInfomationItem *item in self.dataArray) {
            [oldData addObject:item.mutableCopy];
        }
        [self refreshSectionWithDataArray:self.tempDataArray];
        self.sectionCellHasMoved(self, oldData, self.tempDataArray);
    }else{ // 默认移动成功，成功后 self.dataArray 会被更新
        [self refreshSectionWithDataArray:self.tempDataArray];
    }
}

- (NSInteger)getCellIndexWithCurrentPoint:(CGPoint)point{
    
    NSInteger result = -1;
    
    for (UIView *snap in self.subviews) {
        result += 1;
        if (CGRectContainsPoint(snap.frame, point)) {
            break;
        }
    }
    
    return result;
}

- (void)moveCellSnapFrom:(NSInteger)fromIndex to:(NSInteger)toIndex{
    
    XYInfomationCell *f_c = self.subviews[fromIndex];
    UIImageView *toCell = self.tempSnapCells[toIndex];
    CGRect toRect = f_c.frame;
    
    [UIView animateWithDuration:CellMoveAnimationTime animations:^{
        toCell.frame = toRect;
    }];
    
    [self.tempDataArray exchangeObjectAtIndex:fromIndex withObjectAtIndex:toIndex];
    [self.tempSnapCells exchangeObjectAtIndex:fromIndex withObjectAtIndex:toIndex];
    self.snapCell.tag = toIndex;
}

@end
