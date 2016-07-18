//
//  SaasAppTests.m
//  SaasAppTests
//
//  Created by ToothBond on 15/10/27.
//  Copyright © 2015年 ToothBond. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TBBaseNetwork.h"

@interface SaasAppTests : XCTestCase<TBBaseNetworkProrocol>

@end

@implementation SaasAppTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    TBBaseNetwork *network = [TBBaseNetwork networkingWithUrlString:nil requestDictionary:@{@"jid":@"lisi@192.168.1.140"} delegate:self];

    network.urlString = @"http://192.168.1.140:9090/plugins/presence/status";
    [network startRequest];
}

-(void)requestSuccess:(TBResponse *)response
{
    DEBUG_NSLOG(@"%s--%@",__FUNCTION__,response);
}

-(void)requestFailed:(TBResponse *)response
{
    DEBUG_NSLOG(@"%s--%@",__FUNCTION__,response);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
