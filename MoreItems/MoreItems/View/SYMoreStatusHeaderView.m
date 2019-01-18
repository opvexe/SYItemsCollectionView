//
//  SYMoreStatusView.m
//  CEBMobileBank
//
//  Created by FaceBook on 2019/1/16.
//  Copyright © 2019年 Shen Yu. All rights reserved.
//

#import "SYMoreStatusHeaderView.h"
@interface SYMoreItemHeaderView : UIView
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UIButton *editButton;
@property(nonatomic,strong)UIView *verticaLineView;
@property(nonatomic,strong)UIView *bottomlineView;
@property(nonatomic,copy)void (^statusBlock)(SYMoreItemHeaderView *itemsView,BOOL isEdit);
@end
@implementation SYMoreItemHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _verticaLineView = ({
            UIView *iv = [[UIView alloc]init];
            iv.backgroundColor = NEW_PURPLE_COLOR;
            [self addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(10.0f);
                make.centerY.mas_equalTo(self);
                make.height.mas_equalTo(14.0f);
                make.width.mas_equalTo(3.0f);
            }];
            iv;
        });
        
        _nameLabel = ({
            UILabel *iv = [[UILabel alloc]init];
            [self addSubview:iv];
            iv.text = @"按住拖动调整顺序";
            iv.textColor = [UIColor blackColor];
            iv.font = [UIFont systemFontOfSize:16.0f];
            iv.textAlignment = NSTextAlignmentLeft;
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.verticaLineView.mas_right).mas_offset(5.0f);
                make.centerY.mas_equalTo(self);
                make.height.mas_equalTo(20.0f);
                make.width.mas_lessThanOrEqualTo(180.0f);
            }];
            iv;
        });
        
        _editButton = ({
            UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
            [self addSubview:iv];
            [iv setTitle:@"完成" forState:UIControlStateNormal];
            [iv setTitle:@"完成" forState:UIControlStateSelected];
            [iv setTitle:@"完成" forState:UIControlStateDisabled];
            [iv setTitle:@"完成" forState:UIControlStateHighlighted];
            [iv setTitleColor:NEW_PURPLE_COLOR forState:UIControlStateNormal];
            [iv setTitleColor:NEW_PURPLE_COLOR forState:UIControlStateSelected];
            [iv setTitleColor:NEW_PURPLE_COLOR forState:UIControlStateDisabled];
            [iv setTitleColor:NEW_PURPLE_COLOR forState:UIControlStateHighlighted];
            iv.titleLabel.textAlignment = NSTextAlignmentRight;
            iv.adjustsImageWhenHighlighted =NO;
            iv.showsTouchWhenHighlighted =NO;
            iv.titleLabel.font = [UIFont systemFontOfSize:16.0f];
            [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(-20.0f);
                make.height.mas_equalTo(20.0f);
                make.centerY.mas_equalTo(self);
                make.width.mas_lessThanOrEqualTo(60.0f);
            }];
            iv;
        });
        
        _bottomlineView = ({
            UIView *iv = [[UIView alloc] init];
            iv.backgroundColor =GRAY_BACK_GROUND_COLOR;
            [self addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0.5);
                make.bottom.mas_equalTo(self.mas_bottom);
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(0);
            }];
            iv;
        });
    }
    return self;
}

-(void)Click:(UIButton *)sender{
    if (self.statusBlock) {
        self.statusBlock(self,NO);
    }
}


@end

@interface SYMoreStatusHeaderCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIImageView *photosImageView;
@property(nonatomic,strong)UIButton *selectButton;
@property(nonatomic,strong)SYMoreListModel *model;
@property(nonatomic,copy)void (^decreaseBlock)(SYMoreStatusHeaderCollectionViewCell *itemCell,SYMoreListModel *model);
-(void)InitDataWithModel:(SYMoreFunModel *)model;
@end

@implementation SYMoreStatusHeaderCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _photosImageView = ({
            UIImageView *iv = [[UIImageView alloc]init];
            iv.contentMode = UIViewContentModeScaleAspectFill;
            iv.clipsToBounds =YES;
            [self.contentView addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.contentView);
                make.top.mas_equalTo(0.0f);
                make.size.mas_equalTo(CGSizeMake(40.0f, 40.0f));
            }];
            iv;
        });
        
        _titleLabel = ({
            UILabel *iv = [[UILabel alloc]init];
            iv.textColor =[UIColor blackColor];
            iv.numberOfLines = 1;
            iv.textAlignment = NSTextAlignmentCenter;
            iv.font = [UIFont systemFontOfSize:14.0f];
            [self.contentView addSubview:iv];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.photosImageView.mas_bottom);
                make.centerX.mas_equalTo(self.contentView);
                make.height.mas_equalTo(20.0f);
                make.left.right.mas_equalTo(self.contentView);
            }];
            iv;
        });
        _selectButton = ({
            UIButton *iv = [UIButton buttonWithType:UIButtonTypeCustom];
            [iv setImage:[UIImage imageNamed:@"app_item_plus"] forState:UIControlStateNormal];
            iv.adjustsImageWhenHighlighted =NO;
            iv.showsTouchWhenHighlighted =NO;
            [self.contentView addSubview:iv];
            [iv addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
            [iv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.photosImageView.mas_right);
                make.top.mas_equalTo(self.photosImageView.mas_top);
                make.size.mas_equalTo(CGSizeMake(20.0f, 20.0f));
            }];
            iv;
        });
    }
    return self;
}

-(void)InitDataWithModel:(SYMoreListModel *)model{
    _model = model;
    self.titleLabel.text = model.Title;
}

-(void)Click:(UIButton *)sender{
    if (self.decreaseBlock) {
        self.decreaseBlock(self, self.model);
    }
}

@end

@interface SYMoreStatusHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSMutableArray *lists;
@property(nonatomic,strong)NSMutableArray *cellAttributesArray;
@property(nonatomic,strong)SYMoreItemHeaderView *statusView;
@property(nonatomic,assign)BOOL isChange;
@end
@implementation SYMoreStatusHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _statusView = ({
            SYMoreItemHeaderView *iv = [[SYMoreItemHeaderView alloc]initWithFrame:CGRectZero];
            iv.backgroundColor = [UIColor whiteColor];
            [self addSubview:iv];
            iv;
        });
        
        _statusCollectionView = ({
            UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
            layout.minimumInteritemSpacing = 0.0f;
            layout.minimumLineSpacing = 0.f;
            layout.headerReferenceSize = CGSizeMake(0, 0);
            layout.scrollDirection = UICollectionViewScrollDirectionVertical;
            UICollectionView *iv =[[UICollectionView alloc] initWithFrame:CGRectZero
                                                     collectionViewLayout:layout];
            iv.backgroundColor = [UIColor whiteColor];
            iv.showsHorizontalScrollIndicator = NO;
            iv.showsVerticalScrollIndicator = NO;
            iv.scrollEnabled = NO;
            iv.dataSource = self;
            iv.delegate = self;
            iv.layer.shadowColor = NEW_PURPLE_COLOR.CGColor;
            iv.layer.shadowOffset = CGSizeMake(0,0);
            iv.layer.shadowOpacity = 0.8f;
            [self addSubview:iv];
            [iv registerClass:[SYMoreStatusHeaderCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SYMoreStatusHeaderCollectionViewCell class])];
            iv;
        });
        
        __weak __typeof(&*self)weakSelf = self;
        self.statusView.statusBlock = ^(SYMoreItemHeaderView *itemsView, BOOL isEdit) {
            __strong __typeof(&*weakSelf)strongSelf = weakSelf;
            if (strongSelf.StatusHeaderBlock) {
                strongSelf.StatusHeaderBlock(strongSelf,isEdit);
            }
        };
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0.0f);
        make.top.mas_equalTo(0.0f);
        make.height.mas_equalTo(44.0f);
    }];
    [self.statusCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0.0f);
        make.top.mas_equalTo(self.statusView.mas_bottom);
        make.bottom.mas_equalTo(0.0f);
    }];
}

-(void)initWithSouces:(NSArray *)souces{
    [self.lists removeAllObjects];
    if (souces.count) {
        [self.lists addObjectsFromArray:souces];
    }
    [self.statusCollectionView reloadData];
}


