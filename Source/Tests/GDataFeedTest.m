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
//  GDataFeedTest.m
//

#import "GData.h"

#import "GDataFeedTest.h"
#import "GDataEntryCalendarEvent.h"
#import "GDataElementsTest.h"

@implementation GDataFeedTest

- (void)runTests:(TestKeyPathValues *)tests {
  
  // step through each feed test
  for (int testIndex = 0;
       tests[testIndex].str1 != nil;
       testIndex++) {
    
    // get the class of this feed and the path to the test file of xml data 
    NSString *className = tests[testIndex].str1;
    Class gdataClass = NSClassFromString(className);
    STAssertNotNil(gdataClass, @"Cannot make class for class name: %@", className);
    
    NSString *feedPath = tests[testIndex].str2;
    NSData *data = [NSData dataWithContentsOfFile:feedPath];
    STAssertNotNil(data, @"Cannot read feed from %@", feedPath);
    
    // create the feed object
    NSError *error = nil;
    NSXMLDocument *doc = [[[NSXMLDocument alloc] initWithData:data
                                                      options:0
                                                        error:&error] autorelease];
    STAssertNotNil(doc, @"Cannot allocate XML document, error %@", error);
    
    GDataFeedBase *feed1 = [[[gdataClass alloc] initWithData:data] autorelease];
    
    // copy the feed object 
    GDataObject *feed1copy = [[feed1 copy] autorelease];
    STAssertTrue([feed1 isEqual:feed1copy], @"Failed copy feed from %@ to %@",
                 feed1, feed1copy);
    
    // make a new feed object we'll test against from XML generated by the copy
    NSXMLElement *outputXML = [feed1copy XMLElement];
        
    GDataFeedBase *feed2 = [[[gdataClass alloc] initWithXMLElement:outputXML
                                                            parent:nil] autorelease];

    STAssertTrue([feed2 isEqual:feed1copy], @"Failed using XML \n  %@\n\nto convert\n  %@ \nto\n  %@",  
                outputXML, feed1copy, feed2);
    
    // step through all the key-value path tests
    while (1) {
      
      ++testIndex;
      
      NSString *keyPath = tests[testIndex].str1;
      NSString *expectedValue = tests[testIndex].str2;
      
      if (keyPath == nil || [keyPath length] == 0) break;
      
      NSString *result = [GDataElementsTest valueInObject:feed2
                                forKeyPathIncludingArrays:keyPath];
      
      // we'll test for equality unless the expected result begins "hasPrefix:"
      // or "contains:"
      if ([expectedValue hasPrefix:@"hasPrefix:"]) {
        NSString *prefix = [expectedValue substringFromIndex:[@"hasPrefix:" length]];
        STAssertTrue([result hasPrefix:prefix], @"failed object %@ \n testing key path '%@' for prefix:\n %@ \n!= prefix:\n %@", 
                     feed2, keyPath, result, prefix);  
        
      } else if ([expectedValue hasPrefix:@"contains:"]) {
        
        NSString *substring = [expectedValue substringFromIndex:[@"contains:" length]];
        NSRange range = [result rangeOfString:substring];
        STAssertTrue(range.location != NSNotFound, @"failed object %@ \n testing key path '%@' for substring:\n %@ \n!= contains:\n %@", 
                     feed2, keyPath, result, substring);      
      } else {
        STAssertTrue(AreEqualOrBothNil(result, expectedValue), @"failed object %@ \n testing key path '%@'\n %@ \n!= \n %@", 
                     feed2, keyPath, result, expectedValue);      
      }
    }
  }  
}


