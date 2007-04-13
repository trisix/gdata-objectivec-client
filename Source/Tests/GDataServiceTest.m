/* Copyright (c) 2007 Google Inc.
*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
*     http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

//
//  GDataServiceTest.m
//

#import "GDataServiceTest.h"

#define typeof __typeof__ // fixes http://www.brethorsting.com/blog/2006/02/stupid_issue_with_ocunit.html

@implementation GDataServiceTest

static int kServerPortNumber = 54579;

- (void)setUp {
  
  // run the python http server, located in the Tests directory
  NSString *currentDir = [[NSFileManager defaultManager] currentDirectoryPath];
  NSString *serverPath = [currentDir stringByAppendingPathComponent:@"Tests/GDataTestHTTPServer.py"];
  
  NSArray *argArray = [NSArray arrayWithObjects:serverPath, 
    @"-p", [NSString stringWithFormat:@"%d", kServerPortNumber], 
    @"-r", [serverPath stringByDeletingLastPathComponent], nil];
  
  server_ = [[NSTask alloc] init];
  [server_ setArguments:argArray];
  [server_ setLaunchPath:@"/usr/bin/python"];
  
  // pipe will be cleaned up when server_ is torn down.
  NSPipe *pipe = [NSPipe pipe];
  [server_ setStandardOutput:pipe];
  [server_ setStandardError:pipe];
  [server_ launch];
  
  // our server sends out a string to confirm that it launched
  NSData *launchMessageData = [[pipe fileHandleForReading] availableData];
  NSString *launchStr = [[[NSString alloc] initWithData:launchMessageData
                                               encoding:NSUTF8StringEncoding] autorelease];
  
  NSString *expectedLaunchStr = @"started GDataTestServer.py...";
  STAssertEqualObjects(launchStr, expectedLaunchStr,
                     @"Python http test server not launched\nServer path:%@\n", 
                     serverPath);
  
  // create the GData service object, and set it to authenticate
  // from our own python http server
  service_ = [[GDataServiceGoogleSpreadsheet alloc] init];
   
  NSString *authDomain = [NSString stringWithFormat:@"localhost:%d", kServerPortNumber];  
  [service_ setSignInDomain:authDomain];
}

- (void)resetFetchResponse {
  [fetchedObject_ release];
  fetchedObject_ = nil;
  
  [fetcherError_ release];
  fetcherError_ = nil;
  
  [ticket_ release];
  ticket_ = nil;
}

- (void)tearDown {
  
  [server_ terminate];
  [server_ waitUntilExit];
  [server_ release];
  server_ = nil;
  
  [service_ release];
  service_ = nil;
  
  [self resetFetchResponse];
}

- (NSURL *)fileURLToTestFileName:(NSString *)name {
  
  // we need to create http URLs referring to the desired
  // resource for the python http server running locally
  
  // return a localhost:port URL for the test file
  NSString *urlString = [NSString stringWithFormat:@"http://localhost:%d/%@",
    kServerPortNumber, name];
  
  NSURL *url = [NSURL URLWithString:urlString];
  
  // just for sanity, let's make sure we see the file locally, so
  // we can expect the Python http server to find it too
  NSString *filePath = [NSString stringWithFormat:@"Tests/%@", name];
  
  // we exclude the ".auth" extension that would indicate that the URL
  // should be tested with authentication
  if ([[filePath pathExtension] isEqual:@"auth"]) {
    filePath = [filePath stringByDeletingPathExtension]; 
  }
  
  BOOL doesExist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
  STAssertTrue(doesExist, @"Missing test file %@", filePath);
  
  return url;  
}


// deleteResource calls don't return data or an error, so we'll use
// a global int for the callbacks to increment to say they're done
// (because NSURLConnection is performing the fetches, all this 
// will be safely executed on the same thread)
static int gFetchCounter = 0; 

- (void)waitForFetch {
  
  int fetchCounter = gFetchCounter;
  
  // Give time for the fetch to happen, but give up if 
  // 10 seconds elapse with no response
  NSDate* giveUpDate = [NSDate dateWithTimeIntervalSinceNow:10.0];
  
  while ((!fetchedObject_ && !fetcherError_) 
         && fetchCounter == gFetchCounter
         && [giveUpDate timeIntervalSinceNow] > 0) {
    
    NSDate *stopDate = [NSDate dateWithTimeIntervalSinceNow:0.001];
    [[NSRunLoop currentRunLoop] runUntilDate:stopDate]; 
  }  
  
}

- (void)testFetch {
  
  NSDate *defaultUserData = [NSDate date]; 
  NSString *customUserData = @"my special ticket user data";
  
  [service_ setServiceUserData:defaultUserData];
  
  // an ".auth" extension tells the server to require the success auth token,
  // but the server will ignore the .auth extension when looking for the file
  NSURL *feedURL = [self fileURLToTestFileName:@"FeedSpreadsheetTest1.xml"];
  NSURL *authFeedURL = [self fileURLToTestFileName:@"FeedSpreadsheetTest1.xml.auth"];
  
  //
  // test:  download feed only, no auth
  //
  ticket_ = (GDataServiceTicket *)
    [service_ fetchFeedWithURL:feedURL
                     feedClass:kGDataUseRegisteredClass
                      delegate:self
             didFinishSelector:@selector(ticket:finishedWithObject:)
               didFailSelector:@selector(ticket:failedWithError:)];
  [ticket_ retain];
  
  [self waitForFetch];
  
  // we'll call into the GDataObject to get its ID to confirm it's good
  NSString *sheetID = @"http://spreadsheets.google.com/feeds/spreadsheets/private/full";
  
  STAssertEqualObjects([(GDataFeedSpreadsheet *)fetchedObject_ identifier],
                       sheetID, @"fetching %@", feedURL);
  STAssertNil(fetcherError_, @"fetcherError_=%@", fetcherError_);
  STAssertEqualObjects([ticket_ userData], defaultUserData, @"userdata error");
  
  
  //
  // test:  download feed only, successful auth, with custom ticket userdata
  //
  [self resetFetchResponse];

  // any username & password are considered valid unless the password 
  // begins with the string "bad"
  [service_ setUserCredentialsWithUsername:@"myaccount@mydomain.com"
                                  password:@"mypassword"];
  
  ticket_ = [service_ fetchAuthenticatedFeedWithURL:authFeedURL
                                          feedClass:kGDataUseRegisteredClass
                                           delegate:self
                                  didFinishSelector:@selector(ticket:finishedWithObject:)
                                    didFailSelector:@selector(ticket:failedWithError:)];
  [ticket_ retain];
  
  [ticket_ setUserData:customUserData];
  
  [self waitForFetch];

  STAssertEqualObjects([(GDataFeedSpreadsheet *)fetchedObject_ identifier],
                       sheetID, @"fetching %@", authFeedURL);
  STAssertNil(fetcherError_, @"fetcherError_=%@", fetcherError_);
  STAssertEqualObjects([ticket_ userData], customUserData, @"userdata error");

  //
  // test:  download feed only, unsuccessful auth
  //
  [self resetFetchResponse];
  
  [service_ setUserCredentialsWithUsername:@"myaccount@mydomain.com"
                                  password:@"bad"];
  
  ticket_ = [service_ fetchAuthenticatedFeedWithURL:authFeedURL
                                          feedClass:kGDataUseRegisteredClass
                                           delegate:self
                                  didFinishSelector:@selector(ticket:finishedWithObject:)
                                    didFailSelector:@selector(ticket:failedWithError:)];
  [ticket_ retain];
  
  [self waitForFetch];
  
  STAssertNil(fetchedObject_, @"fetchedObject_=%@", fetchedObject_);
  STAssertEquals([fetcherError_ code], 403, @"fetcherError_=%@", fetcherError_);
  STAssertEqualObjects([ticket_ userData], defaultUserData, @"userdata error");
  
  
  //
  // test:  download feed only, unsuccessful auth - captcha required
  //
  [self resetFetchResponse];
  
  [service_ setUserCredentialsWithUsername:@"myaccount@mydomain.com"
                                  password:@"captcha"];
  
  ticket_ = [service_ fetchAuthenticatedFeedWithURL:authFeedURL
                                          feedClass:kGDataUseRegisteredClass
                                           delegate:self
                                  didFinishSelector:@selector(ticket:finishedWithObject:)
                                    didFailSelector:@selector(ticket:failedWithError:)];
  [ticket_ retain];
  
  [self waitForFetch];
  
  STAssertNil(fetchedObject_, @"fetchedObject_=%@", fetchedObject_);
  STAssertEquals([fetcherError_ code], 403, @"fetcherError_=%@", fetcherError_);
  
  // get back the captcha token and partial and full URLs from the error
  NSDictionary *userInfo = [fetcherError_ userInfo];
  NSString *captchaToken = [userInfo objectForKey:@"CaptchaToken"];
  NSString *captchaUrl = [userInfo objectForKey:@"CaptchaUrl"];
  NSString *captchaFullUrl = [userInfo objectForKey:@"CaptchaFullUrl"];
  STAssertEqualObjects(captchaToken, @"CapToken", @"bad captcha token");
  STAssertEqualObjects(captchaUrl, @"CapUrl", @"bad captcha relative url");
  STAssertTrue([captchaFullUrl hasSuffix:@"/accounts/CapUrl"], @"bad captcha full:%@", captchaFullUrl);

  STAssertEqualObjects([ticket_ userData], defaultUserData, @"userdata error");
  
  //
  // test:  download feed only, good captcha provided
  //
  [self resetFetchResponse];
  
  [service_ setUserCredentialsWithUsername:@"myaccount2@mydomain.com"
                                  password:@"captcha"];
  [service_ setCaptchaToken:@"CapToken" captchaAnswer:@"good"];
  
  ticket_ = [service_ fetchAuthenticatedFeedWithURL:authFeedURL
                                          feedClass:kGDataUseRegisteredClass
                                           delegate:self
                                  didFinishSelector:@selector(ticket:finishedWithObject:)
                                    didFailSelector:@selector(ticket:failedWithError:)];
  [ticket_ retain];
  
  [self waitForFetch];
    
  // get back the captcha token and partial and full URLs from the error
  STAssertEqualObjects([(GDataFeedSpreadsheet *)fetchedObject_ identifier],
                       sheetID, @"fetching %@", feedURL);
  STAssertNil(fetcherError_, @"fetcherError_=%@", fetcherError_);
  STAssertEqualObjects([ticket_ userData], defaultUserData, @"userdata error");
  
  //
  // test:  download feed only, bad captcha provided
  //
  [self resetFetchResponse];
  
  [service_ setUserCredentialsWithUsername:@"myaccount3@mydomain.com"
                                  password:@"captcha"];
  [service_ setCaptchaToken:@"CapToken" captchaAnswer:@"bad"];

  ticket_ = [service_ fetchAuthenticatedFeedWithURL:authFeedURL
                                          feedClass:kGDataUseRegisteredClass
                                           delegate:self
                                  didFinishSelector:@selector(ticket:finishedWithObject:)
                                    didFailSelector:@selector(ticket:failedWithError:)];
  [ticket_ retain];
  
  [self waitForFetch];
  
  STAssertNil(fetchedObject_, @"fetchedObject_=%@", fetchedObject_);
  STAssertEquals([fetcherError_ code], 403, @"fetcherError_=%@", fetcherError_);
  
  // get back the captcha token and partial and full URLs from the error
  userInfo = [fetcherError_ userInfo];
  captchaToken = [userInfo objectForKey:@"CaptchaToken"];
  captchaUrl = [userInfo objectForKey:@"CaptchaUrl"];
  captchaFullUrl = [userInfo objectForKey:@"CaptchaFullUrl"];
  STAssertEqualObjects(captchaToken, @"CapToken", @"bad captcha token");
  STAssertEqualObjects(captchaUrl, @"CapUrl", @"bad captcha relative url");
  STAssertTrue([captchaFullUrl hasSuffix:@"/accounts/CapUrl"], @"bad captcha full:%@", captchaFullUrl);
  
  STAssertEqualObjects([ticket_ userData], defaultUserData, @"userdata error");
  
  
  //
  // test:  insert/download entry, successful auth
  //
  [self resetFetchResponse];

  [service_ setUserCredentialsWithUsername:@"myaccount@mydomain.com"
                                  password:@"good"];

  NSURL *authEntryURL = [self fileURLToTestFileName:@"EntrySpreadsheetCellTest1.xml.auth"];

  ticket_ = [service_ fetchAuthenticatedEntryByInsertingEntry:[GDataEntrySpreadsheetCell entry]
                                                   forFeedURL:authEntryURL
                                                     delegate:self
                                            didFinishSelector:@selector(ticket:finishedWithObject:)
                                              didFailSelector:@selector(ticket:failedWithError:)];
  [ticket_ retain];
  
  [self waitForFetch];
  
  NSString *entryID = @"http://spreadsheets.google.com/feeds/cells/o04181601172097104111.497668944883620000/od6/private/full/R1C1";
  
  STAssertEqualObjects([(GDataEntrySpreadsheetCell *)fetchedObject_ identifier],
                       entryID, @"updating %@", authEntryURL);
  STAssertNil(fetcherError_, @"fetcherError_=%@", fetcherError_);
  STAssertEqualObjects([ticket_ userData], defaultUserData, @"userdata error");
  
  //
  // test:  update/download entry, successful auth
  //
  [self resetFetchResponse];
  
  ticket_ = [service_ fetchAuthenticatedEntryByUpdatingEntry:[GDataEntrySpreadsheetCell entry]
                                                 forEntryURL:authEntryURL
                                                    delegate:self
                                           didFinishSelector:@selector(ticket:finishedWithObject:)
                                             didFailSelector:@selector(ticket:failedWithError:)];
  [ticket_ retain];
  
  [self waitForFetch];
  
  STAssertEqualObjects([(GDataEntrySpreadsheetCell *)fetchedObject_ identifier],
                       entryID, @"fetching %@", authFeedURL);
  STAssertNil(fetcherError_, @"fetcherError_=%@", fetcherError_);
  STAssertEqualObjects([ticket_ userData], defaultUserData, @"userdata error");
  
  //
  // test:  delete resource, successful auth
  //
  [self resetFetchResponse];
  
  ticket_ = [service_ deleteAuthenticatedResourceURL:authEntryURL
                                            delegate:self
                                   didFinishSelector:@selector(ticket:finishedWithObject:)
                                     didFailSelector:@selector(ticket:failedWithError:)];
  [ticket_ retain];
  
  [self waitForFetch];
  
  STAssertNil(fetchedObject_, @"deleting %@ returned \n%@", authEntryURL, fetchedObject_);
  STAssertNil(fetcherError_, @"fetcherError_=%@", fetcherError_);
  STAssertEqualObjects([ticket_ userData], defaultUserData, @"userdata error");

  //
  // test:  delete resource, successful auth, using method override header
  //
  [self resetFetchResponse];
  
  [service_ setShouldUseMethodOverrideHeader:YES];
  
  ticket_ = [service_ deleteAuthenticatedResourceURL:authEntryURL
                                            delegate:self
                                   didFinishSelector:@selector(ticket:finishedWithObject:)
                                     didFailSelector:@selector(ticket:failedWithError:)];
  [ticket_ retain];
  
  [self waitForFetch];
  
  STAssertNil(fetchedObject_, @"deleting %@ returned \n%@", authEntryURL, fetchedObject_);
  STAssertNil(fetcherError_, @"fetcherError_=%@", fetcherError_);
  STAssertEqualObjects([ticket_ userData], defaultUserData, @"userdata error");
}

// fetch callbacks

- (void)ticket:(GDataServiceTicket *)ticket finishedWithObject:(GDataObject *)object {

  STAssertEquals(ticket, ticket_, @"Got unexpected ticket");
  
  fetchedObject_ = [object retain]; // save the fetched object
  
  ++gFetchCounter;
}

- (void)ticket:(GDataServiceTicket *)ticket failedWithError:(NSError *)error {

  STAssertEquals(ticket, ticket_, @"Got unexpected ticket");
  
  fetcherError_ = [error retain]; // save the error
  
  ++gFetchCounter;
}

@end