-(CGSize)intrinsicContentSize{
    CGSize contentSize = self.statusCollectionView.collectionViewLayout.collectionViewContentSize;
    return CGSizeMake(UIViewNoIntrinsicMetric, contentSize.height);
}

#pragma mark <UICollectionViewCellDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYMoreStatusHeaderCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SYMoreStatusHeaderCollectionViewCell class]) forIndexPath:indexPath];
    [cell InitDataWithModel:self.lists[indexPath.row]];
    __weak __typeof(&*self)weakSelf = self;
    cell.decreaseBlock = ^(SYMoreStatusHeaderCollectionViewCell *itemCell, SYMoreListModel *model) {
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        if (self.lists.count<=4) {
            NSLog(@"不小于4个");
            return ;
        }else{
            NSIndexPath *selectIndexPath = [collectionView indexPathForCell:itemCell];
            [strongSelf.lists removeObjectAtIndex:selectIndexPath.row];
            [collectionView deleteItemsAtIndexPaths:@[selectIndexPath]];
            if (self.delegate&&[self.delegate respondsToSelector:@selector(changeStatusItemWithHeaderView:withCollectionView:withSouce:withModel:)]) {
                [self.delegate changeStatusItemWithHeaderView:self withCollectionView:self.statusCollectionView withSouce:self.lists withModel:model];
            }
        }
    };
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [cell addGestureRecognizer:longPress];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
     return self.lists.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake(self.frame.size.width/4,60.0f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 0.0f, 10.0f, 0.0f); //分别为上、左、下、右 (区间距)
}

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    
    SYMoreStatusHeaderCollectionViewCell *cell = (SYMoreStatusHeaderCollectionViewCell *)longPress.view;
    NSIndexPath *cellIndexpath = [_statusCollectionView indexPathForCell:cell];
    [_statusCollectionView bringSubviewToFront:cell];
    _isChange = NO;
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan: {
            [self.cellAttributesArray removeAllObjects];
            for (int i = 0; i < self.lists.count; i++) {
                [self.cellAttributesArray addObject:[_statusCollectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]];
            }
        }
            break;
            
        case UIGestureRecognizerStateChanged: {
            cell.center = [longPress locationInView:_statusCollectionView];
            for (UICollectionViewLayoutAttributes *attributes in self.cellAttributesArray) {
                if (CGRectContainsPoint(attributes.frame, cell.center) && cellIndexpath != attributes.indexPath) {
                    _isChange = YES;
                    SYMoreListModel *model = self.lists[cellIndexpath.row];
                    [self.lists removeObjectAtIndex:cellIndexpath.row];
                    [self.lists insertObject:model atIndex:attributes.indexPath.row];
                    [_statusCollectionView moveItemAtIndexPath:cellIndexpath toIndexPath:attributes.indexPath];
                }
            }
        }
            break;
        case UIGestureRecognizerStateEnded: {
            if (!_isChange) {
                cell.center = [_statusCollectionView layoutAttributesForItemAtIndexPath:cellIndexpath].center;
            }
            NSLog(@"排序后的数据:==%@",self.lists);
            if (self.delegate&&[self.delegate respondsToSelector:@selector(changeStatusItemWithHeaderView:withCollectionView:withSouce:withModel:)]) {
                [self.delegate changeStatusItemWithHeaderView:self withCollectionView:self.statusCollectionView withSouce:self.lists withModel:nil];
            }
        }
            break;
        default:
            break;
    }
}

//[UIView animateWithDuration:0.5 animations:^{
//    grid.transform = CGAffineTransformMakeScale(1.1, 1.1);
//    grid.alpha = 1;
//    [grid setBackgroundImage:highlightedImage forState:UIControlStateNormal];
//}];

-(NSMutableArray *)lists{
    if (!_lists) {
        _lists = [NSMutableArray arrayWithCapacity:0];
    }
    return _lists;
}

- (NSMutableArray *)cellAttributesArray {
    if(!_cellAttributesArray) {
        _cellAttributesArray = [[NSMutableArray alloc] init];
    }
    return _cellAttributesArray;
}

@end
