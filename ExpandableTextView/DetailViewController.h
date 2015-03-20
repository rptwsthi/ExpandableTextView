//
//  DetailViewController.h
//  ExpandableTextView
//
//  Created by Developer on 20/03/15.
//  Copyright (c) 2015 Technologies33. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

