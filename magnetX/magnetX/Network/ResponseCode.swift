//
//  ResponseCode.swift
//  magnetX
//
//  Created by hsuyelin on 2018/5/25.
//  Copyright © 2018年 hsuyelin. All rights reserved.
//

import Foundation

public let RESPONSE_SUCCESS        = "200"
public let ITEM_UPDATE_SUCCESS     = "201"

public let VALIDATION_FAILED       = "400"
public let AUTH_FAILED             = "401"
public let DUPLICATE_ENTRY         = "403"
public let INVALID_ID              = "404"
public let INVALID_FORMAT          = "405"
public let INVALID_ACCEPT_HEADER   = "406"
public let INVALID_PARAMETERS      = "422"
public let REQUEST_OVER40LIMIT     = "429"

public let RESPONSE_FAILED         = "500"
public let INVALID_SERVICE         = "501"
public let SERVICE_OFFLINE         = "503"
public let REQUEST_TIMEOUT         = "504"