- (void)testCalendarFeed {
  
  TestKeyPathValues tests[] =
  { 
    //
    // Calendar Feed
    //
    { @"GDataFeedCalendar", @"Tests/FeedCalendarTest1.xml" },
      
    // GDataFeedCalendar paths 
    { @"title.stringValue", @"Fred Flintstone's Calendar List" },
    { @"links.1.rel", kGDataLinkRelPost },
    { @"links.2.rel", @"self" },
    { @"authors.0.name", @"Fred Flintstone" },
    { @"authors.0.email", @"fred@gmail.com" },
    { @"generator.URI", @"http://www.google.com/calendar" },
    { @"generator.name", @"Google Calendar" },
    { @"generator.version", @"1.0" },
    { @"startIndex.stringValue", @"1" },
    { @"itemsPerPage.stringValue", @"3" },
      
    { @"unknownAttributes.@count.stringValue", @"0" },
    { @"unknownChildren.@count.stringValue", @"0" },
      
    // GDataEntryCalendar paths
    { @"entries.0.identifier", @"http://www.google.com/calendar/feeds/test%40coldnose.net/test%40coldnose.net" },
    { @"entries.0.publishedDate.RFC3339String", @"2006-11-14T00:03:38Z" },
    { @"entries.0.updatedDate.RFC3339String", @"2006-11-09T00:16:10Z" },
    { @"entries.0.editedDate.RFC3339String", @"2006-11-09T00:16:15Z" },
    { @"entries.0.title.stringValue", @"Fred Flintstone" },
    { @"entries.0.links.0.rel", @"alternate" },
    { @"entries.0.links.1.href", @"http://www.google.com/calendar/feeds/test%40coldnose.net/test%40coldnose.net" },
    { @"entries.0.authors.0.name", @"Fred Flintstone" },
    { @"entries.0.authors.0.email", @"fred@gmail.com" },
    { @"entries.0.isHidden.stringValue", @"0" },
    { @"entries.0.timeZoneName.stringValue", @"America/Los_Angeles" },
    { @"entries.0.color.stringValue", @"#B1365F" },
    { @"entries.0.accessLevel.stringValue", kGDataCalendarAccessOwner},
    { @"entries.0.overrideName.stringValue", @"over-ride-name" },
    { @"entries.1.locations.0.stringValue", @"Joes Pub" },
    { @"entries.2.isSelected.stringValue", @"0" },
    { @"entries.2.isHidden.stringValue", @"1" },
    
    { @"entries.0.unknownAttributes.@count.stringValue", @"0" },
    { @"entries.0.unknownChildren.@count.stringValue", @"0" },

    { @"", @"" }, // end of feed
    
    
    //
    // CalendarEntries Feed
    //
    { @"GDataFeedCalendarEvent", @"Tests/FeedCalendarEventTest1.xml" },
    
    // GDataFeedCalendarEvent paths
    { @"title.stringValue", @"Fred Flintstone" },
    { @"subtitle.stringValue", @"Fred Flintstone" },
    { @"links.0.rel", kGDataLinkRelFeed },
    { @"links.2.rel", @"self" },
    { @"authors.0.name", @"Fred Flintstone" },
    { @"authors.0.email", @"fred@gmail.com" },
    { @"identifier", @"http://www.google.com/calendar/feeds/test%40gmail.com/private/full" },
    { @"namespaces.gCal", kGDataNamespaceGCal },
    
    { @"generator.URI", @"http://www.google.com/calendar" },
    { @"generator.name", @"Google Calendar" },
    { @"generator.version", @"1.0" },
    { @"startIndex.stringValue", @"1" },
    { @"itemsPerPage.stringValue", @"100000" },
    { @"timeZoneName.stringValue", @"America/Los_Angeles" },
    
    { @"unknownAttributes.@count.stringValue", @"0" },
    { @"unknownChildren.@count.stringValue", @"0" },
    
    // GDataEntryCalendarEvent paths
    { @"entries.0.identifier", @"contains:i12d4avieju0vogcga72aj3908" },
    
    { @"entries.0.publishedDate.RFC3339String", @"2006-10-27T22:48:14Z" },
    { @"entries.0.updatedDate.RFC3339String", @"2006-11-03T21:17:40Z" },
    { @"entries.0.title.stringValue", @"3 days" },
    { @"entries.0.content.stringValue", @"The description field" },

    { @"entries.0.links.0.title", @"alternate" },
    { @"entries.0.links.1.rel", @"self" },
    { @"entries.0.authors.0.name", @"Fred Flintstone" },
    { @"entries.0.authors.0.email", @"fred@gmail.com" },
    { @"entries.0.visibility.stringValue", kGDataEventVisibilityDefault },
    { @"entries.0.comment.feedLink.href", @"contains:i12d4avieju0vogcga72aj3908/comments" },
    { @"entries.0.shouldSendEventNotifications.stringValue", @"0" },
    { @"entries.0.isQuickAdd.stringValue", @"0" },
    { @"entries.0.transparency.stringValue", kGDataEventTransparencyOpaque },
    { @"entries.0.eventStatus.stringValue", kGDataEventStatusConfirmed },
    { @"entries.0.participants.0.email", @"FredFlintstone@gmail.com" },
    { @"entries.0.participants.0.rel", kGDataWhoEventAttendee },
    { @"entries.0.participants.0.attendeeStatus.stringValue", kGDataWhoAttendeeStatusDeclined },
    { @"entries.0.participants.1.email", @"FredFlintstone@google.com" },
    { @"entries.0.participants.2.email", @"freg@gmail.com" },
    { @"entries.0.times.0.endTime.RFC3339String", @"2006-11-16" },
    { @"entries.0.times.0.reminders.0.minutes", @"10" },
    { @"entries.0.locations.0.stringValue", @"The-where-field" },
    { @"entries.0.locations.0.rel", nil },
    { @"entries.0.sequenceNumber.stringValue", @"2" },
    { @"entries.0.iCalUID", @"4A24A0FF-EA3A-4839-AA09-F4283CB6D345" },
    { @"entries.1.recurrence.stringValue", @"hasPrefix:DTSTART;VALUE=DATE:20061120" },
    { @"entries.1.reminders.0.minutes", @"10" },
    { @"entries.1.isDeleted.stringValue", @"0" },
    { @"entries.3.locations.0.stringValue", @"Seattle" },
    { @"entries.3.isDeleted.stringValue", @"1" },
        
    { @"entries.0.unknownAttributes.@count.stringValue", @"0" },
    { @"entries.0.unknownChildren.@count.stringValue", @"0" },
    
    { @"", @"" }, // end of feed

    { nil, nil } // end of test array
  };
  
  [self runTests:tests];
}

