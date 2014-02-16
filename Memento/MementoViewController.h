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

@property (nonatomic, assign) CLLocationCoordinate2D location;
@property (nonatomic, assign) BOOL hasImage;
@property (strong, nonatomic) UILabel *locationLabel;
@property (strong, nonatomic) UIBarButtonItem *mapButton;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIToolbar *toolbar;

- (void)getMeThere;
- (void)choosePicture;

@end
