//
//  ViewController.m
//  MoreItems
//
//  Created by FaceBook on 2019/1/18.
//  Copyright © 2019年 FaceBook. All rights reserved.
//

#import "ViewController.h"
#import "SYMoreFunctionCollectionViewCell.h"
#import "SYMoreHeaderCollectionReusableView.h"
#import "SYMoreStatusHeaderView.h"
#import "SYMoreStatusView.h"
#import "SYMoreFunModel.h"
@interface ViewController ()
<
UICollectionViewDelegate,
UICollectionViewDataSource,
SYChangeItemsHeaderViewDelegate,
SYMoreFunctionCollectionViewCellActionDelegate
>
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UICollectionView *itemsCollectionView;
@property(nonatomic,strong)NSMutableArray *lists;
@property(nonatomic,strong)NSMutableArray *items;
@property(nonatomic,strong)SYMoreStatusHeaderView *headerView;
@property(nonatomic,strong)SYMoreStatusView *statusView;
@property(nonatomic,assign)BOOL isEdit;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self configView];
    [self refreshLoadDataSoucre];
}

-(void)configView{
    _searchBar = ({
        UISearchBar *iv = [[UISearchBar alloc]initWithFrame:CGRectZero];
        [self.view addSubview:iv];
        iv.barTintColor = GRAY_BACK_GROUND_COLOR;
        iv.layer.borderWidth = 1;
        iv.layer.borderColor =  GRAY_BACK_GROUND_COLOR.CGColor;
        [iv setBackgroundColor:[UIColor clearColor]];
        iv.placeholder = @"搜索全部功能";
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0.0f);
            make.top.mas_equalTo(0.0f);
            make.height.mas_equalTo(50.0f);
        }];
        iv;
    });
    
    _headerView = ({
        SYMoreStatusHeaderView *iv = [[SYMoreStatusHeaderView alloc]initWithFrame:CGRectZero];
        iv.hidden = YES;
        iv.delegate = self;
        [self.view addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0.0f);
            make.top.mas_equalTo(self.searchBar.mas_bottom);
            make.height.mas_equalTo(0.0f);
        }];
        iv;
    });
    
    _itemsCollectionView = ({
        UICollectionViewFlowLayout *layout =[[UICollectionViewFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 0.0f;
        layout.minimumLineSpacing = 0.f;
        layout.footerReferenceSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, 10.0f);
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        UICollectionView *iv =[[UICollectionView alloc] initWithFrame:CGRectZero
                                                 collectionViewLayout:layout];
        iv.backgroundColor = [UIColor whiteColor];
        iv.showsHorizontalScrollIndicator = NO;
        iv.showsVerticalScrollIndicator = NO;
        iv.dataSource = self;
        iv.delegate = self;
        iv.contentInset = UIEdgeInsetsMake(54.0f, 0, 0, 0);
        iv.alwaysBounceVertical = YES;
        [self.view addSubview:iv];
        [iv registerClass:[SYMoreFunctionCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([SYMoreFunctionCollectionViewCell class])];
        [iv registerClass:[SYMoreHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([SYMoreHeaderCollectionReusableView class])];
        [iv registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class])];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            if (iOS11) {
                make.left.right.mas_equalTo(0.0f);
                make.top.mas_equalTo(self.headerView.mas_bottom);
                make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            }else{
                make.left.right.mas_equalTo(0.0f);
                make.top.mas_equalTo(self.headerView.mas_bottom);
                make.bottom.mas_equalTo(0.0f);
            }
        }];
        iv;
    });
    
    _statusView = ({
        SYMoreStatusView *iv = [[SYMoreStatusView alloc]initWithFrame:CGRectMake(0.0f,-54.0f ,  [UIScreen mainScreen].bounds.size.width, 54.0f)];
        [self.itemsCollectionView addSubview:iv];
        iv.backgroundColor = GRAY_BACK_GROUND_COLOR;
        iv;
    });
    
    __weak __typeof(&*self)weakSelf = self;
    [self.statusView setStatusBlock:^(SYMoreStatusView * _Nonnull itemsView, BOOL isEdit) {
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        strongSelf.isEdit = isEdit;
        [UIView animateWithDuration:0.35 animations:^{
            itemsView.hidden = YES;
            strongSelf.headerView.hidden = NO;
            strongSelf.statusView.frame = CGRectMake(0.0f,0.0f ,  [UIScreen mainScreen].bounds.size.width, 0.0f);
            strongSelf.itemsCollectionView.contentInset = UIEdgeInsetsMake(0.0f, 0, 0, 0);
            [strongSelf.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(strongSelf.headerView.intrinsicContentSize.height+44.0f);
            }];
        } completion:^(BOOL finished) {
            [strongSelf.headerView initWithSouces:strongSelf.items];
            [strongSelf refreshLoadItems:YES];
            [strongSelf.view layoutIfNeeded];
        }];
    }];
    
    
    [self.headerView setStatusHeaderBlock:^(SYMoreStatusHeaderView *headerView, BOOL isEdit) {
        __strong __typeof(&*weakSelf)strongSelf = weakSelf;
        strongSelf.isEdit = isEdit;
        [UIView animateWithDuration:0.35 animations:^{
            headerView.hidden = YES;
            strongSelf.statusView.hidden = NO;
            strongSelf.statusView.frame = CGRectMake(0.0f, -54.0f, [UIScreen mainScreen].bounds.size.width, 54.0f);
            strongSelf.itemsCollectionView.contentInset =UIEdgeInsetsMake(54.0f, 0, 0, 0);
            [strongSelf.itemsCollectionView setContentOffset:CGPointMake(0,-54.0f) animated:NO];
            [strongSelf.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(0.0f);
            }];
        } completion:^(BOOL finished) {
            [strongSelf.statusView initWithSouces:strongSelf.items];
            [strongSelf refreshLoadItems:NO];
            [strongSelf.view layoutIfNeeded];
        }];
    }];
}


