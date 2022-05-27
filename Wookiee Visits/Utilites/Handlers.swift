//
//  Handlers.swift
//  Wookiee Visits
//
//  Created by Uresha Lakshani on 2022-05-26.
//

import Foundation

public typealias CompletionHandler = (_ status: Bool, _ code: Int, _ message: String) -> ()
public typealias CompletionHandlerWithData = (_ status: Bool, _ code: Int, _ message: String, _ data: Any?) -> ()
