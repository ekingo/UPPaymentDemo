//
//  ViewController.m
//  Pay银联
//
//  Created by mc on 16/1/20.
//  Copyright © 2016年 kangshibiao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    NSURLRequest * urlRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://101.231.204.84:8091/sim/getacptn"]];
//    NSURLConnection* urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
//    [urlConn start];
        [self startNetWithURL:[NSURL URLWithString:@"http://101.231.204.84:8091/sim/getacptn"]];

}
- (void)startNetWithURL:(NSURL *)url
{
//    [_curField resignFirstResponder];
//    _curField = nil;
//    [self showAlertWait];
    
    NSURLRequest * urlRequest=[NSURLRequest requestWithURL:url];
    NSURLConnection* urlConn = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    [urlConn start];
}
#pragma mark - connection

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response
{
    NSHTTPURLResponse* rsp = (NSHTTPURLResponse*)response;
    NSInteger code = [rsp statusCode];
    if (code != 200)
    {
        
//        [self showAlertMessage:kErrorNet];
        [connection cancel];
    }
    else
    {
        
        _responseData = [[NSMutableData alloc] init];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//    [self hideAlert];
    NSString* tn = [[NSMutableString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    if (tn != nil && tn.length > 0)
    {
        
        NSLog(@"tn=%@",tn);
        [[UPPaymentControl defaultControl] startPay:tn fromScheme:@"UPPayDemo" mode:@"01" viewController:self];
        
    }
    
    
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
//    [self showAlertMessage:kErrorNet];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