-(void)refreshLoadDataSoucre{
    NSString *pathBundle = [[NSBundle mainBundle]pathForResource:@"items" ofType:@"json"];
    NSString *bundleString  = [NSString stringWithContentsOfFile:pathBundle encoding:NSUTF8StringEncoding error:nil];
    NSDictionary *jason = [self dictionaryWithJsonString:bundleString];
    self.lists = [SYMoreFunContentModel mj_objectArrayWithKeyValuesArray:jason[@"Contents"]];
    self.items =  [SYMoreListModel mj_objectArrayWithKeyValuesArray:[self loadItems]];
    [self.statusView initWithSouces:self.items];
    [self.headerView initWithSouces:self.items];
    [self refreshLoadItems:NO];
}

-(void)refreshLoadItems:(BOOL)isEdit{
    if (isEdit) {
        for (SYMoreFunContentModel *sectionModel in self.lists) {
            for (SYMoreListModel *model in sectionModel.List) {
                model.IsSelected = YES;
                for (SYMoreListModel *seviceModel in self.items) {
                    if ([model.Title isEqualToString:seviceModel.Title]||[model.Title isEqualToString:@"其他"]||[model.Title isEqualToString:@"更多"]) {
                        model.IsSelected = NO;
                    }
                }
            }
        }
    }else{
        for (SYMoreFunContentModel *sectionModel in self.lists) {
            for (SYMoreListModel *model in sectionModel.List) {
                model.IsSelected = NO;
            }
        }
    }
    [self.itemsCollectionView reloadData];
}


- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {return nil;}
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    if(err){return nil;}
    return dic;
}

#pragma mark <UICollectionViewCellDelegate>
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SYMoreFunctionCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SYMoreFunctionCollectionViewCell class]) forIndexPath:indexPath];
    SYMoreFunContentModel *model = self.lists[indexPath.section];
    [cell InitDataWithModel:model.List[indexPath.row]];
    cell.delegate = self;
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    return self.lists.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    SYMoreFunContentModel *model = self.lists[section];
    return model.List.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return  CGSizeMake([UIScreen mainScreen].bounds.size.width/4,60.0f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 0.0f, 10, 0.0f);//分别为上、左、下、右 (区间距)
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didSelectItem");
}

