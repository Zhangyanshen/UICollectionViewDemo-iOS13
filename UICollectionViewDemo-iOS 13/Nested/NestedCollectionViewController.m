//
//  NestedCollectionViewController.m
//  UICollectionViewDemo-iOS 13
//
//  Created by 张延深 on 2019/11/10.
//  Copyright © 2019 张延深. All rights reserved.
//

#import "NestedCollectionViewController.h"
#import "MultiCellCollectionViewCell.h"

@interface NestedCollectionViewController ()

@end

@implementation NestedCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MultiCellCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MultiCellCollectionViewCell class])];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MultiCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MultiCellCollectionViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ld", indexPath.section, indexPath.item];
    return cell;
}

#pragma mark - Override

- (UICollectionViewLayout *)generateLayout {
    UICollectionViewCompositionalLayout *layout = [[UICollectionViewCompositionalLayout alloc] initWithSectionProvider:^NSCollectionLayoutSection * _Nullable(NSInteger section, id<NSCollectionLayoutEnvironment> _Nonnull layoutEnvironment) {
        // 1.item
        NSCollectionLayoutSize *itemSize = [self getItemSizeWithSection:section];
        NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
        item.contentInsets = NSDirectionalEdgeInsetsMake(8, 8, 8, 8);
        // 2.group
        NSCollectionLayoutSize *groupSize = [self getGroupSizeWithSection:section];
        NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:groupSize subitems:@[item]];
        // 3.section
        NSCollectionLayoutSection *layoutSection = [NSCollectionLayoutSection sectionWithGroup:group];
        layoutSection.orthogonalScrollingBehavior = section == 2 ? UICollectionLayoutSectionOrthogonalScrollingBehaviorNone : UICollectionLayoutSectionOrthogonalScrollingBehaviorGroupPaging;
        layoutSection.contentInsets = NSDirectionalEdgeInsetsMake(8, 8, 8, 8);
        
        return layoutSection;
    }];
    return layout;
}

#pragma mark - Private methods

- (NSCollectionLayoutSize *)getItemSizeWithSection:(NSInteger)section {
    NSCollectionLayoutSize *size = nil;
    switch (section) {
        case 0:
            size = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
            break;
        case 1:
            size = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension absoluteDimension:120.0] heightDimension:[NSCollectionLayoutDimension absoluteDimension:120]];
            break;
        case 2:
            size = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:0.5] heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
            break;
        default:
            break;
    }
    return size;
}

- (NSCollectionLayoutSize *)getGroupSizeWithSection:(NSInteger)section {
    NSCollectionLayoutSize *size = nil;
    switch (section) {
        case 0:
            size = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:0.9] heightDimension:[NSCollectionLayoutDimension absoluteDimension:100.0]];
            break;
        case 1:
            size = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension absoluteDimension:120.0] heightDimension:[NSCollectionLayoutDimension absoluteDimension:120.0]];
            break;
        case 2:
            size = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalWidthDimension:0.5]];
            break;
        default:
            break;
    }
    return size;
}

@end
