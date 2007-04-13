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
//  GDataStuff.h
//

#import <Cocoa/Cocoa.h>

#import "GDataObject.h"


// an element with a value="" attribute, as in
// <gCal:timezone value="America/Los_Angeles"/>
// (subclasses may override the attribute name)
@interface GDataValueConstruct : GDataObject <NSCopying> {
  NSString *value_;
}

+ (GDataValueConstruct *)valueWithString:(NSString *)str;

- (id)initWithXMLElement:(NSXMLElement *)element
                  parent:(GDataObject *)parent;

- (NSXMLElement *)XMLElement;

- (NSString *)stringValue;
- (void)setStringValue:(NSString *)str;

- (NSString *)attributeName; // defaults to "value", subclasses can override

// subclass value utilities
- (int)intValue;
- (void)setIntValue:(int)val;

- (long long)longLongValue;
- (void)setLongLongValue:(long long)val;

- (double)doubleValue;
- (void)setDoubleValue:(double)value;

- (BOOL)boolValue;
- (void)setBoolValue:(BOOL)flag;

@end

// GDataValueElementConstruct is for subclasses that keep the value
// in the child text nodes
@interface GDataValueElementConstruct : GDataValueConstruct
- (NSString *)attributeName; // returns nil
@end

// an element with a value=true or false attribute, as in
//   <gCal:sendEventNotifications value="true"/>
@interface GDataBoolValueConstruct : GDataValueConstruct
+ (GDataBoolValueConstruct *)boolValueWithBool:(BOOL)flag;
@end
