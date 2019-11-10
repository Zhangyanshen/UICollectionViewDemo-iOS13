//
//  DecorateViewController.m
//  UICollectionViewDemo-iOS 13
//
//  Created by 张延深 on 2019/11/10.
//  Copyright © 2019 张延深. All rights reserved.
//

#import "DecorateViewController.h"
#import "SimpleListCollectionViewCell.h"
#import "DecorateCollectionReusableView.h"

@interface DecorateViewController ()

@end

@implementation DecorateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 8, 0);
    [self.collectionView registerNib:[UINib nibWithNibName:@"SimpleListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([SimpleListCollectionViewCell class])];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10 * section + 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SimpleListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SimpleListCollectionViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ld", indexPath.section, indexPath.item];
    cell.contentView.backgroundColor = indexPath.item % 2 == 0 ? [UIColor systemRedColor] : [UIColor systemGreenColor];
    return cell;
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
    section.contentInsets = NSDirectionalEdgeInsetsMake(16, 16, 16, 16);
    // 3.1.decoration view
    NSCollectionLayoutDecorationItem *decorationItem = [NSCollectionLayoutDecorationItem backgroundDecorationItemWithElementKind:@"background"];
    decorationItem.contentInsets = NSDirectionalEdgeInsetsMake(8, 8, 0, 8);
    section.decorationItems = @[decorationItem];
    // 4.layout
    UICollectionViewCompositionalLayout *layout = [[UICollectionViewCompositionalLayout alloc] initWithSection:section];
    [layout registerNib:[UINib nibWithNibName:@"DecorateCollectionReusableView" bundle:nil] forDecorationViewOfKind:@"background"];
    return layout;
}

@end
