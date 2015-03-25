//
//  MasterViewController.h
//  ExpandableTextView
//
//  Created by Developer on 20/03/15.
//  Copyright (c) 2015 Arpit Awasthi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface MasterViewController : UIViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;


@end