#pragma mark UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return (CGSize){[UIScreen mainScreen].bounds.size.width,44.0f};
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusable = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        SYMoreHeaderCollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([SYMoreHeaderCollectionReusableView class]) forIndexPath:indexPath];
        [reusableView InitDataWithModel:self.lists[indexPath.section]];
        reusable = reusableView;
    }
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass([UICollectionReusableView class]) forIndexPath:indexPath];
        reusableView.backgroundColor = GRAY_BACK_GROUND_COLOR;
        reusable = reusableView;
    }
    return reusable;
}

-(void)changeStatusItemWithHeaderView:(SYMoreStatusHeaderView *)headerView withCollectionView:(UICollectionView *)collectionView withSouce:(NSArray *)souces withModel:(SYMoreFunModel *)model{
    [self.items removeAllObjects];
    [self.items addObjectsFromArray:souces];
    [self.headerView initWithSouces:self.items];
    [self refreshLoadItems:YES];
    [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.headerView.intrinsicContentSize.height+44.0f);
    }];
    [self.itemsCollectionView reloadData];
}

-(void)addSevicesItemWithCell:(SYMoreFunctionCollectionViewCell *)cell withModel:(SYMoreFunModel *)model{
    if (self.items.count>=9) {
        NSLog(@"最多添加9个应用");
        return ;
    }else{
        model.IsSelected = NO;
        [self.items addObject:model];
        [self.headerView initWithSouces:self.items];
        [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.headerView.intrinsicContentSize.height+44.0f);
        }];
        [self.itemsCollectionView reloadData];
    }
}


-(NSArray *)loadItems{
    NSArray *items = @[@{@"ClientsType":@"0",
                         @"Created":@"0",
                         @"Id":@"0",
                         @"ImageUrl":@"",
                         @"IsLogin":@"",
                         @"Title":@"理财",
                         @"Type":@"",
                         @"Updated":@"",
                         @"Url":@""
                         },
                       @{@"ClientsType":@"0",
                         @"Created":@"0",
                         @"Id":@"0",
                         @"ImageUrl":@"",
                         @"IsLogin":@"",
                         @"Title":@"缴费",
                         @"Type":@"",
                         @"Updated":@"",
                         @"Url":@""
                         },
                       @{@"ClientsType":@"0",
                         @"Created":@"0",
                         @"Id":@"0",
                         @"ImageUrl":@"",
                         @"IsLogin":@"",
                         @"Title":@"手机充值",
                         @"Type":@"",
                         @"Updated":@"",
                         @"Url":@""
                         },@{@"ClientsType":@"0",
                             @"Created":@"0",
                             @"Id":@"0",
                             @"ImageUrl":@"",
                             @"IsLogin":@"",
                             @"Title":@"贷款",
                             @"Type":@"",
                             @"Updated":@"",
                             @"Url":@""
                             },@{@"ClientsType":@"0",
                                 @"Created":@"0",
                                 @"Id":@"0",
                                 @"ImageUrl":@"",
                                 @"IsLogin":@"",
                                 @"Title":@"还信用卡",
                                 @"Type":@"",
                                 @"Updated":@"",
                                 @"Url":@""
                                 },@{@"ClientsType":@"0",
                                     @"Created":@"0",
                                     @"Id":@"0",
                                     @"ImageUrl":@"",
                                     @"IsLogin":@"",
                                     @"Title":@"结售汇",
                                     @"Type":@"",
                                     @"Updated":@"",
                                     @"Url":@""
                                     },@{@"ClientsType":@"0",
                                         @"Created":@"0",
                                         @"Id":@"0",
                                         @"ImageUrl":@"",
                                         @"IsLogin":@"",
                                         @"Title":@"付款码",
                                         @"Type":@"",
                                         @"Updated":@"",
                                         @"Url":@""
                                         }];
    return items;
}

@end
