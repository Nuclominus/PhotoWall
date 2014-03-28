//
//  CellVC.h
//  PhotoWall
//
//  Created by AlterEgo on 27.03.14.
//  Copyright (c) 2014 Black. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellVC : UIViewController{
    
    
}

@property (nonatomic,strong) IBOutlet UIImageView * image;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView * indicator;
@property (nonatomic,strong) NSMutableArray * adjacentPoints;

-(NSMutableArray*)cellAdjacentPoints;

@end
