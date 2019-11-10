//
//  HeaderFooterViewController.m
//  UICollectionViewDemo-iOS 13
//
//  Created by 张延深 on 2019/11/10.
//  Copyright © 2019 张延深. All rights reserved.
//

#import "HeaderFooterViewController.h"
#import "HeaderFooterCollectionReusableView.h"
#import "MultiCellCollectionViewCell.h"

@interface HeaderFooterViewController ()

@end

@implementation HeaderFooterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HeaderFooterCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:@"header" withReuseIdentifier:NSStringFromClass([HeaderFooterCollectionReusableView class])];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HeaderFooterCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:@"footer" withReuseIdentifier:NSStringFromClass([HeaderFooterCollectionReusableView class])];
    [self.collectionView registerNib:[UINib nibWithNibName:@"MultiCellCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MultiCellCollectionViewCell class])];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10 * section + 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MultiCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MultiCellCollectionViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.item];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    HeaderFooterCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass([HeaderFooterCollectionReusableView class]) forIndexPath:indexPath];
    if ([kind isEqualToString:@"header"]) {
        header.textLabel.text = [NSString stringWithFormat:@"第%ld个header", indexPath.section];
        header.backgroundColor = [UIColor purpleColor];
    } else {
        header.textLabel.text = [NSString stringWithFormat:@"第%ld个footer", indexPath.section];
        header.backgroundColor = [UIColor linkColor];
    }
    return header;
}

#pragma mark - Override

- (UICollectionViewLayout *)generateLayout {
    // 1.header
    NSCollectionLayoutSize *headerSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension absoluteDimension:44]];
    NSCollectionLayoutBoundarySupplementaryItem *header = [NSCollectionLayoutBoundarySupplementaryItem boundarySupplementaryItemWithLayoutSize:headerSize elementKind:@"header" alignment:NSRectAlignmentTop];
    header.pinToVisibleBounds = YES;
    // 2.footer
    NSCollectionLayoutSize *footerSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension absoluteDimension:44]];
    NSCollectionLayoutBoundarySupplementaryItem *footer = [NSCollectionLayoutBoundarySupplementaryItem boundarySupplementaryItemWithLayoutSize:footerSize elementKind:@"footer" alignment:NSRectAlignmentBottom];
    // 3.item
    NSCollectionLayoutSize *itemSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalHeightDimension:1.0]];
    NSCollectionLayoutItem *item = [NSCollectionLayoutItem itemWithLayoutSize:itemSize];
    item.contentInsets = NSDirectionalEdgeInsetsMake(8, 8, 8, 8);
    // 4.group
    NSCollectionLayoutSize *groupSize = [NSCollectionLayoutSize sizeWithWidthDimension:[NSCollectionLayoutDimension fractionalWidthDimension:1.0] heightDimension:[NSCollectionLayoutDimension fractionalWidthDimension:0.2]];
    NSCollectionLayoutGroup *group = [NSCollectionLayoutGroup horizontalGroupWithLayoutSize:groupSize subitem:item count:5];
    // 5.section
    NSCollectionLayoutSection *section = [NSCollectionLayoutSection sectionWithGroup:group];
    section.boundarySupplementaryItems = @[header, footer];
    
    return [[UICollectionViewCompositionalLayout alloc] initWithSection:section];
}

@end
