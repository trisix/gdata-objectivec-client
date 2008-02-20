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
//  GDataMediaThumbnail.h
//

#import "GDataObject.h"
#import "GDataNormalPlayTime.h"

// media:thumbnail element
//
//   <media:thumbnail url="http://www.foo.com/keyframe.jpg" 
//                    width="75" height="50" time="12:05:01.123" />
//
// http://search.yahoo.com/mrss

@interface GDataMediaThumbnail : GDataObject <NSCopying, GDataExtension> {
  NSString* urlString_; 
  NSNumber* height_;
  NSNumber* width_;
  GDataNormalPlayTime* time_;
}
+ (GDataMediaThumbnail *)mediaContentWithURL:(NSString *)urlString;

- (id)initWithXMLElement:(NSXMLElement *)element
                  parent:(GDataObject *)parent;
- (NSXMLElement *)XMLElement;


- (NSString *)URLString;
- (void)setURLString:(NSString *)str;

- (NSNumber *)height;
- (void)setHeight:(NSNumber *)num;

- (NSNumber *)width;
- (void)setWidth:(NSNumber *)num;

- (GDataNormalPlayTime *)time;
- (void)setTime:(GDataNormalPlayTime *)time;
@end
