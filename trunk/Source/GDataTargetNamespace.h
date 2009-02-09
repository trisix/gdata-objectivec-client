//
// Makes the value of GDATA_TARGET_NAMESPACE a prefix for all GData class names
//

//
// To avoid global namespace issues, define GDATA_TARGET_NAMESPACE to a short
// string in your target if you are using the GData library in a shared-code
// environment like a plug-in.
//
// For example:   -DGDATA_TARGET_NAMESPACE=MyPlugin
//

//
// com.google.GDataFramework v. 1.6 (357 classes) 2009-02-09 13:32:12 -0800
//

#if defined(__OBJC__) && defined(GDATA_TARGET_NAMESPACE)

  #define _GDATA_NS_SYMBOL_INNER(namespace, symbol) namespace ## _ ## symbol
  #define _GDATA_NS_SYMBOL_MIDDLE(namespace, symbol) _GDATA_NS_SYMBOL_INNER(namespace, symbol)
  #define _GDATA_NS_SYMBOL(symbol) _GDATA_NS_SYMBOL_MIDDLE(GDATA_TARGET_NAMESPACE, symbol)

  #define _GDATA_NS_STRING_INNER(namespace) #namespace
  #define _GDATA_NS_STRING_MIDDLE(namespace) _GDATA_NS_STRING_INNER(namespace)
  #define GDATA_TARGET_NAMESPACE_STRING _GDATA_NS_STRING_MIDDLE(GDATA_TARGET_NAMESPACE)

  #define GDataAccessLevelProperty             _GDATA_NS_SYMBOL(GDataAccessLevelProperty)
  #define GDataACLRole                         _GDATA_NS_SYMBOL(GDataACLRole)
  #define GDataACLScope                        _GDATA_NS_SYMBOL(GDataACLScope)
  #define GDataAtomAccept                      _GDATA_NS_SYMBOL(GDataAtomAccept)
  #define GDataAtomAccept1_0                   _GDATA_NS_SYMBOL(GDataAtomAccept1_0)
  #define GDataAtomAuthor                      _GDATA_NS_SYMBOL(GDataAtomAuthor)
  #define GDataAtomCategoryGroup               _GDATA_NS_SYMBOL(GDataAtomCategoryGroup)
  #define GDataAtomCategoryGroup1_0            _GDATA_NS_SYMBOL(GDataAtomCategoryGroup1_0)
  #define GDataAtomCollection                  _GDATA_NS_SYMBOL(GDataAtomCollection)
  #define GDataAtomCollection1_0               _GDATA_NS_SYMBOL(GDataAtomCollection1_0)
  #define GDataAtomContent                     _GDATA_NS_SYMBOL(GDataAtomContent)
  #define GDataAtomContributor                 _GDATA_NS_SYMBOL(GDataAtomContributor)
  #define GDataAtomIcon                        _GDATA_NS_SYMBOL(GDataAtomIcon)
  #define GDataAtomID                          _GDATA_NS_SYMBOL(GDataAtomID)
  #define GDataAtomLogo                        _GDATA_NS_SYMBOL(GDataAtomLogo)
  #define GDataAtomPubControl                  _GDATA_NS_SYMBOL(GDataAtomPubControl)
  #define GDataAtomPubControl1_0               _GDATA_NS_SYMBOL(GDataAtomPubControl1_0)
  #define GDataAtomPubEditedDate1_0            _GDATA_NS_SYMBOL(GDataAtomPubEditedDate1_0)
  #define GDataAtomPubEditedDateStd            _GDATA_NS_SYMBOL(GDataAtomPubEditedDateStd)
  #define GDataAtomPublishedDate               _GDATA_NS_SYMBOL(GDataAtomPublishedDate)
  #define GDataAtomRights                      _GDATA_NS_SYMBOL(GDataAtomRights)
  #define GDataAtomServiceDocument             _GDATA_NS_SYMBOL(GDataAtomServiceDocument)
  #define GDataAtomServiceDocument1_0          _GDATA_NS_SYMBOL(GDataAtomServiceDocument1_0)
  #define GDataAtomSubtitle                    _GDATA_NS_SYMBOL(GDataAtomSubtitle)
  #define GDataAtomSummary                     _GDATA_NS_SYMBOL(GDataAtomSummary)
  #define GDataAtomTitle                       _GDATA_NS_SYMBOL(GDataAtomTitle)
  #define GDataAtomUpdatedDate                 _GDATA_NS_SYMBOL(GDataAtomUpdatedDate)
  #define GDataAtomWorkspace                   _GDATA_NS_SYMBOL(GDataAtomWorkspace)
  #define GDataAtomWorkspace1_0                _GDATA_NS_SYMBOL(GDataAtomWorkspace1_0)
  #define GDataAttendeeStatus                  _GDATA_NS_SYMBOL(GDataAttendeeStatus)
  #define GDataAttendeeType                    _GDATA_NS_SYMBOL(GDataAttendeeType)
  #define GDataAttribute                       _GDATA_NS_SYMBOL(GDataAttribute)
  #define GDataBatchID                         _GDATA_NS_SYMBOL(GDataBatchID)
  #define GDataBatchInterrupted                _GDATA_NS_SYMBOL(GDataBatchInterrupted)
  #define GDataBatchOperation                  _GDATA_NS_SYMBOL(GDataBatchOperation)
  #define GDataBatchStatus                     _GDATA_NS_SYMBOL(GDataBatchStatus)
  #define GDataBoolValueConstruct              _GDATA_NS_SYMBOL(GDataBoolValueConstruct)
  #define GDataCategory                        _GDATA_NS_SYMBOL(GDataCategory)
  #define GDataCategoryFilter                  _GDATA_NS_SYMBOL(GDataCategoryFilter)
  #define GDataCodeSearchFile                  _GDATA_NS_SYMBOL(GDataCodeSearchFile)
  #define GDataCodeSearchMatch                 _GDATA_NS_SYMBOL(GDataCodeSearchMatch)
  #define GDataCodeSearchPackage               _GDATA_NS_SYMBOL(GDataCodeSearchPackage)
  #define GDataColorProperty                   _GDATA_NS_SYMBOL(GDataColorProperty)
  #define GDataColumnCount                     _GDATA_NS_SYMBOL(GDataColumnCount)
  #define GDataComment                         _GDATA_NS_SYMBOL(GDataComment)
  #define GDataCommission                      _GDATA_NS_SYMBOL(GDataCommission)
  #define GDataContactSystemGroup              _GDATA_NS_SYMBOL(GDataContactSystemGroup)
  #define GDataCostBasis                       _GDATA_NS_SYMBOL(GDataCostBasis)
  #define GDataDateTime                        _GDATA_NS_SYMBOL(GDataDateTime)
  #define GDataDaysGain                        _GDATA_NS_SYMBOL(GDataDaysGain)
  #define GDataDCCreator                       _GDATA_NS_SYMBOL(GDataDCCreator)
  #define GDataDCDate                          _GDATA_NS_SYMBOL(GDataDCDate)
  #define GDataDCDescription                   _GDATA_NS_SYMBOL(GDataDCDescription)
  #define GDataDCFormat                        _GDATA_NS_SYMBOL(GDataDCFormat)
  #define GDataDCIdentifier                    _GDATA_NS_SYMBOL(GDataDCIdentifier)
  #define GDataDCLanguage                      _GDATA_NS_SYMBOL(GDataDCLanguage)
  #define GDataDCPublisher                     _GDATA_NS_SYMBOL(GDataDCPublisher)
  #define GDataDCSubject                       _GDATA_NS_SYMBOL(GDataDCSubject)
  #define GDataDCTitle                         _GDATA_NS_SYMBOL(GDataDCTitle)
  #define GDataDeleted                         _GDATA_NS_SYMBOL(GDataDeleted)
  #define GDataEmail                           _GDATA_NS_SYMBOL(GDataEmail)
  #define GDataEntryACL                        _GDATA_NS_SYMBOL(GDataEntryACL)
  #define GDataEntryBase                       _GDATA_NS_SYMBOL(GDataEntryBase)
  #define GDataEntryCalendar                   _GDATA_NS_SYMBOL(GDataEntryCalendar)
  #define GDataEntryCalendarEvent              _GDATA_NS_SYMBOL(GDataEntryCalendarEvent)
  #define GDataEntryCodeSearch                 _GDATA_NS_SYMBOL(GDataEntryCodeSearch)
  #define GDataEntryContact                    _GDATA_NS_SYMBOL(GDataEntryContact)
  #define GDataEntryContactGroup               _GDATA_NS_SYMBOL(GDataEntryContactGroup)
  #define GDataEntryContent                    _GDATA_NS_SYMBOL(GDataEntryContent)
  #define GDataEntryDocBase                    _GDATA_NS_SYMBOL(GDataEntryDocBase)
  #define GDataEntryEvent                      _GDATA_NS_SYMBOL(GDataEntryEvent)
  #define GDataEntryFinancePortfolio           _GDATA_NS_SYMBOL(GDataEntryFinancePortfolio)
  #define GDataEntryFinancePosition            _GDATA_NS_SYMBOL(GDataEntryFinancePosition)
  #define GDataEntryFinanceTransaction         _GDATA_NS_SYMBOL(GDataEntryFinanceTransaction)
  #define GDataEntryFolderDoc                  _GDATA_NS_SYMBOL(GDataEntryFolderDoc)
  #define GDataEntryGoogleBase                 _GDATA_NS_SYMBOL(GDataEntryGoogleBase)
  #define GDataEntryLink                       _GDATA_NS_SYMBOL(GDataEntryLink)
  #define GDataEntryMessage                    _GDATA_NS_SYMBOL(GDataEntryMessage)
  #define GDataEntryPDFDoc                     _GDATA_NS_SYMBOL(GDataEntryPDFDoc)
  #define GDataEntryPhoto                      _GDATA_NS_SYMBOL(GDataEntryPhoto)
  #define GDataEntryPhotoAlbum                 _GDATA_NS_SYMBOL(GDataEntryPhotoAlbum)
  #define GDataEntryPhotoBase                  _GDATA_NS_SYMBOL(GDataEntryPhotoBase)
  #define GDataEntryPhotoComment               _GDATA_NS_SYMBOL(GDataEntryPhotoComment)
  #define GDataEntryPhotoTag                   _GDATA_NS_SYMBOL(GDataEntryPhotoTag)
  #define GDataEntryPhotoUser                  _GDATA_NS_SYMBOL(GDataEntryPhotoUser)
  #define GDataEntryPresentationDoc            _GDATA_NS_SYMBOL(GDataEntryPresentationDoc)
  #define GDataEntrySite                       _GDATA_NS_SYMBOL(GDataEntrySite)
  #define GDataEntrySitemapBase                _GDATA_NS_SYMBOL(GDataEntrySitemapBase)
  #define GDataEntrySitemapMobile              _GDATA_NS_SYMBOL(GDataEntrySitemapMobile)
  #define GDataEntrySitemapNews                _GDATA_NS_SYMBOL(GDataEntrySitemapNews)
  #define GDataEntrySitemapRegular             _GDATA_NS_SYMBOL(GDataEntrySitemapRegular)
  #define GDataEntrySpreadsheet                _GDATA_NS_SYMBOL(GDataEntrySpreadsheet)
  #define GDataEntrySpreadsheetCell            _GDATA_NS_SYMBOL(GDataEntrySpreadsheetCell)
  #define GDataEntrySpreadsheetDoc             _GDATA_NS_SYMBOL(GDataEntrySpreadsheetDoc)
  #define GDataEntrySpreadsheetList            _GDATA_NS_SYMBOL(GDataEntrySpreadsheetList)
  #define GDataEntryStandardDoc                _GDATA_NS_SYMBOL(GDataEntryStandardDoc)
  #define GDataEntryVolume                     _GDATA_NS_SYMBOL(GDataEntryVolume)
  #define GDataEntryWorksheet                  _GDATA_NS_SYMBOL(GDataEntryWorksheet)
  #define GDataEntryYouTubeComment             _GDATA_NS_SYMBOL(GDataEntryYouTubeComment)
  #define GDataEntryYouTubeComplaint           _GDATA_NS_SYMBOL(GDataEntryYouTubeComplaint)
  #define GDataEntryYouTubeFavorite            _GDATA_NS_SYMBOL(GDataEntryYouTubeFavorite)
  #define GDataEntryYouTubeFeedLinkBase        _GDATA_NS_SYMBOL(GDataEntryYouTubeFeedLinkBase)
  #define GDataEntryYouTubeFriend              _GDATA_NS_SYMBOL(GDataEntryYouTubeFriend)
  #define GDataEntryYouTubePlaylist            _GDATA_NS_SYMBOL(GDataEntryYouTubePlaylist)
  #define GDataEntryYouTubePlaylistLink        _GDATA_NS_SYMBOL(GDataEntryYouTubePlaylistLink)
  #define GDataEntryYouTubeRating              _GDATA_NS_SYMBOL(GDataEntryYouTubeRating)
  #define GDataEntryYouTubeSubscription        _GDATA_NS_SYMBOL(GDataEntryYouTubeSubscription)
  #define GDataEntryYouTubeUpload              _GDATA_NS_SYMBOL(GDataEntryYouTubeUpload)
  #define GDataEntryYouTubeUserProfile         _GDATA_NS_SYMBOL(GDataEntryYouTubeUserProfile)
  #define GDataEntryYouTubeVideo               _GDATA_NS_SYMBOL(GDataEntryYouTubeVideo)
  #define GDataEntryYouTubeVideoMessage        _GDATA_NS_SYMBOL(GDataEntryYouTubeVideoMessage)
  #define GDataETagAttribute                   _GDATA_NS_SYMBOL(GDataETagAttribute)
  #define GDataEventStatus                     _GDATA_NS_SYMBOL(GDataEventStatus)
  #define GDataEXIFTag                         _GDATA_NS_SYMBOL(GDataEXIFTag)
  #define GDataEXIFTags                        _GDATA_NS_SYMBOL(GDataEXIFTags)
  #define GDataExtendedProperty                _GDATA_NS_SYMBOL(GDataExtendedProperty)
  #define GDataExtensionDeclaration            _GDATA_NS_SYMBOL(GDataExtensionDeclaration)
  #define GDataFeedACL                         _GDATA_NS_SYMBOL(GDataFeedACL)
  #define GDataFeedBase                        _GDATA_NS_SYMBOL(GDataFeedBase)
  #define GDataFeedCalendar                    _GDATA_NS_SYMBOL(GDataFeedCalendar)
  #define GDataFeedCalendarEvent               _GDATA_NS_SYMBOL(GDataFeedCalendarEvent)
  #define GDataFeedCodeSearch                  _GDATA_NS_SYMBOL(GDataFeedCodeSearch)
  #define GDataFeedContact                     _GDATA_NS_SYMBOL(GDataFeedContact)
  #define GDataFeedContactGroup                _GDATA_NS_SYMBOL(GDataFeedContactGroup)
  #define GDataFeedDocList                     _GDATA_NS_SYMBOL(GDataFeedDocList)
  #define GDataFeedEvent                       _GDATA_NS_SYMBOL(GDataFeedEvent)
  #define GDataFeedFinancePortfolio            _GDATA_NS_SYMBOL(GDataFeedFinancePortfolio)
  #define GDataFeedFinancePosition             _GDATA_NS_SYMBOL(GDataFeedFinancePosition)
  #define GDataFeedFinanceTransaction          _GDATA_NS_SYMBOL(GDataFeedFinanceTransaction)
  #define GDataFeedGoogleBase                  _GDATA_NS_SYMBOL(GDataFeedGoogleBase)
  #define GDataFeedLink                        _GDATA_NS_SYMBOL(GDataFeedLink)
  #define GDataFeedMessage                     _GDATA_NS_SYMBOL(GDataFeedMessage)
  #define GDataFeedPhoto                       _GDATA_NS_SYMBOL(GDataFeedPhoto)
  #define GDataFeedPhotoAlbum                  _GDATA_NS_SYMBOL(GDataFeedPhotoAlbum)
  #define GDataFeedPhotoBase                   _GDATA_NS_SYMBOL(GDataFeedPhotoBase)
  #define GDataFeedPhotoUser                   _GDATA_NS_SYMBOL(GDataFeedPhotoUser)
  #define GDataFeedSite                        _GDATA_NS_SYMBOL(GDataFeedSite)
  #define GDataFeedSitemap                     _GDATA_NS_SYMBOL(GDataFeedSitemap)
  #define GDataFeedSpreadsheet                 _GDATA_NS_SYMBOL(GDataFeedSpreadsheet)
  #define GDataFeedSpreadsheetCell             _GDATA_NS_SYMBOL(GDataFeedSpreadsheetCell)
  #define GDataFeedSpreadsheetList             _GDATA_NS_SYMBOL(GDataFeedSpreadsheetList)
  #define GDataFeedVolume                      _GDATA_NS_SYMBOL(GDataFeedVolume)
  #define GDataFeedWorksheet                   _GDATA_NS_SYMBOL(GDataFeedWorksheet)
  #define GDataFeedYouTubeComment              _GDATA_NS_SYMBOL(GDataFeedYouTubeComment)
  #define GDataFeedYouTubeComplaint            _GDATA_NS_SYMBOL(GDataFeedYouTubeComplaint)
  #define GDataFeedYouTubeFavorite             _GDATA_NS_SYMBOL(GDataFeedYouTubeFavorite)
  #define GDataFeedYouTubeFriend               _GDATA_NS_SYMBOL(GDataFeedYouTubeFriend)
  #define GDataFeedYouTubePlaylist             _GDATA_NS_SYMBOL(GDataFeedYouTubePlaylist)
  #define GDataFeedYouTubePlaylistLink         _GDATA_NS_SYMBOL(GDataFeedYouTubePlaylistLink)
  #define GDataFeedYouTubeRating               _GDATA_NS_SYMBOL(GDataFeedYouTubeRating)
  #define GDataFeedYouTubeSubscription         _GDATA_NS_SYMBOL(GDataFeedYouTubeSubscription)
  #define GDataFeedYouTubeUserProfile          _GDATA_NS_SYMBOL(GDataFeedYouTubeUserProfile)
  #define GDataFeedYouTubeVideo                _GDATA_NS_SYMBOL(GDataFeedYouTubeVideo)
  #define GDataFeedYouTubeVideoMessage         _GDATA_NS_SYMBOL(GDataFeedYouTubeVideoMessage)
  #define GDataFinanceSymbol                   _GDATA_NS_SYMBOL(GDataFinanceSymbol)
  #define GDataFinanceTransactionData          _GDATA_NS_SYMBOL(GDataFinanceTransactionData)
  #define GDataGain                            _GDATA_NS_SYMBOL(GDataGain)
  #define GDataGatherInputStream               _GDATA_NS_SYMBOL(GDataGatherInputStream)
  #define GDataGenerator                       _GDATA_NS_SYMBOL(GDataGenerator)
  #define GDataGeo                             _GDATA_NS_SYMBOL(GDataGeo)
  #define GDataGeoPt                           _GDATA_NS_SYMBOL(GDataGeoPt)
  #define GDataGeoRSSPoint                     _GDATA_NS_SYMBOL(GDataGeoRSSPoint)
  #define GDataGeoRSSWhere                     _GDATA_NS_SYMBOL(GDataGeoRSSWhere)
  #define GDataGeoW3CPoint                     _GDATA_NS_SYMBOL(GDataGeoW3CPoint)
  #define GDataGoogleBaseAttribute             _GDATA_NS_SYMBOL(GDataGoogleBaseAttribute)
  #define GDataGoogleBaseMetadataAttribute     _GDATA_NS_SYMBOL(GDataGoogleBaseMetadataAttribute)
  #define GDataGoogleBaseMetadataAttributeList _GDATA_NS_SYMBOL(GDataGoogleBaseMetadataAttributeList)
  #define GDataGoogleBaseMetadataItemType      _GDATA_NS_SYMBOL(GDataGoogleBaseMetadataItemType)
  #define GDataGoogleBaseMetadataValue         _GDATA_NS_SYMBOL(GDataGoogleBaseMetadataValue)
  #define GDataGroupMembershipInfo             _GDATA_NS_SYMBOL(GDataGroupMembershipInfo)
  #define GDataHiddenProperty                  _GDATA_NS_SYMBOL(GDataHiddenProperty)
  #define GDataHTTPFetcher                     _GDATA_NS_SYMBOL(GDataHTTPFetcher)
  #define GDataICalUIDProperty                 _GDATA_NS_SYMBOL(GDataICalUIDProperty)
  #define GDataIM                              _GDATA_NS_SYMBOL(GDataIM)
  #define GDataImplicitValueConstruct          _GDATA_NS_SYMBOL(GDataImplicitValueConstruct)
  #define GDataInputStreamLogger               _GDATA_NS_SYMBOL(GDataInputStreamLogger)
  #define GDataLink                            _GDATA_NS_SYMBOL(GDataLink)
  #define GDataMarketValue                     _GDATA_NS_SYMBOL(GDataMarketValue)
  #define GDataMediaCategory                   _GDATA_NS_SYMBOL(GDataMediaCategory)
  #define GDataMediaContent                    _GDATA_NS_SYMBOL(GDataMediaContent)
  #define GDataMediaCredit                     _GDATA_NS_SYMBOL(GDataMediaCredit)
  #define GDataMediaDescription                _GDATA_NS_SYMBOL(GDataMediaDescription)
  #define GDataMediaGroup                      _GDATA_NS_SYMBOL(GDataMediaGroup)
  #define GDataMediaKeywords                   _GDATA_NS_SYMBOL(GDataMediaKeywords)
  #define GDataMediaPlayer                     _GDATA_NS_SYMBOL(GDataMediaPlayer)
  #define GDataMediaRating                     _GDATA_NS_SYMBOL(GDataMediaRating)
  #define GDataMediaRestriction                _GDATA_NS_SYMBOL(GDataMediaRestriction)
  #define GDataMediaThumbnail                  _GDATA_NS_SYMBOL(GDataMediaThumbnail)
  #define GDataMediaTitle                      _GDATA_NS_SYMBOL(GDataMediaTitle)
  #define GDataMIMEDocument                    _GDATA_NS_SYMBOL(GDataMIMEDocument)
  #define GDataMIMEPart                        _GDATA_NS_SYMBOL(GDataMIMEPart)
  #define GDataMoney                           _GDATA_NS_SYMBOL(GDataMoney)
  #define GDataMoneyElementBase                _GDATA_NS_SYMBOL(GDataMoneyElementBase)
  #define GDataNormalPlayTime                  _GDATA_NS_SYMBOL(GDataNormalPlayTime)
  #define GDataObject                          _GDATA_NS_SYMBOL(GDataObject)
  #define GDataOpenSearchItemsPerPage1_0       _GDATA_NS_SYMBOL(GDataOpenSearchItemsPerPage1_0)
  #define GDataOpenSearchItemsPerPage1_1       _GDATA_NS_SYMBOL(GDataOpenSearchItemsPerPage1_1)
  #define GDataOpenSearchStartIndex1_0         _GDATA_NS_SYMBOL(GDataOpenSearchStartIndex1_0)
  #define GDataOpenSearchStartIndex1_1         _GDATA_NS_SYMBOL(GDataOpenSearchStartIndex1_1)
  #define GDataOpenSearchTotalResults1_0       _GDATA_NS_SYMBOL(GDataOpenSearchTotalResults1_0)
  #define GDataOpenSearchTotalResults1_1       _GDATA_NS_SYMBOL(GDataOpenSearchTotalResults1_1)
  #define GDataOrganization                    _GDATA_NS_SYMBOL(GDataOrganization)
  #define GDataOrgName                         _GDATA_NS_SYMBOL(GDataOrgName)
  #define GDataOrgTitle                        _GDATA_NS_SYMBOL(GDataOrgTitle)
  #define GDataOriginalEvent                   _GDATA_NS_SYMBOL(GDataOriginalEvent)
  #define GDataOverrideNameProperty            _GDATA_NS_SYMBOL(GDataOverrideNameProperty)
  #define GDataPerson                          _GDATA_NS_SYMBOL(GDataPerson)
  #define GDataPersonEmail                     _GDATA_NS_SYMBOL(GDataPersonEmail)
  #define GDataPersonName                      _GDATA_NS_SYMBOL(GDataPersonName)
  #define GDataPersonURI                       _GDATA_NS_SYMBOL(GDataPersonURI)
  #define GDataPhoneNumber                     _GDATA_NS_SYMBOL(GDataPhoneNumber)
  #define GDataPhotoAccess                     _GDATA_NS_SYMBOL(GDataPhotoAccess)
  #define GDataPhotoAlbumID                    _GDATA_NS_SYMBOL(GDataPhotoAlbumID)
  #define GDataPhotoBytesUsed                  _GDATA_NS_SYMBOL(GDataPhotoBytesUsed)
  #define GDataPhotoChecksum                   _GDATA_NS_SYMBOL(GDataPhotoChecksum)
  #define GDataPhotoClient                     _GDATA_NS_SYMBOL(GDataPhotoClient)
  #define GDataPhotoCommentCount               _GDATA_NS_SYMBOL(GDataPhotoCommentCount)
  #define GDataPhotoCommentingEnabled          _GDATA_NS_SYMBOL(GDataPhotoCommentingEnabled)
  #define GDataPhotoGPhotoID                   _GDATA_NS_SYMBOL(GDataPhotoGPhotoID)
  #define GDataPhotoHeight                     _GDATA_NS_SYMBOL(GDataPhotoHeight)
  #define GDataPhotoLocation                   _GDATA_NS_SYMBOL(GDataPhotoLocation)
  #define GDataPhotoMaxPhotosPerAlbum          _GDATA_NS_SYMBOL(GDataPhotoMaxPhotosPerAlbum)
  #define GDataPhotoName                       _GDATA_NS_SYMBOL(GDataPhotoName)
  #define GDataPhotoNickname                   _GDATA_NS_SYMBOL(GDataPhotoNickname)
  #define GDataPhotoNumberLeft                 _GDATA_NS_SYMBOL(GDataPhotoNumberLeft)
  #define GDataPhotoNumberUsed                 _GDATA_NS_SYMBOL(GDataPhotoNumberUsed)
  #define GDataPhotoPhotoID                    _GDATA_NS_SYMBOL(GDataPhotoPhotoID)
  #define GDataPhotoPosition                   _GDATA_NS_SYMBOL(GDataPhotoPosition)
  #define GDataPhotoQuotaLimit                 _GDATA_NS_SYMBOL(GDataPhotoQuotaLimit)
  #define GDataPhotoQuotaUsed                  _GDATA_NS_SYMBOL(GDataPhotoQuotaUsed)
  #define GDataPhotoRotation                   _GDATA_NS_SYMBOL(GDataPhotoRotation)
  #define GDataPhotoSize                       _GDATA_NS_SYMBOL(GDataPhotoSize)
  #define GDataPhotoThumbnail                  _GDATA_NS_SYMBOL(GDataPhotoThumbnail)
  #define GDataPhotoTimestamp                  _GDATA_NS_SYMBOL(GDataPhotoTimestamp)
  #define GDataPhotoUser                       _GDATA_NS_SYMBOL(GDataPhotoUser)
  #define GDataPhotoVersion                    _GDATA_NS_SYMBOL(GDataPhotoVersion)
  #define GDataPhotoVideoStatus                _GDATA_NS_SYMBOL(GDataPhotoVideoStatus)
  #define GDataPhotoWeight                     _GDATA_NS_SYMBOL(GDataPhotoWeight)
  #define GDataPhotoWidth                      _GDATA_NS_SYMBOL(GDataPhotoWidth)
  #define GDataPortfolioBase                   _GDATA_NS_SYMBOL(GDataPortfolioBase)
  #define GDataPortfolioData                   _GDATA_NS_SYMBOL(GDataPortfolioData)
  #define GDataPositionData                    _GDATA_NS_SYMBOL(GDataPositionData)
  #define GDataPostalAddress                   _GDATA_NS_SYMBOL(GDataPostalAddress)
  #define GDataPrice                           _GDATA_NS_SYMBOL(GDataPrice)
  #define GDataPrivateCopyProperty             _GDATA_NS_SYMBOL(GDataPrivateCopyProperty)
  #define GDataProgressMonitorInputStream      _GDATA_NS_SYMBOL(GDataProgressMonitorInputStream)
  #define GDataQuery                           _GDATA_NS_SYMBOL(GDataQuery)
  #define GDataQueryBooks                      _GDATA_NS_SYMBOL(GDataQueryBooks)
  #define GDataQueryCalendar                   _GDATA_NS_SYMBOL(GDataQueryCalendar)
  #define GDataQueryContact                    _GDATA_NS_SYMBOL(GDataQueryContact)
  #define GDataQueryDocs                       _GDATA_NS_SYMBOL(GDataQueryDocs)
  #define GDataQueryFinance                    _GDATA_NS_SYMBOL(GDataQueryFinance)
  #define GDataQueryGoogleBase                 _GDATA_NS_SYMBOL(GDataQueryGoogleBase)
  #define GDataQueryGooglePhotos               _GDATA_NS_SYMBOL(GDataQueryGooglePhotos)
  #define GDataQuerySpreadsheet                _GDATA_NS_SYMBOL(GDataQuerySpreadsheet)
  #define GDataQueryYouTube                    _GDATA_NS_SYMBOL(GDataQueryYouTube)
  #define GDataQuickAddProperty                _GDATA_NS_SYMBOL(GDataQuickAddProperty)
  #define GDataRating                          _GDATA_NS_SYMBOL(GDataRating)
  #define GDataRecurrence                      _GDATA_NS_SYMBOL(GDataRecurrence)
  #define GDataRecurrenceException             _GDATA_NS_SYMBOL(GDataRecurrenceException)
  #define GDataReminder                        _GDATA_NS_SYMBOL(GDataReminder)
  #define GDataResourceID                      _GDATA_NS_SYMBOL(GDataResourceID)
  #define GDataResourceProperty                _GDATA_NS_SYMBOL(GDataResourceProperty)
  #define GDataRowColumnCount                  _GDATA_NS_SYMBOL(GDataRowColumnCount)
  #define GDataRowCount                        _GDATA_NS_SYMBOL(GDataRowCount)
  #define GDataSelectedProperty                _GDATA_NS_SYMBOL(GDataSelectedProperty)
  #define GDataSendEventNotifications          _GDATA_NS_SYMBOL(GDataSendEventNotifications)
  #define GDataSequenceProperty                _GDATA_NS_SYMBOL(GDataSequenceProperty)
  #define GDataServerError                     _GDATA_NS_SYMBOL(GDataServerError)
  #define GDataServerErrorGroup                _GDATA_NS_SYMBOL(GDataServerErrorGroup)
  #define GDataServiceBase                     _GDATA_NS_SYMBOL(GDataServiceBase)
  #define GDataServiceGoogle                   _GDATA_NS_SYMBOL(GDataServiceGoogle)
  #define GDataServiceGoogleBase               _GDATA_NS_SYMBOL(GDataServiceGoogleBase)
  #define GDataServiceGoogleBooks              _GDATA_NS_SYMBOL(GDataServiceGoogleBooks)
  #define GDataServiceGoogleCalendar           _GDATA_NS_SYMBOL(GDataServiceGoogleCalendar)
  #define GDataServiceGoogleContact            _GDATA_NS_SYMBOL(GDataServiceGoogleContact)
  #define GDataServiceGoogleDocs               _GDATA_NS_SYMBOL(GDataServiceGoogleDocs)
  #define GDataServiceGoogleFinance            _GDATA_NS_SYMBOL(GDataServiceGoogleFinance)
  #define GDataServiceGooglePhotos             _GDATA_NS_SYMBOL(GDataServiceGooglePhotos)
  #define GDataServiceGoogleSpreadsheet        _GDATA_NS_SYMBOL(GDataServiceGoogleSpreadsheet)
  #define GDataServiceGoogleWebmasterTools     _GDATA_NS_SYMBOL(GDataServiceGoogleWebmasterTools)
  #define GDataServiceGoogleYouTube            _GDATA_NS_SYMBOL(GDataServiceGoogleYouTube)
  #define GDataServiceTicket                   _GDATA_NS_SYMBOL(GDataServiceTicket)
  #define GDataServiceTicketBase               _GDATA_NS_SYMBOL(GDataServiceTicketBase)
  #define GDataSiteCrawledDate                 _GDATA_NS_SYMBOL(GDataSiteCrawledDate)
  #define GDataSiteIndexed                     _GDATA_NS_SYMBOL(GDataSiteIndexed)
  #define GDataSitemapLastDownloaded           _GDATA_NS_SYMBOL(GDataSitemapLastDownloaded)
  #define GDataSitemapMarkupLanguage           _GDATA_NS_SYMBOL(GDataSitemapMarkupLanguage)
  #define GDataSitemapMobile                   _GDATA_NS_SYMBOL(GDataSitemapMobile)
  #define GDataSitemapMobileMarkupLanguage     _GDATA_NS_SYMBOL(GDataSitemapMobileMarkupLanguage)
  #define GDataSitemapNews                     _GDATA_NS_SYMBOL(GDataSitemapNews)
  #define GDataSitemapNewsPublicationLabel     _GDATA_NS_SYMBOL(GDataSitemapNewsPublicationLabel)
  #define GDataSitemapPublicationLabel         _GDATA_NS_SYMBOL(GDataSitemapPublicationLabel)
  #define GDataSitemapStatus                   _GDATA_NS_SYMBOL(GDataSitemapStatus)
  #define GDataSitemapType                     _GDATA_NS_SYMBOL(GDataSitemapType)
  #define GDataSitemapURLCount                 _GDATA_NS_SYMBOL(GDataSitemapURLCount)
  #define GDataSiteVerificationMethod          _GDATA_NS_SYMBOL(GDataSiteVerificationMethod)
  #define GDataSiteVerified                    _GDATA_NS_SYMBOL(GDataSiteVerified)
  #define GDataSpreadsheetCell                 _GDATA_NS_SYMBOL(GDataSpreadsheetCell)
  #define GDataSpreadsheetCustomElement        _GDATA_NS_SYMBOL(GDataSpreadsheetCustomElement)
  #define GDataSyncEventProperty               _GDATA_NS_SYMBOL(GDataSyncEventProperty)
  #define GDataTextConstruct                   _GDATA_NS_SYMBOL(GDataTextConstruct)
  #define GDataTimesCleanedProperty            _GDATA_NS_SYMBOL(GDataTimesCleanedProperty)
  #define GDataTimeZoneProperty                _GDATA_NS_SYMBOL(GDataTimeZoneProperty)
  #define GDataTransparency                    _GDATA_NS_SYMBOL(GDataTransparency)
  #define GDataUtilities                       _GDATA_NS_SYMBOL(GDataUtilities)
  #define GDataValueConstruct                  _GDATA_NS_SYMBOL(GDataValueConstruct)
  #define GDataValueElementConstruct           _GDATA_NS_SYMBOL(GDataValueElementConstruct)
  #define GDataVisibility                      _GDATA_NS_SYMBOL(GDataVisibility)
  #define GDataVolumeEmbeddability             _GDATA_NS_SYMBOL(GDataVolumeEmbeddability)
  #define GDataVolumeOpenAccess                _GDATA_NS_SYMBOL(GDataVolumeOpenAccess)
  #define GDataVolumeReview                    _GDATA_NS_SYMBOL(GDataVolumeReview)
  #define GDataVolumeViewability               _GDATA_NS_SYMBOL(GDataVolumeViewability)
  #define GDataWebContent                      _GDATA_NS_SYMBOL(GDataWebContent)
  #define GDataWebContentGadgetPref            _GDATA_NS_SYMBOL(GDataWebContentGadgetPref)
  #define GDataWhen                            _GDATA_NS_SYMBOL(GDataWhen)
  #define GDataWhere                           _GDATA_NS_SYMBOL(GDataWhere)
  #define GDataWho                             _GDATA_NS_SYMBOL(GDataWho)
  #define GDataYouTubeAboutMe                  _GDATA_NS_SYMBOL(GDataYouTubeAboutMe)
  #define GDataYouTubeAge                      _GDATA_NS_SYMBOL(GDataYouTubeAge)
  #define GDataYouTubeBooks                    _GDATA_NS_SYMBOL(GDataYouTubeBooks)
  #define GDataYouTubeCommentRating            _GDATA_NS_SYMBOL(GDataYouTubeCommentRating)
  #define GDataYouTubeCompany                  _GDATA_NS_SYMBOL(GDataYouTubeCompany)
  #define GDataYouTubeCountHint                _GDATA_NS_SYMBOL(GDataYouTubeCountHint)
  #define GDataYouTubeCountryAttribute         _GDATA_NS_SYMBOL(GDataYouTubeCountryAttribute)
  #define GDataYouTubeDescription              _GDATA_NS_SYMBOL(GDataYouTubeDescription)
  #define GDataYouTubeDuration                 _GDATA_NS_SYMBOL(GDataYouTubeDuration)
  #define GDataYouTubeFirstName                _GDATA_NS_SYMBOL(GDataYouTubeFirstName)
  #define GDataYouTubeFormatAttribute          _GDATA_NS_SYMBOL(GDataYouTubeFormatAttribute)
  #define GDataYouTubeGender                   _GDATA_NS_SYMBOL(GDataYouTubeGender)
  #define GDataYouTubeHobbies                  _GDATA_NS_SYMBOL(GDataYouTubeHobbies)
  #define GDataYouTubeHometown                 _GDATA_NS_SYMBOL(GDataYouTubeHometown)
  #define GDataYouTubeLastName                 _GDATA_NS_SYMBOL(GDataYouTubeLastName)
  #define GDataYouTubeLocation                 _GDATA_NS_SYMBOL(GDataYouTubeLocation)
  #define GDataYouTubeMediaGroup               _GDATA_NS_SYMBOL(GDataYouTubeMediaGroup)
  #define GDataYouTubeMovies                   _GDATA_NS_SYMBOL(GDataYouTubeMovies)
  #define GDataYouTubeMusic                    _GDATA_NS_SYMBOL(GDataYouTubeMusic)
  #define GDataYouTubeNonEmbeddable            _GDATA_NS_SYMBOL(GDataYouTubeNonEmbeddable)
  #define GDataYouTubeOccupation               _GDATA_NS_SYMBOL(GDataYouTubeOccupation)
  #define GDataYouTubePlaylistID               _GDATA_NS_SYMBOL(GDataYouTubePlaylistID)
  #define GDataYouTubePlaylistTitle            _GDATA_NS_SYMBOL(GDataYouTubePlaylistTitle)
  #define GDataYouTubePosition                 _GDATA_NS_SYMBOL(GDataYouTubePosition)
  #define GDataYouTubePrivate                  _GDATA_NS_SYMBOL(GDataYouTubePrivate)
  #define GDataYouTubePublicationState         _GDATA_NS_SYMBOL(GDataYouTubePublicationState)
  #define GDataYouTubeQueryString              _GDATA_NS_SYMBOL(GDataYouTubeQueryString)
  #define GDataYouTubeRacy                     _GDATA_NS_SYMBOL(GDataYouTubeRacy)
  #define GDataYouTubeRecordedDate             _GDATA_NS_SYMBOL(GDataYouTubeRecordedDate)
  #define GDataYouTubeRelationship             _GDATA_NS_SYMBOL(GDataYouTubeRelationship)
  #define GDataYouTubeSchool                   _GDATA_NS_SYMBOL(GDataYouTubeSchool)
  #define GDataYouTubeSpamHint                 _GDATA_NS_SYMBOL(GDataYouTubeSpamHint)
  #define GDataYouTubeStatistics               _GDATA_NS_SYMBOL(GDataYouTubeStatistics)
  #define GDataYouTubeStatus                   _GDATA_NS_SYMBOL(GDataYouTubeStatus)
  #define GDataYouTubeToken                    _GDATA_NS_SYMBOL(GDataYouTubeToken)
  #define GDataYouTubeTypeAttribute            _GDATA_NS_SYMBOL(GDataYouTubeTypeAttribute)
  #define GDataYouTubeUploadedDate             _GDATA_NS_SYMBOL(GDataYouTubeUploadedDate)
  #define GDataYouTubeUsername                 _GDATA_NS_SYMBOL(GDataYouTubeUsername)
  #define GDataYouTubeVideoID                  _GDATA_NS_SYMBOL(GDataYouTubeVideoID)

#endif
