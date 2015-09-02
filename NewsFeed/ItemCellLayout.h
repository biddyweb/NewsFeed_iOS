//
//  ItemCellLayout.h
//  NewsFeed
//
//  Created by AlexKern on 27.07.15.
//  Copyright (c) 2015 Kaasa Solution. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCellLayout : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView  *itemThumbnail;
@property (strong, nonatomic) IBOutlet UILabel      *itemDate;
@property (strong, nonatomic) IBOutlet UILabel      *itemSource;
@property (strong, nonatomic) IBOutlet UILabel      *itemTitle;
@property (strong, nonatomic) IBOutlet UIButton     *tapArea;

@end