- (void)testGoogleBaseFeed {
  
  TestKeyPathValues tests[] =
  { 
    //
    // Google Base snippet feed
    //
    { @"GDataFeedGoogleBase", @"Tests/FeedGoogleBaseSnippetTest1.xml" },
      
    // feed paths 
    { @"generator.URI", @"http://base.google.com" },
    { @"generator.name", @"GoogleBase" },
    { @"title.stringValue", @"Items matching query: digital camera" },
    { @"links.0.href", @"http://base.google.com" },
      
    { @"unknownAttributes.@count.stringValue", @"0" },
    { @"unknownChildren.@count.stringValue", @"0" },
      
    // entry paths
    // There are three entries; we'll test against the first one
    { @"entries.0.identifier", @"http://www.google.com/base/feeds/snippets/13246453826751927533" },
    { @"entries.0.publishedDate.RFC3339String", @"2007-01-31T02:36:40Z" },
    { @"entries.0.categories.0.scheme", kGDataCategoryGoogleBaseItemTypesScheme },
    { @"entries.0.categories.0.term", @"products" },
    
    { @"entries.0.itemType", @"Products" },
    { @"entries.0.expirationDate.RFC3339String", @"2007-03-02T02:36:40Z" },
    { @"entries.0.imageLink", @"hasPrefix:http://base.google.com/base_image?q=http%3A%2F%2Fwww.bhphotovideo.com%2Fimages%2Fitems%2F305668.jpg" },
    { @"entries.0.imageLinks.@count.stringValue", @"1" },
    { @"entries.0.price", @"34.95 usd" },
    { @"entries.0.location", @"420 9th Ave. 10001" },
    { @"entries.0.paymentNotes", @"PayPal & Bill Me Later credit available online only." },
    { @"entries.0.customerID.stringValue", @"1172711" },
    
    // feed batch item
    { @"batchOperation.type", @"update" },
    
    // entry batch items
    { @"entries.0.batchID.stringValue", @"BatchID 1" },
    { @"entries.0.batchOperation.type", @"insert" },
    { @"entries.0.batchStatus.code.stringValue", @"201" },
    { @"entries.0.batchStatus.reason", @"Created" },
    { @"entries.2.batchInterrupted.reason", @"interruption reason" },
    { @"entries.2.batchInterrupted.successCount.stringValue", @"10" },
    { @"entries.2.batchInterrupted.errorCount.stringValue", @"5" },
    { @"entries.2.batchInterrupted.totalCount.stringValue", @"15" },

    // feed atom pub control item
    { @"atomPubControl.isDraft.stringValue", @"1" },

    // entry atom pub control items
    { @"entries.0.atomPubControl.isDraft.stringValue", @"1" },
    { @"entries.1.atomPubControl.isDraft.stringValue", @"0" },
    { @"entries.2.atomPubControl.isDraft.stringValue", nil },

    // do some tests of arbitrary attributes through -attributeDictionary
    { @"entries.0.attributeDictionary.manufacturer_id.0.textValue", @"DCB5092" },
    { @"entries.0.attributeDictionary.target_country.0.textValue", @"US" },
    { @"entries.0.attributeDictionary.weight.0.textValue", @"1.0" },
    { @"entries.0.attributeDictionary.condition.0.textValue", @"new" },
    { @"entries.0.attributeDictionary.condition.0.subAttributes.@count.stringValue", @"1" },
    { @"entries.0.attributeDictionary.condition.0.subAttributes.0.name", @"greg rating" },
    { @"entries.0.attributeDictionary.condition.0.subAttributes.0.textValue", @"89" },

    { @"entries.0.unknownAttributes.@count.stringValue", @"0" },
    { @"entries.0.unknownChildren.@count.stringValue", @"0" },
      
    { @"", @"" }, // end of feed
      
    //
    // Google Base item type feed
    //
    { @"GDataFeedGoogleBase", @"Tests/FeedGoogleBaseItemTypesTest1.xml" },
      
      // GDataFeedContact paths 
    { @"generator.URI", @"http://base.google.com" },
    { @"generator.name", @"GoogleBase" },
    { @"title.stringValue", @"Item types for locale en_US" },
    { @"links.0.href", @"http://base.google.com" },
      
    { @"unknownAttributes.@count.stringValue", @"0" },
    { @"unknownChildren.@count.stringValue", @"0" },
      
    // GDataEntryGoogleBase paths
    // There are two entries; we'll test against the first one
    { @"entries.0.identifier", @"http://www.google.com/base/feeds/itemtypes/en_US/products" },
    { @"entries.0.categories.0.scheme", kGDataCategoryGoogleBaseItemTypesScheme },
    { @"entries.0.categories.0.term", @"products" },
    { @"entries.0.title.stringValue", @"products" },
    { @"entries.0.content.stringValue", @"products" },
      
    { @"entries.0.metadataItemType", @"products" },
    { @"entries.0.metadataAttributeList.attributes.@count.stringValue", @"67" },
    { @"entries.0.metadataAttributeList.attributes.1.name", @"condition" },
    { @"entries.0.metadataAttributeList.attributes.1.type", @"text" },

    { @"entries.0.unknownAttributes.@count.stringValue", @"0" },
    { @"entries.0.unknownChildren.@count.stringValue", @"0" },
      
    { @"", @"" }, // end of feed
    
    //
    // Google Base item count feed
    //
    { @"GDataFeedGoogleBase", @"Tests/FeedGoogleBaseItemCountsTest1.xml" },
      
    // GDataFeedContact paths 
    { @"generator.URI", @"http://base.google.com" },
    { @"generator.name", @"GoogleBase" },
    { @"title.stringValue", @"Attribute histogram for query: digital camera [brand:canon]" },
    { @"links.0.href", @"http://base.google.com" },
      
    { @"unknownAttributes.@count.stringValue", @"0" },
    { @"unknownChildren.@count.stringValue", @"0" },
      
    // GDataEntryGoogleBase paths
    // There are two entries; we'll test against the first one
    { @"entries.0.identifier", @"http://www.google.com/attributes/brand%28text%29?bq=digital+camera+%5Bbrand%3Acanon%5D" },
    { @"entries.0.title.stringValue", @"brand(text)" },
    { @"entries.0.content.stringValue", @"Attribute \"brand\" of type text in query: digital camera [brand:canon]" },
      
    { @"entries.0.metadataItemType", nil },
    { @"entries.0.metadataAttributes.0.name", @"brand" },
    { @"entries.0.metadataAttributes.0.type", @"text" },
    { @"entries.0.metadataAttributes.0.count.stringValue", @"133144" },
    { @"entries.0.metadataAttributes.0.values.@count.stringValue", @"1" },
    { @"entries.0.metadataAttributes.0.values.0.count.stringValue", @"96775" },
    { @"entries.0.metadataAttributes.0.values.0.contents", @"canon" },
        
    { @"entries.0.unknownAttributes.@count.stringValue", @"0" },
    { @"entries.0.unknownChildren.@count.stringValue", @"0" },
      
    { @"", @"" }, // end of feed
      
    { nil, nil } // end of test array
  };
  
  [self runTests:tests];
}

