//
//  NestedViewController.m
//  UICollectionViewDemo-iOS 13
//
//  Created by 张延深 on 2019/11/10.
//  Copyright © 2019 张延深. All rights reserved.
//

#import "NestedGroupViewController.h"
#import "MultiCellCollectionViewCell.h"

@interface NestedGroupViewController ()

@end

@implementation NestedGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MultiCellCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MultiCellCollectionViewCell class])];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 23;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MultiCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MultiCellCollectionViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.item];
    cell.contentView.backgroundColor = indexPath.item % 2 == 0 ? [UIColor systemRedColor] : [UIColor systemGreenColor];
    return cell;
}

#pragma mark - Override

- (UICollectionViewLayout *)generateLayout {
    // 1.trailing Item
    NSCollectionLayoutSize *trailingItemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
    NSCollectionLayoutItem *trailingItem = [NSCollectionLayoutItem itemWithLayoutSize:trailingItemSize];
//    trailingItem.contentInsets = NSDirectionalEdgeInsetsMake(0, 0, 8, 0);
    // 2.trailing Group
    NSCollectionLayoutSize *trailingGroupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:0.5] heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
    NSCollectionLayoutGroup *trailingGroup = [NSCollectionLayoutGroup verticalGroupWithLayoutSize:trailingGroupSize subitem:trailingItem count:2];
    trailingGroup.contentInsets = NSDirectionalEdgeInsetsMake(0, 8, 0, 0);
    // 3.leading Item
    NSCollectionLayoutSize *leadingItemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:0.5] heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
    NSCollectionLayoutItem *leadingItem = [NSCollectionLayoutItem itemWithLayoutSize:leadingItemSize];
    // 4.container group
    NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension absoluteDimension:200.0]];
    NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:groupSize subitems:@[leadingItem, trailingGroup]];
    group.contentInsets = NSDirectionalEdgeInsetsMake(8, 8, 8, 8);
    // 5.section
    NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:group];
    // 5.layout
    UICollectionViewCompositionalLayout *layout = [[UICollectionViewCompositionalLayout alloc] initWithSection:section];
    return layout;
}

@end
