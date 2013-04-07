//
//  ViewController.h
//  XebiaTest
//
//  Created by Sandeep Kukreti on 4/4/13.
//  Copyright (c) 2013 Sandeep Kukreti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate,UIGestureRecognizerDelegate  >
{
    
    IBOutlet UIScrollView *gridView;
    
    NSMutableArray *imageArray;
    int beginX;
    int beginY;

}

@property(nonatomic,strong) NSMutableArray *imageArray;

-(IBAction)addImages:(id)sender;



@end
