//
//  MacroApp
//
//  Created by Helge Heß.
//  Copyright © 2020 ZeeZide GmbH. All rights reserved.
//

import typealias MacroExpress.Middleware
import typealias MacroExpress.ErrorMiddleware
import protocol  MacroExpress.RouteKeeper

// All those just return a `Use` Endpoint preconfigured for the respective
// HTTP methods.
//
// Crazy, isn't it? :-)

public func All(id: String? = nil, _ pathPattern: String? = nil,
                _ middleware: Middleware...) -> Use
{
  return Use(id: id, pathPattern: pathPattern, method: nil,
             middleware: middleware, errorMiddleware: [])
}

public func Get(id: String? = nil, _ pathPattern: String? = nil,
                _ middleware: Middleware...) -> Use
{
  return Use(id: id, pathPattern: pathPattern, method: .GET,
             middleware: middleware, errorMiddleware: [])
}

public func Head(id: String? = nil, _ pathPattern: String? = nil,
                 _ middleware: Middleware...) -> Use
{
  return Use(id: id, pathPattern: pathPattern, method: .HEAD,
             middleware: middleware, errorMiddleware: [])
}

public func Put(id: String? = nil, _ pathPattern: String? = nil,
                _ middleware: Middleware...) -> Use
{
  return Use(id: id, pathPattern: pathPattern, method: .PUT,
             middleware: middleware, errorMiddleware: [])
}

public func Patch(id: String? = nil, _ pathPattern: String? = nil,
                  _ middleware: Middleware...) -> Use
{
  return Use(id: id, pathPattern: pathPattern, method: .PATCH,
             middleware: middleware, errorMiddleware: [])
}

public func Delete(id: String? = nil, _ pathPattern: String? = nil,
                   _ middleware: Middleware...) -> Use
{
  return Use(id: id, pathPattern: pathPattern, method: .DELETE,
             middleware: middleware, errorMiddleware: [])
}

public func Post(id: String? = nil, _ pathPattern: String? = nil,
                 _ middleware: Middleware...) -> Use
{
  return Use(id: id, pathPattern: pathPattern, method: .POST,
             middleware: middleware, errorMiddleware: [])
}
