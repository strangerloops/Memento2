//
//  MementoViewController.h
//  Memento
//
//  Created by   on 2/14/14.
//  Copyright (c) 2014 strangerware. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MementoViewController : UIViewController <UIImagePickerControllerDelegate>


@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UIButton *mapButton;
@property (nonatomic, assign) CLLocationCoordinate2D location;
@property (strong, nonatomic) IBOutlet UIButton *indecisionButton;
@property (nonatomic, assign) BOOL hasImage;

- (IBAction)getMeThere:(id)sender;
- (IBAction)choosePicture:(id)sender;

@end
