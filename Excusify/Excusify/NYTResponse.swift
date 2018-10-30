//
//  NYTResponse.swift
//  Excusify
//
//  Created by Evan Teters on 10/29/18.
//  Copyright © 2018 Evan Teters. All rights reserved.
//

import Foundation
//This is many things!
struct NYTStatusResponse:Decodable {
    var status:String
    var copyright:String
    var response:NYTResponse
}
struct NYTResponse:Decodable {
    var docs:[NYTDocument]
}
struct NYTDocument:Decodable {
    var web_url:String
    var snippet: String
    var abstract: String?
    var headline: NYTHeadline
}
struct NYTHeadline:Decodable {
    var main: String
}