- (void)testSpreadsheetFeeds {
  
  TestKeyPathValues tests[] =
  { 
    //
    // Spreadsheet feed (list of user's spreadsheets)
    //
    { @"GDataFeedSpreadsheet", @"Tests/FeedSpreadsheetTest1.xml" },
    
    // feed paths
    { @"identifier", @"http://spreadsheets.google.com/feeds/spreadsheets/private/full" },
    { @"links.2.href", @"http://spreadsheets.google.com/feeds/spreadsheets/private/full?tfe=" },
    { @"title.stringValue", @"Available Spreadsheets - test@foo.net" },
    
    { @"unknownAttributes.@count.stringValue", @"0" },
    { @"unknownChildren.@count.stringValue", @"0" },

    // entry paths
    // There is one entry
    { @"entries.0.identifier", @"http://spreadsheets.google.com/feeds/spreadsheets/private/full/o04181601172097104111.497668944883620000" },
    { @"entries.0.updatedDate.RFC3339String", @"2007-03-22T23:25:53Z" },
    { @"entries.0.categories.2.scheme", kGDataCategorySchemeSpreadsheet },
    { @"entries.0.categories.2.term", kGDataCategorySpreadsheet },
    { @"entries.0.title.stringValue", @"My Test Spreadsheet" },
    
    { @"entries.0.unknownAttributes.@count.stringValue", @"0" },
    { @"entries.0.unknownChildren.@count.stringValue", @"0" },
    
    { @"", @"" }, // end of feed
    
    //
    // Worksheet feed (list of a spreadsheet's worksheets)
    //
    { @"GDataFeedWorksheet", @"Tests/FeedSpreadsheetWorksheetTest1.xml" },
      
    // feed paths
    { @"identifier", @"http://spreadsheets.google.com/feeds/worksheets/o04181601172097104111.497668944883620000/private/full" },
    { @"links.2.href", @"http://spreadsheets.google.com/feeds/worksheets/o04181601172097104111.497668944883620000/private/full?tfe=" },
    { @"title.stringValue", @"My Test Spreadsheet" },
    { @"authors.0.email", @"test@foo.net" },
        
    { @"unknownAttributes.@count.stringValue", @"0" },
    { @"unknownChildren.@count.stringValue", @"0" },

    // entry paths
    // There is one entry
    { @"entries.0.identifier", @"http://spreadsheets.google.com/feeds/worksheets/o04181601172097104111.497668944883620000/private/full/od6" },
    { @"entries.0.updatedDate.RFC3339String", @"2007-03-22T23:28:50Z" },
    { @"entries.0.categories.0.scheme", kGDataCategorySchemeSpreadsheet },
    { @"entries.0.categories.0.term", kGDataCategoryWorksheet },
    { @"entries.0.title.stringValue", @"Sheet1" },
    { @"entries.0.rowCount.stringValue", @"100" },
    { @"entries.0.columnCount.stringValue", @"20" },
    
    { @"entries.0.unknownAttributes.@count.stringValue", @"0" },
    { @"entries.0.unknownChildren.@count.stringValue", @"0" },
      
    { @"", @"" }, // end of feed
 
    //
    // Cells feed (all of a worksheet's cells)
    //
    { @"GDataFeedSpreadsheetCell", @"Tests/FeedSpreadsheetCellsTest1.xml" },
    
    // feed paths
    { @"identifier", @"http://spreadsheets.google.com/feeds/cells/o04181601172097104111.497668944883620000/od6/private/full" },
    { @"links.0.href", @"http://spreadsheets.google.com/ccc?key=o04181601172097104111.497668944883620000" },
    { @"categories.0.scheme", kGDataCategorySchemeSpreadsheet },
    { @"categories.0.term", kGDataCategorySpreadsheetCell },
    { @"title.stringValue", @"Sheet1" },
    { @"authors.0.email", @"test@foo.net" },
    { @"rowCount.stringValue", @"100" },
    { @"columnCount.stringValue", @"20" },
  
    { @"unknownAttributes.@count.stringValue", @"0" },
    { @"unknownChildren.@count.stringValue", @"0" },

    // entry paths
    // The sheet looks like this (2 cols x 4 rows)
    // Fred	Martha
    // =pi()	    =sin(A2)
    // =1.5*pi()	=sin(A3)
    // =2.0*pi()	=sin(A4)
    
    { @"entries.1.identifier", @"http://spreadsheets.google.com/feeds/cells/o04181601172097104111.497668944883620000/od6/private/full/R1C2" },
    { @"entries.1.updatedDate.RFC3339String", @"2007-03-22T23:28:50Z" },
    { @"entries.1.categories.0.scheme", kGDataCategorySchemeSpreadsheet },
    { @"entries.1.categories.0.term", kGDataCategorySpreadsheetCell },
    { @"entries.1.title.stringValue", @"B1" },
    { @"entries.1.cell.column.stringValue", @"2" },
    { @"entries.1.cell.row.stringValue", @"1" },
    { @"entries.1.cell.inputString", @"Martha" },
    { @"entries.1.cell.numericValue", nil },
    { @"entries.1.cell.resultString", @"Martha" },
    
    { @"entries.0.unknownAttributes.@count.stringValue", @"0" },
    { @"entries.0.unknownChildren.@count.stringValue", @"0" },

    { @"", @"" }, // end of feed

    //
    // List feed (all of a worksheet as a list) which contains customElements
    //
    
    // feed paths
    { @"GDataFeedSpreadsheetList", @"Tests/FeedSpreadsheetListTest1.xml" },
    { @"identifier", @"http://spreadsheets.google.com/feeds/list/o04181601172097104111.497668944883620000/od6/private/full" },
    { @"links.0.href", @"http://spreadsheets.google.com/ccc?key=o04181601172097104111.497668944883620000" },
    { @"categories.0.scheme", kGDataCategorySchemeSpreadsheet },
    { @"categories.0.term", kGDataCategorySpreadsheetList },
    { @"title.stringValue", @"Sheet1" },
    { @"authors.0.email", @"test@foo.net" },
    
    { @"unknownAttributes.@count.stringValue", @"0" },
    { @"unknownChildren.@count.stringValue", @"0" },

    // entry paths
    { @"entries.1.customElementDictionary.fred.stringValue", @"4.71238898038469" },
    { @"entries.1.customElementDictionary.martha.stringValue", @"-1" },
    
    { @"entries.0.unknownAttributes.@count.stringValue", @"0" },
    { @"entries.0.unknownChildren.@count.stringValue", @"0" },

    { @"", @"" }, // end of feed
    
    { nil, nil } // end of test array
  };
  
  [self runTests:tests];
}

