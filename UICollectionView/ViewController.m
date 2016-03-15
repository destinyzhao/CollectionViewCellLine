//
//  ViewController.m
//  UICollectionView
//
//  Created by Alex on 16/3/15.
//  Copyright © 2016年 Alex. All rights reserved.
//

#import "ViewController.h"
#import "CustomCollectionCell.h"

#define COLLECTION_CELL_COUNT 4
#define COLLECTION_CELL_HEIGHT 80.0

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"customCollectionCell";
    CustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.nameLbl.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    [self drawCollectionLineWith:indexPath cell:cell];
    return cell;
}

/**
 *  画分割线
 *
 *  @param indexPath indexPath
 *  @param cell      cell
 */
- (void)drawCollectionLineWith:(NSIndexPath *)indexPath cell:(CustomCollectionCell *)cell
{
    CGSize contentSize = self.collectionView.contentSize;
    for (NSInteger i = 0; i < COLLECTION_CELL_COUNT; i++) {
        UIView *verticalLine = [[UIView alloc]initWithFrame:CGRectMake(contentSize.width/COLLECTION_CELL_COUNT*i, 0, 1, contentSize.height)];
        verticalLine.backgroundColor = [UIColor lightGrayColor];
        [self.collectionView addSubview:verticalLine];
    }
    
    UIView *horizontalLine = [[UIView alloc]initWithFrame:CGRectMake(0, (cell.frame.size.height) * indexPath.row , contentSize.width, 1)];
    horizontalLine.backgroundColor = [UIColor lightGrayColor];
    [self.collectionView addSubview:horizontalLine];

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
