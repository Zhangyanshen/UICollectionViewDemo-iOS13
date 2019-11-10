//
//  SimpleListViewController.m
//  UICollectionViewDemo-iOS 13
//
//  Created by 张延深 on 2019/11/9.
//  Copyright © 2019 张延深. All rights reserved.
//

#import "SimpleListViewController.h"
#import "SimpleListCollectionViewCell.h"

@interface SimpleListViewController ()

@end

@implementation SimpleListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SimpleListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
}

#pragma mark - Override

- (UICollectionViewLayout *)generateLayout {
    // 1.item
    NSCollectionLayoutSize *itemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
    NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
    // 2.group
    NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension absoluteDimension:44]];
    NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:groupSize subitem:item count:1];
    // 3.section
    NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:group];
    
    return [[UICollectionViewCompositionalLayout alloc] initWithSection:section];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SimpleListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.item];
    cell.contentView.backgroundColor = indexPath.item % 2 == 0 ? [UIColor systemRedColor] : [UIColor systemGreenColor];
    return cell;
}

@end
