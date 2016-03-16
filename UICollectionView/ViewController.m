//
//  ViewController.m
//  UICollectionView
//
//  Created by Alex on 16/3/15.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionCell.h"
#import "MJRefreshAutoNormalFooter.h"

#define COLLECTION_CELL_COUNT 4
#define COLLECTION_DATA_COUNT 20
#define COLLECTION_CELL_HEIGHT 80.0

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
{
    CGRect targetRect;
}

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _dataArray = [NSMutableArray array];
    self.collectionView.alwaysBounceVertical = YES;
    for (NSInteger i = 0; i<12; i++) {
        [_dataArray addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    
    /*
    __unsafe_unretained __typeof(self) weakSelf = self;
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
    
        [self loadMoreData];
        // 结束刷新
        [weakSelf.collectionView.mj_footer endRefreshing];
        
       [self drawCollectionLine];

    }];
    self.collectionView.mj_footer.hidden = YES;
     */
    
    [self drawCollectionLine];
}

- (void)loadMoreData
{
    NSLog(@"加载更多");
    // 增加5条假数据
    for (NSInteger i = 0; i<20; i++) {
        [_dataArray addObject:[NSString stringWithFormat:@"%ld",i]];
    }
    
    [_collectionView reloadData];
    [self drawCollectionLine];
    

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"customCollectionCell";
    CustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.nameLbl.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
   
    CGFloat collectionViewContentSizeHeight = _collectionView.contentSize.height;
    CGFloat collectionViewContentOffSetY = _collectionView.contentOffset.y;
    CGFloat collectionViewHeight = _collectionView.frame.size.height;
    
    CGFloat offset = collectionViewContentSizeHeight - collectionViewContentOffSetY - collectionViewHeight;
    
    if(offset  == 200  || offset == 0 || offset < 0)
    {
         NSLog(@"偏移量:%.f",offset);
    }

    if ( offset == 200 || offset == 0 || offset < 0) {
        [self loadMoreData];
    }
}


/**
 *  画分割线
 *
 *  @param indexPath indexPath
 *  @param cell      cell
 */
- (void)drawCollectionLine
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        CGSize contentSize = self.collectionView.contentSize;
        for (NSInteger i = 0; i < COLLECTION_CELL_COUNT; i++) {
            UIView *verticalLine = [[UIView alloc]initWithFrame:CGRectMake(contentSize.width/COLLECTION_CELL_COUNT*i, 0, 1, contentSize.height)];
            verticalLine.backgroundColor = [UIColor lightGrayColor];
            [self.collectionView addSubview:verticalLine];
        }
        
        for (NSInteger i = 0; i< (NSInteger)([_dataArray count]/4 + 1); i++) {
            UIView *horizontalLine = [[UIView alloc]initWithFrame:CGRectMake(0, COLLECTION_CELL_HEIGHT * i , contentSize.width, 1)];
            horizontalLine.backgroundColor = [UIColor lightGrayColor];
            [self.collectionView addSubview:horizontalLine];
        }
    });
}

 // 设定指定Cell的尺寸
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(self.view.frame.size.width/COLLECTION_CELL_COUNT,COLLECTION_CELL_HEIGHT);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.row);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
