//
//  MacroApp
//
//  Created by Helge Heß.
//  Copyright © 2020 ZeeZide GmbH. All rights reserved.
//

import enum NIOHTTP1.HTTPMethod

/**
 * Lookup a template with the given name, locate the rendering engine for it,
 * and render it with the options that are passed in.
 *
 * If no method is explicitly given, this is only active for GET, POST and HEAD.
 * Other methods will received a 405.
 *
 * Example:
 *
 *     MyApp: App {
 *         var body: some Endpoints {
 *             Render("/", template: "index")
 *         }
 *     }
 *
 * Assuming your 'views' directory contains an `index.mustache` file, this
 * would trigger the Mustache engine to render the template with the given
 * dictionary as input.
 *
 * When no options are passed in, render will fallback to the `view options`
 * setting in the application (TODO: merge the two contexts).
 */
public func Render(id            : String?     = nil,
                   _ pathPattern : String?     = nil,
                   method        : HTTPMethod? = nil,
                   template      : String,
                   options       : Any? = nil)
            -> Use
{
  return Use(id: id, pathPattern, method: method) {
    req, res, next in
    
    if method == nil {
      switch method {
        case .GET, .POST, .HEAD : break
        default                 : return res.sendStatus(405)
      }
    }
    
    res.render(template, options)
  }
}