- (void)testCodeSearchFeed {
  
  TestKeyPathValues tests[] =
  { 
    //
    // Feed of a user's albums
    //
    { @"GDataFeedCodeSearch", @"Tests/FeedCodeSearchTest1.xml" },
      
    // GDataFeedCodeSearch paths
    { @"authors.0.name", @"Google Code Search" },
    { @"authors.0.URI", @"http://www.google.com/codesearch" },

    // GDataEntryCodeSearch paths
    { @"entries.0.package.name", @"http://ftp.funet.fi/pub/CPAN/src/perl-5.9.1.tar.gz" },
    { @"entries.0.package.URI", @"http://ftp.funet.fi/pub/CPAN/src/perl-5.9.1.tar.gz" },

    { @"entries.1.package.name", @"http://gentoo.osuosl.org/distfiles/Perl6-Pugs-6.2.12.tar.gz" },
    { @"entries.1.package.URI", @"http://gentoo.osuosl.org/distfiles/Perl6-Pugs-6.2.12.tar.gz" },
    { @"entries.1.file.name", @"Perl6-Pugs-6.2.12/t/subroutines/sub_named_params.t" },
    { @"entries.1.matches.0.lineNumberString", @"131" },
    { @"entries.1.matches.0.type", @"text/html" },
    { @"entries.1.matches.0.stringValue", @"hasPrefix:<pre>my %fellowship" },
    { @"entries.1.matches.1.lineNumberString", @"132" },
    { @"entries.1.matches.1.type", @"text/html" },
    { @"entries.1.matches.1.stringValue", @"hasPrefix:<pre>is(%fellowship&lt;hobbit&gt;" },
      
    { @"", @"" }, // end of feed
      
    { nil, nil } // end of test array
  };
  
  [self runTests:tests];
}

