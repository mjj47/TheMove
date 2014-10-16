//
//  ViewController.h
//  TheMove
//
//  Created by Michael Johnson on 10/15/14.
//  Copyright (c) 2014 kPi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ViewController : UIViewController <CLLocationManagerDelegate>

- (IBAction)getCurrentLocation:(id)sender;


@end

