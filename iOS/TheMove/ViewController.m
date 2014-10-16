//
//  ViewController.m
//  TheMove
//
//  Created by Michael Johnson on 10/15/14.
//  Copyright (c) 2014 kPi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

CLLocationManager *locationManager;
bool recording;


- (IBAction)getCurrentLocation:(id)sender {
    int ret = [CLLocationManager authorizationStatus];
    if (ret == 0) {
        NSLog(@"UNKNOWN");
        [locationManager requestAlwaysAuthorization];
    }
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if (!recording) {
        [locationManager startUpdatingLocation];
    } else {
        [locationManager stopUpdatingLocation];
    }
    recording = !recording;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (locationManager == nil) {
        locationManager = [[CLLocationManager alloc] init];
        recording = false;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}



- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        NSString * lon = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        NSString * lat = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        
        
        
        NSNumber *time = [NSNumber numberWithDouble: [currentLocation.timestamp timeIntervalSince1970]];

    
        NSString * post = [NSString stringWithFormat:@"time=%f&lon=%f&lat=%f",[time doubleValue], [lon doubleValue], [lat doubleValue]];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
        
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:3000/addData"]]];
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];
        NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:self];
        
        NSLog(post);
        
        

    }
}

@end