- (void)testPhotosFeeds {
  
  // TODO: test geoLocation once we have a good sample of it
  
  // Test a non-ASCII character and some html characters in a TextConstruct.  
  // We'll allocate it dynamically since source code cannot contain non-ASCII.
  NSString *template = @"Test %C Alb%Cm";
  NSString *photoAlbumName = [NSString stringWithFormat:template, 
    0x262F, 0x00FC]; // yin yang, u with umlaut
  
  // Non-ascii photo description, includes the Wheel of Dharma
  NSString *photoDescriptionText = [NSString stringWithFormat:
    @"Caption for the car %C photo", 0x2638];  

  TestKeyPathValues tests[] =
  { 
    //
    // Feed of a user's albums
    //
    { @"GDataFeedPhotoUser", @"Tests/FeedPhotosUserAlbum1.xml" },

    // GDataFeedPhotosAlbum paths
    { @"username", @"TestdomainTestAccount" },
    { @"nickname", @"Greg" },
    { @"thumbnail", @"hasPrefix:http://lh3.google.com/image/TestdomainTestAccount" },
    { @"quotaLimit.stringValue", @"1073741824" },
    { @"quotaUsed.stringValue", @"108303" },
    { @"maxPhotosPerAlbum.stringValue", @"500" },
    { @"categories.0.term", kGDataCategoryPhotosUser },

    { @"unknownAttributes.@count.stringValue", @"0" },
    { @"unknownChildren.@count.stringValue", @"0" },

    // GDataEntryPhotoAlbum paths
    { @"entries.0.categories.0.term", kGDataCategoryPhotosAlbum },

    { @"entries.0.mediaGroup.mediaTitle.stringValue", photoAlbumName },
    { @"entries.0.mediaGroup.mediaDescription.stringValue", @"Album description" },
    { @"entries.0.mediaGroup.mediaCredits.0.stringValue", @"Greg" },
    { @"entries.0.mediaGroup.mediaContents.0.medium", @"image" },
    { @"entries.0.mediaGroup.mediaContents.0.type", @"image/jpeg" },
    { @"entries.0.mediaGroup.mediaContents.0.URLString", @"hasPrefix:http://lh5.google.com/image/TestdomainTestAccount" },
    { @"entries.0.mediaGroup.mediaThumbnails.0.height.stringValue", @"160" },
    { @"entries.0.mediaGroup.mediaThumbnails.0.URLString", @"hasPrefix:http://lh5.google.com/image/TestdomainTestAccount" },

    { @"entries.0.GPhotoID", @"5067143575034336993" },
    { @"entries.0.name", @"TestAlbM" },
    { @"entries.0.access", @"public" },
    { @"entries.0.photosUsed.stringValue", @"2" },
    { @"entries.0.commentCount.stringValue", @"0" },
    { @"entries.0.bytesUsed.stringValue", @"108303" },
    { @"entries.0.nickname", @"Greg" },
    { @"entries.0.photosLeft.stringValue", @"498" },
    { @"entries.0.commentsEnabled.stringValue", @"1" },
    { @"entries.0.location", @"Album Site" },
    { @"entries.0.timestamp.dateValue.description", @"2007-05-21 00:00:00 -0700" },
    { @"entries.0.username", @"TestdomainTestAccount" },
    { @"entries.0.identifier", @"http://picasaweb.google.com/data/entry/api/user/TestdomainTestAccount/albumid/5067143575034336993" },
    { @"entries.0.title.type", @"text" },
    { @"entries.0.title.stringValue", photoAlbumName },
    { @"entries.0.photoDescription.stringValue", @"Album description" },
    { @"entries.0.rightsString.stringValue", @"public" },

    { @"entries.0.unknownAttributes.@count.stringValue", @"0" },
    { @"entries.0.unknownChildren.@count.stringValue", @"0" },

    { @"", @"" }, // end of feed

    //
    // Feed of an album's photos
    //
    { @"GDataFeedPhotoAlbum", @"Tests/FeedPhotosAlbumPhoto1.xml" },

    // GDataFeedPhotoAlbum - feed paths
    { @"GPhotoID", @"5067143575034336993" },
    { @"name", @"TestAlbM" },
    { @"access", @"public" },
    { @"photosUsed.stringValue", @"2" },
    { @"commentCount.stringValue", @"0" },
    { @"bytesUsed.stringValue", @"108303" },
    { @"nickname", @"Greg" },
    { @"photosLeft.stringValue", @"498" },
    { @"commentsEnabled.stringValue", @"1" },
    { @"location", @"Album Site" },
    { @"timestamp.dateValue.description", @"2007-05-21 00:00:00 -0700" },
    { @"username", @"TestdomainTestAccount" },
    { @"identifier", @"http://picasaweb.google.com/data/feed/api/user/test%40testdomain.net/albumid/5067143575034336993" },
    { @"title.type", @"text" },
    { @"title.stringValue", photoAlbumName },
    { @"photoDescription.stringValue", @"Album description" },
    { @"rights.stringValue", @"public" },
    { @"categories.0.term", kGDataCategoryPhotosAlbum },

    { @"unknownAttributes.@count.stringValue", @"0" },
    { @"unknownChildren.@count.stringValue", @"0" },

    // GDataEntryPhoto - entry paths
    { @"entries.0.categories.0.term", kGDataCategoryPhotosPhoto },

    { @"entries.0.position.stringValue", @"1.1" },
    { @"entries.0.checksum", @"23512309abbs298" },
    { @"entries.0.GPhotoID", @"5067143579329304306" },
    { @"entries.0.version", @"1179786875940336" },
    { @"entries.0.albumID", @"5067143575034336993" },
    { @"entries.0.client", @"Picasa 2.6" },
    { @"entries.0.width.stringValue", @"660" },
    { @"entries.0.height.stringValue", @"433" },
    { @"entries.0.commentsEnabled.stringValue", @"1" },
    { @"entries.0.size.stringValue", @"87225" },
    { @"entries.0.commentCount.stringValue", @"1" },
    { @"entries.0.timestamp.dateValue.description", @"2007-05-21 15:25:01 -0700" },
    { @"entries.0.title.stringValue", @"Car.jpg" },
    { @"entries.0.photoDescription.stringValue", photoDescriptionText },
    { @"entries.0.content.sourceURI", @"http://lh3.google.com/image/TestdomainTestAccount/RlIcPQ_TFvI/AAAAAAAAAAs/3fvWtQLN3KI/Car.jpg" },
    { @"entries.0.content.type", @"image/jpeg" },

    { @"entries.0.mediaGroup.mediaTitle.stringValue", @"Car.jpg" },
    { @"entries.0.mediaGroup.mediaDescription.stringValue", photoDescriptionText },
    { @"entries.0.mediaGroup.mediaCredits.0.stringValue", @"Greg" },
    { @"entries.0.mediaGroup.mediaContents.0.medium", @"image" },
    { @"entries.0.mediaGroup.mediaContents.0.type", @"image/jpeg" },
    { @"entries.0.mediaGroup.mediaContents.0.URLString", @"http://lh3.google.com/image/TestdomainTestAccount/RlIcPQ_TFvI/AAAAAAAAAAs/3fvWtQLN3KI/Car.jpg" },
    { @"entries.0.mediaGroup.mediaThumbnails.0.height.stringValue", @"47" },
    { @"entries.0.mediaGroup.mediaThumbnails.0.width.stringValue", @"72" },
    { @"entries.0.mediaGroup.mediaThumbnails.0.URLString", @"http://lh3.google.com/image/TestdomainTestAccount/RlIcPQ_TFvI/AAAAAAAAAAs/3fvWtQLN3KI/Car.jpg?imgmax=72" },
    { @"entries.0.mediaGroup.mediaKeywords.stringValue", @"headlight, red car" },

    { @"entries.0.EXIFTags.tagDictionary.exposure", @"0.0080" },
    { @"entries.0.EXIFTags.tagDictionary.imageUniqueID", @"d8a9e8fd57a384d216f4b2a853d654fc" },

    { @"entries.0.unknownAttributes.@count.stringValue", @"0" },
    { @"entries.0.unknownChildren.@count.stringValue", @"0" },

    { @"", @"" }, // end of feed

    //
    // Feed of a photo's comments
    //
    { @"GDataFeedPhoto", @"Tests/FeedPhotosPhotoComment1.xml" },

    // GDataFeedPhoto - feed paths
    { @"generator.URI", @"http://picasaweb.google.com/" },
    { @"generator.name", @"Picasaweb" },
    { @"generator.version", @"1.00" },
    { @"EXIFTags.tagDictionary.exposure", @"0.0080" },
    { @"categories.0.term", kGDataCategoryPhotosPhoto },
    { @"EXIFTags.tagDictionary.imageUniqueID", @"d8a9e8fd57a384d216f4b2a853d654fc" },
    { @"position.stringValue", @"1.1" },
    { @"checksum", @"23512309abbs298" },
    { @"GPhotoID", @"5067143579329304306" },
    { @"version", @"1179786875940336" },
    { @"albumID", @"5067143575034336993" },
    { @"client", @"Picasa 2.6" },
    { @"width.stringValue", @"660" },
    { @"height.stringValue", @"433" },
    { @"commentsEnabled.stringValue", @"1" },
    { @"size.stringValue", @"87225" },
    { @"commentCount.stringValue", @"1" },
    { @"timestamp.dateValue.description", @"2007-05-21 15:25:01 -0700" },
    { @"title.stringValue", @"Car.jpg" },
    { @"photoDescription.stringValue", photoDescriptionText },
    { @"icon", @"http://lh3.google.com/image/TestdomainTestAccount/RlIcPQ_TFvI/AAAAAAAAAAs/3fvWtQLN3KI/Car.jpg?imgmax=288" },

    { @"unknownAttributes.@count.stringValue", @"0" },
    { @"unknownChildren.@count.stringValue", @"0" },

    // GDataEntryPhotoComment - entry paths
    { @"entries.0.photoID", @"5067143579329304306" },
    { @"entries.0.GPhotoID", @"5067146044640532244" }, 
    { @"entries.0.categories.0.term", kGDataCategoryPhotosComment },

    { @"entries.0.unknownAttributes.@count.stringValue", @"0" },
    { @"entries.0.unknownChildren.@count.stringValue", @"0" },

    { @"", @"" }, // end of feed

    //
    // Feed of a user's tags
    //

    // GDataFeedPhotoUser - feed paths

    { @"GDataFeedPhotoUser", @"Tests/FeedPhotosUserTag1.xml" },
    { @"username", @"TestdomainTestAccount" },
    { @"nickname", @"Greg" },
    { @"thumbnail", @"hasPrefix:http://lh3.google.com/image/TestdomainTestAccount" },
    { @"quotaLimit.stringValue", @"1073741824" },
    { @"quotaUsed.stringValue", @"108303" },
    { @"maxPhotosPerAlbum.stringValue", @"500" },
    { @"categories.0.term", kGDataCategoryPhotosUser },

    { @"unknownAttributes.@count.stringValue", @"0" },
    { @"unknownChildren.@count.stringValue", @"0" },

    // GDataEntryPhotoTag - entry paths
    
    { @"entries.0.title.stringValue", @"headlight" },
    { @"entries.0.photoDescription.stringValue", @"headlight" }, 
    { @"entries.0.categories.0.term", kGDataCategoryPhotosTag },

    { @"entries.0.unknownAttributes.@count.stringValue", @"0" },
    { @"entries.0.unknownChildren.@count.stringValue", @"0" },

    { @"entries.1.title.stringValue", @"red car" },
    { @"entries.1.photoDescription.stringValue", @"red car" }, 
    { @"entries.1.categories.0.term", kGDataCategoryPhotosTag },

    { @"entries.1.unknownAttributes.@count.stringValue", @"0" },
    { @"entries.1.unknownChildren.@count.stringValue", @"0" },

    { @"", @"" }, // end of feed

    //
    // Feed of a user entry
    //
    // This is really a fake feed created by requesting just a single
    // user entry from the picasa server, using
    // GET http://picasaweb.google.com/data/entry/api/user/<username>
    //
    
    // GDataFeedPhotoUser - feed paths (none)
      
    // GDataEntryPhotoUser - entry paths
    { @"GDataFeedPhotoUser", @"Tests/FeedPhotosUserEntry1.xml" },

    { @"entries.0.nickname", @"Greg" },
    { @"entries.0.username", @"TestdomainTestAccount" }, 
    { @"entries.0.thumbnail", @"hasPrefix:http://lh3.google.com/image/TestdomainTestAccount/AAAAUbcFQeo" },
    { @"entries.0.identifier", @"http://picasaweb.google.com/data/entry/api/user/TestdomainTestAccount" },
    { @"entries.0.categories.0.term", kGDataCategoryPhotosUser },
      
    { @"entries.0.unknownAttributes.@count.stringValue", @"0" },
    { @"entries.0.unknownChildren.@count.stringValue", @"0" },
    
    { @"", @"" }, // end of feed
      
    { nil, nil } // end of test array
  };
  
  [self runTests:tests];
}



