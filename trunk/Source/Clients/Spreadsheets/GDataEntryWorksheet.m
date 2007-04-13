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
//  GDataEntryWorksheet.m
//

#define GDATAENTRYWORKSHEET_DEFINE_GLOBALS 1

#import "GDataEntryWorksheet.h"
#import "GDataEntrySpreadsheet.h"
#import "GDataRowColumnCount.h"

// extensions



@implementation GDataEntryWorksheet


+ (GDataEntryWorksheet *)worksheetEntry {
  GDataEntryWorksheet *entry = [[[GDataEntryWorksheet alloc] init] autorelease];

  [entry setNamespaces:[GDataEntrySpreadsheet spreadsheetNamespaces]];
  return entry;
}

#pragma mark -

+ (void)load {
  [GDataObject registerEntryClass:[self class]
            forCategoryWithScheme:kGDataCategorySchemeSpreadsheet 
                             term:kGDataCategoryWorksheet];
}

- (void)initExtensionDeclarations {
  
  [super initExtensionDeclarations];
  
  Class entryClass = [self class];
  
  
  // Worksheet extensions
  [self addExtensionDeclarationForParentClass:entryClass
                                   childClass:[GDataColumnCount class]];
  [self addExtensionDeclarationForParentClass:entryClass
                                   childClass:[GDataRowCount class]];  
}

- (NSMutableArray *)itemsForDescription {
  
  NSMutableArray *items = [super itemsForDescription];
  
  NSString *colStr = [NSString stringWithFormat:@"%d", [self columnCount]];
  NSString *rowStr = [NSString stringWithFormat:@"%d", [self rowCount]];
  
  [self addToArray:items objectDescriptionIfNonNil:colStr withName:@"cols"];
  [self addToArray:items objectDescriptionIfNonNil:rowStr withName:@"rows"];
  
  return items;
}

- (id)init {
  self = [super init];
  if (self) {
    [self addCategory:[GDataCategory categoryWithScheme:kGDataCategorySchemeSpreadsheet
                                                   term:kGDataCategoryWorksheet]];
  }
  return self;
}

#pragma mark -

- (int)rowCount {
  GDataRowCount *rowCount = 
    (GDataRowCount *) [self objectForExtensionClass:[GDataRowCount class]];
  
  return [rowCount count];
}

- (int)columnCount {
  GDataColumnCount *columnCount = 
    (GDataColumnCount *) [self objectForExtensionClass:[GDataColumnCount class]];
  
  return [columnCount count];
}

@end
