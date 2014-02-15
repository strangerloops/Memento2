//
//  MementoViewController.m
//  Memento
//
//  Created by   on 2/14/14.
//  Copyright (c) 2014 strangerware. All rights reserved.
//

#import "MementoViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface MementoViewController ()

@end

@implementation MementoViewController

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    ALAssetsLibrary *al = [ALAssetsLibrary new];
    [al assetForURL:info[UIImagePickerControllerReferenceURL] resultBlock:^(ALAsset *asset) {
        //
        UIImageOrientation orientation = UIImageOrientationUp;
        NSNumber *orientationValue = [asset valueForProperty:@"ALAssetPropertyOrientation"];
        if (orientationValue != nil) {
            orientation = [orientationValue intValue];
        }
        CGFloat scale = 1.0;
        UIImage *image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage] scale:scale orientation:orientation];
        CLLocation *location = [asset valueForProperty:ALAssetPropertyLocation];
        CLLocationCoordinate2D mLocation = [location coordinate];
        [self setLocation:mLocation];
        [_imageView setImage:image];
        [self setHasImage:true];
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:_location.latitude longitude:_location.longitude] completionHandler:^(NSArray *placemarks, NSError *error)
        {
            if ([[placemarks firstObject] locality] && [[placemarks firstObject] administrativeArea])
            {
            [_locationLabel setText:[NSString stringWithFormat:@"%@, %@", [[placemarks firstObject] locality], [[placemarks firstObject] administrativeArea]]];
                [_mapButton setEnabled:true];
            }
            else
            {
                [_locationLabel setText:@"Location unavailable"];
                [_mapButton setEnabled:false];
            }
        }];

        [self dismissViewControllerAnimated:YES completion:nil];
    } failureBlock:nil];
    return;
}

- (void)getMeThere:(id)sender
{
    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)]) {
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:[self location] addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [mapItem setName:@"My Place"];
        NSDictionary *launchOptions = @{MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving};
        MKMapItem *currentLocationMapItem = [MKMapItem mapItemForCurrentLocation];
        [MKMapItem openMapsWithItems:@[currentLocationMapItem, mapItem]
                       launchOptions:launchOptions];
    }
}

- (void)choosePicture:(id)sender
{
    if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeSavedPhotosAlbum])
    {
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        [imagePicker setDelegate:self];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        imagePicker.mediaTypes = @[(NSString *) kUTTypeImage];
        imagePicker.allowsEditing = NO;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!_hasImage)
    {
        [_indecisionButton setTitle:@"Choose a picture" forState:UIControlStateNormal];
        [_locationLabel setHidden:YES];
        [_mapButton setHidden:YES];
    }
    else
    {
        [_indecisionButton setTitle:@"Different picture" forState:UIControlStateNormal];
        [_locationLabel setHidden:NO];
        [_mapButton setHidden:NO];
    }
}

@end
