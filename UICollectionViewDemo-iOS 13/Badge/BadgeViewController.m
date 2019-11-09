//
//  BadgeViewController.m
//  UICollectionViewDemo-iOS 13
//
//  Created by 张延深 on 2019/11/9.
//  Copyright © 2019 张延深. All rights reserved.
//

#import "BadgeViewController.h"
#import "MultiCellCollectionViewCell.h"
#import "BadgeCollectionReusableView.h"

@interface BadgeViewController ()

@end

@implementation BadgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MultiCellCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MultiCellCollectionViewCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:@"BadgeCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:@"badge" withReuseIdentifier:NSStringFromClass([BadgeCollectionReusableView class])];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 23;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MultiCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MultiCellCollectionViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.item];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    BadgeCollectionReusableView *badgeView = [collectionView dequeueReusableSupplementaryViewOfKind:@"badge" withReuseIdentifier:NSStringFromClass([BadgeCollectionReusableView class]) forIndexPath:indexPath];
    return badgeView;
}

#pragma mark - Override

- (UICollectionViewLayout *)generateLayout {
    // 1.badge
    NSCollectionLayoutAnchor *badgeAnchor = [NSCollectionLayoutAnchor layoutAnchorWithEdges:NSDirectionalRectEdgeTop | NSDirectionalRectEdgeTrailing fractionalOffset:CGPointMake(0.3, -0.3)];
    NSCollectionLayoutSize *badgeSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension absoluteDimension:20] heightDimension:[NSCollectionLayoutDimension absoluteDimension:20]];
    NSCollectionLayoutSupplementaryItem *badge = [NSCollectionLayoutSupplementaryItem supplementaryItemWithLayoutSize:badgeSize elementKind:@"badge" containerAnchor:badgeAnchor];
    // 2.item
    NSCollectionLayoutSize *itemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
    NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize supplementaryItems:@[badge]];
    item.contentInsets = NSDirectionalEdgeInsetsMake(8, 8, 8, 8);
    // 3.group
    NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalWidthDimension:0.2]];
    NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:groupSize subitem:item count:5];
    // 4.section
    NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:group];
    
    return [[UICollectionViewCompositionalLayout alloc] initWithSection:section];
}

@end