- (void)testMessageFeed {
  
  TestKeyPathValues tests[] =
  { 
    //
    // Message Feed
    //
  { @"GDataFeedMessage", @"Tests/FeedMessageTest1.xml" },
    
    // GDataFeedMessage paths
  { @"links.0.href", @"hasPrefix:http://www.google.com/calendar/feeds/default" },
  { @"categories.0.term", kGDataMessage },
    
  { @"unknownAttributes.@count.stringValue", @"0" },
  { @"unknownChildren.@count.stringValue", @"0" },
    
    // GDataEntryMessage paths
  { @"entries.0.categories.0.term", kGDataMessage },
  { @"entries.0.categories.1.term", kGDataMessageSent },
  { @"entries.0.identifier", @"http://mymail.example.com/feeds/jo/home/full/e1a2af06df8a563edf9d32ec9fd61e03f7f3b67b" },
  { @"entries.0.content.stringValue", @"Hi, Fritz -- The information you're looking for is on p. 47." },
  { @"entries.0.title.stringValue", @"Re: Info?" },
  { @"entries.0.participants.0.rel", kGDataWhoMessageFrom },
  { @"entries.0.participants.1.rel", kGDataWhoMessageTo },
    
  { @"entries.0.unknownAttributes.@count.stringValue", @"0" },
  { @"entries.0.unknownChildren.@count.stringValue", @"0" },
    
  { @"", @"" }, // end of feed
    
  { nil, nil } // end of test array
  };
  
  [self runTests:tests];
}


