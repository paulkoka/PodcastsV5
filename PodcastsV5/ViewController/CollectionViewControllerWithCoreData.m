//
//  CollectionViewControllerWithCoreData.m
//  Podcasts
//
//  Created by Pavel Koka on 7/30/18.
//  Copyright © 2018 Pavel Koka. All rights reserved.
//

#import "CollectionViewControllerWithCoreData.h"
#import "NSString+stringFromDate.h"
#import "CollectionVewCell.h"
#import "DetailViewController.h"
#import "KPILocalImagePreview+SetImage.h"

@interface CollectionViewControllerWithCoreData ()   <UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) DetailViewController* detail;

@end

@implementation CollectionViewControllerWithCoreData

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = UIColor.whiteColor;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.collectionView.allowsSelection = YES;
    self.title = @"All podcasts";
    
    self.navigationController.navigationBar.backgroundColor = UIColor.whiteColor;
    self.navigationController.navigationBar.barTintColor = UIColor.whiteColor;

    [self.collectionView registerClass:[CollectionVewCell class] forCellWithReuseIdentifier:reuseIdentifier];
     self.detail = [[DetailViewController alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.collectionView.collectionViewLayout invalidateLayout];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return [[self.fetchedResultsController sections] count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CollectionVewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell setDataToLabelsFrom:[self.fetchedResultsController objectAtIndexPath:indexPath]];
    return cell;
    
}



- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.collectionView cellForItemAtIndexPath:indexPath].backgroundColor = UIColor.whiteColor;
  
    [self.detail itemWasSelected:[self.fetchedResultsController objectAtIndexPath:indexPath]];
    [self.splitViewController showDetailViewController:self.detail sender:self];
    
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
}


- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    return YES;
}

-(NSFetchRequest*)newRequest{
    NSFetchRequest *fetchRequest = KPIItem.fetchRequest;
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"KPIItem" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]
                              initWithKey:@"publicationDate" ascending:NO];
    
    [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    [fetchRequest setFetchBatchSize:20];
    
    return fetchRequest;
    
}

#pragma mark NSFetchedResultsController

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchedResultsController *theFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:[self newRequest]
                                        managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil
                                                   cacheName:nil];
    
   
    theFetchedResultsController.delegate = self;
    
    
     self.fetchedResultsController = theFetchedResultsController;
    
    NSError *error = nil;
    if (![theFetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
    
    _fetchedResultsController = theFetchedResultsController;
    return _fetchedResultsController;
    
}



- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
            break;
        case NSFetchedResultsChangeMove:
            return;
        case NSFetchedResultsChangeUpdate:
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
            break;
        default:
            return;
    }
    
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UICollectionView *collectionView = self.collectionView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
           
            [collectionView reloadData];
            break;
            
        case NSFetchedResultsChangeDelete:
            
            [collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:indexPath]];
            break;
            
        case NSFetchedResultsChangeUpdate:
            
            [collectionView cellForItemAtIndexPath:indexPath];

            break;
            
        case NSFetchedResultsChangeMove:
            [collectionView deleteItemsAtIndexPaths:[NSArray
                                                     arrayWithObject:indexPath]];
            [collectionView insertItemsAtIndexPaths:[NSArray
                                                     arrayWithObject:newIndexPath]];
            break;
    }
    
    
}



- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {

    [self.collectionView reloadData];
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return  CGSizeMake(CGRectGetWidth(collectionView.bounds), 100);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 15;
}
@end
