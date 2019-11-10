//
//  DistinctSectionsViewController.m
//  UICollectionViewDemo-iOS 13
//
//  Created by 张延深 on 2019/11/9.
//  Copyright © 2019 张延深. All rights reserved.
//

#import "DistinctSectionsViewController.h"
#import "SimpleListCollectionViewCell.h"
#import "MultiCellCollectionViewCell.h"

@interface DistinctSectionsViewController ()

@end

@implementation DistinctSectionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"SimpleListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SimpleListCollectionViewCell class])];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MultiCellCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MultiCellCollectionViewCell class])];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger count = 0;
    switch (section) {
        case 0:
            count = 10;
            break;
        case 1:
            count = 21;
            break;
        case 2:
            count = 15;
            break;
        default:
            break;
    }
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SimpleListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SimpleListCollectionViewCell class]) forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ld", indexPath.section, indexPath.item];
        cell.contentView.backgroundColor = indexPath.item % 2 == 0 ? [UIColor systemRedColor] : [UIColor systemGreenColor];
        return cell;
    }
    MultiCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MultiCellCollectionViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ld", indexPath.section, indexPath.item];
    return cell;
}

#pragma mark - Override

- (UICollectionViewLayout *)generateLayout {
    return [[UICollectionViewCompositionalLayout alloc] initWithSectionProvider:^NSCollectionLayoutSection * _Nullable(NSInteger section, id<NSCollectionLayoutEnvironment> _Nonnull layoutEnvironment) {
        CGFloat width = layoutEnvironment.container.effectiveContentSize.width;
        NSInteger columnCount = [self columnCountWithSection:section width:width];
        // 1.item
        NSCollectionLayoutSize *itemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
        NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
        item.contentInsets = section != 0 ? NSDirectionalEdgeInsetsMake(8, 8, 8, 8) : NSDirectionalEdgeInsetsMake(0, 8, 0, 8);
        // 2.group
        NSCollectionLayoutDimension *groupHeight = section == 0 ? [NSCollectionLayoutDimension absoluteDimension:44] : [NSCollectionLayoutDimension fractionalWidthDimension:1.0 / columnCount];
        NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:groupHeight];
        NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:groupSize subitem:item count:columnCount];
        // 3.section
        return [NSCollectionLayoutSection sectionWithGroup:group];
    }];
}

#pragma mark - Private methods

- (NSInteger)columnCountWithSection:(NSInteger)section width:(CGFloat)width {
    NSInteger count = 1;
    BOOL wideMode = width > 800;
    switch (section) {
        case 0:
            count = wideMode ? 2 : 1;
            break;
        case 1:
            count = wideMode ? 10 : 5;
            break;
        case 2:
            count = wideMode ? 6 : 3;
            break;
        default:
            break;
    }
    return count;
}

@end
