//
//  MacroApp
//
//  Created by Helge Heß.
//  Copyright © 2020 ZeeZide GmbH. All rights reserved.
//

import protocol MacroExpress.RouteKeeper
import class    MacroExpress.Route

/**
 * Mount creates an own, nested, Express application object.
 *
 * Example:
 *
 *     MyApp: App {
 *        var body: some Endpoints {
 *            Mount("/admin") {  // create a new Express object
 *               Get("/users") { // this will match `/admin/users`
 *                 ...
 *               }
 *            }
 *        }
 *     }
 *
 * There is also `Mount` which creates a full, nested `Express` application
 * object.
 */
public struct Route<Content: Endpoints>: Endpoints {
  
  public let id          : String?
  public let pathPattern : String?
  public let content     : Content
  
  @inlinable
  public init(id: String? = nil, _ pathPattern: String? = nil,
              @EndpointsBuilder content: () -> Content)
  {
    self.id          = id
    self.pathPattern = pathPattern
    self.content     = content()
  }
  
  public func attachToRouter(_ router: RouteKeeper) throws {
    let app = MacroExpress.Route(id: id, pattern: pathPattern)
    try content.attachToRouter(app)
    router.use(app)
  }
}
