//
//  ViewController.m
//  XebiaTest
//
//  Created by Sandeep Kukreti on 4/4/13.
//  Copyright (c) 2013 Sandeep Kukreti. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize imageArray;

- (void)viewDidLoad
{
	// Do any additional setup after loading the view, typically from a nib.
    
    self.imageArray=[[NSMutableArray alloc] init];
    gridView.delegate=self;
    gridView.scrollEnabled=YES;
    gridView.userInteractionEnabled=YES;
    [super viewDidLoad];

    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    
}


-(IBAction)addImages:(id)sender
{
    
    UIImagePickerController *imagePicker = [[UIImagePickerController  alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePicker.delegate=self;
    imagePicker.allowsEditing = YES;
    [self presentModalViewController:imagePicker animated:YES];
    
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

-(void)imagePickerController: (UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Code here to work with media
    NSLog(@"Info : %@",info);
    
    //To get Image from Picker and added into image array for Grid View.
    
    UIImage *image =  [info objectForKey:UIImagePickerControllerOriginalImage];
    
    [self.imageArray addObject:image];
    
    [self dismissModalViewControllerAnimated:YES];
    
    [self drawGridView:self.imageArray];
}


-(void)imagePickerControllerDidCancel: (UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}

//Grid view logic


-(void)drawGridView:(NSMutableArray*)imageCollection
{
    int count=0;
    
    for(int kIndex=0;kIndex<[imageCollection count];kIndex++)
    {
        
        [[gridView viewWithTag:100+kIndex] removeFromSuperview];
    }
    
    for(int kIndex=0;kIndex<[imageCollection count];kIndex++)
    {
        
        for(int jIndex=0;jIndex<4 && count<[imageCollection count];jIndex++)
        {
            UIImageView *imageView=[[UIImageView alloc] initWithFrame:CGRectMake(80*jIndex,80*kIndex,80,80)];
            imageView.image=[imageCollection objectAtIndex:count];
            imageView.tag=100+count;
            imageView.userInteractionEnabled=YES;
            
            //Add Gesture to recognize dragging of dragged UIImageView.
            UIPanGestureRecognizer *panRecg = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(imageDragged:)];
            [imageView addGestureRecognizer:panRecg];
            
            [gridView addSubview:imageView];
            count++;

        }
    }
    
    
}


-(void)imageDragged:(UIPanGestureRecognizer *)recognizer {
   
    UIImageView *imageView = (UIImageView *)recognizer.view;
    [gridView bringSubviewToFront:imageView];
   
    CGPoint newCenter = [recognizer translationInView:self.view];
    
    if([recognizer state] == UIGestureRecognizerStateBegan) {
        beginX = imageView.center.x;
        beginY = imageView.center.y;
    }
    
    newCenter = CGPointMake(beginX + newCenter.x, beginY + newCenter.y);
    
    [imageView setCenter:newCenter];
    
    if([recognizer state] == UIGestureRecognizerStateEnded) {
        
        
        NSInteger tag=[self getTagNumber:newCenter];
        
        if(tag>=0)
        {
        
            [imageArray removeObjectAtIndex:imageView.tag-100];

            [imageArray insertObject:imageView.image atIndex:tag];
        
        }
        
        [self drawGridView:self.imageArray];

        NSLog(@"Tag Number : %d",tag);
        
    }
    
}

-(NSInteger)getTagNumber:(CGPoint)newCenter
{
    int x=newCenter.x;
    int y=newCenter.y;
    int tag=0;
    
    //Logic to calculate the Tag number for destination Image location.
    tag=(x/80)+(y/80)*4;
    
    if(tag>[self.imageArray count]-1)
        return -1;
    return tag;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