- (void)testDocListFeed {
  
  TestKeyPathValues tests[] =
  { 
    //
    // Docs Feed
    //
    { @"GDataFeedDocList", @"Tests/FeedDocListTest1.xml" },
    
    { @"identifier", @"http://docs.google.com/feeds/documents/private/full" },

    // Docs Entries.  The elements are all standard atom protocol elements,
    // so we are just interested that the proper entry class has been 
    // instantiated 
    { @"entries.0.className", @"GDataEntryStandardDoc" },
    { @"entries.0.categories.0.term", @"http://schemas.google.com/docs/2007#document"},
    { @"entries.0.categories.0.label", @"document"},

    { @"entries.1.className", @"GDataEntrySpreadsheetDoc" },
    { @"entries.1.categories.0.term", @"http://schemas.google.com/docs/2007#spreadsheet"},
    { @"entries.1.categories.0.label", @"spreadsheet"},
    
    { @"entries.2.className", @"GDataEntryPresentationDoc" },
    { @"entries.2.categories.0.term", @"http://schemas.google.com/docs/2007#presentation"},
    { @"entries.2.categories.0.label", @"presentation"},
  
    { @"entries.0.unknownAttributes.@count.stringValue", @"0" },
    { @"entries.0.unknownChildren.@count.stringValue", @"0" },
      
      
    { @"", @"" }, // end of feed
      
    { nil, nil } // end of test array
  };
  [self runTests:tests];
};
  

- (void)testACLFeed {
  
  TestKeyPathValues tests[] =
  { 
    //
    // ACL Feed
    //
    { @"GDataFeedACL", @"Tests/FeedACLTest1.xml" },
      
      // GDataFeedACL paths
    { @"links.0.href", @"http://www.google.com/calendar/feeds/test%40gmail.com/private/full" },
    { @"links.0.rel", kGDataLinkRelControlledObject },
    { @"categories.0.term", kGDataCategoryACL },
    { @"categories.0.scheme", kGDataCategoryScheme },
      
    { @"unknownAttributes.@count.stringValue", @"0" },
    { @"unknownChildren.@count.stringValue", @"0" },
      
      // GDataEntryACL paths (scope and role are the main elements)
    { @"entries.0.categories.0.term", kGDataCategoryACL },
    { @"entries.0.identifier", @"http://www.google.com/calendar/feeds/test%40gmail.com/acl/full/user%3Atest%40gmail.com" },
    { @"entries.0.content.stringValue", @"" },
    { @"entries.0.links.1.rel", @"edit" },
    { @"entries.0.scope.type", @"user" },
    { @"entries.0.scope.value", @"test@gmail.com" },
    { @"entries.0.role.value", @"http://schemas.google.com/gCal/2005#owner" },
      
    { @"entries.0.unknownAttributes.@count.stringValue", @"0" },
    { @"entries.0.unknownChildren.@count.stringValue", @"0" },

      
    { @"", @"" }, // end of feed
      
    { nil, nil } // end of test array
  };
  
  [self runTests:tests];
}

@end
