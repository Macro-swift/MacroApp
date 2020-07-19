//
//  MacroApp
//
//  Created by Helge Heß.
//  Copyright © 2020 ZeeZide GmbH. All rights reserved.
//

import protocol MacroExpress.RouteKeeper
import class    MacroExpress.Route
import class    MacroExpress.Express

/**
 * Mount creates an own, nested, `Express` application object.
 *
 * Example:
 *
 *     MyApp: App {
 *         var body: some Endpoints {
 *             Mount("/admin") {  // create a new Express object
 *                 Get("/users") { // this will match `/admin/users`
 *                     ...
 *                 }
 *             }
 *         }
 *     }
 *
 * There is also `Route`, which just creates a route w/o the extra stuff
 * an application provides.
 *
 * For path patterns, checkout the documentation of `Route`.
 */
public struct Mount<Content: Endpoints>: Endpoints {
  
  public let id          : String?
  public let pathPattern : String?
  public let content     : Content
  
  /**
   * Initialize a Mount, a way to attach an App to another App.
   *
   * Example:
   *
   *     Mount("/admin") {  // create a new Express object
   *         Get("/users") { // this will match `/admin/users`
   *             ...
   *         }
   *     }
   *
   * - Parameter id: The `Route` id for middleware debugging
   * - Parameter pathPattern: A `Route` path pattern (documented there)
   * - Parameter content: Closure which builds Endpoints to be mounted
   */
  @inlinable
  public init(id: String? = nil, _ pathPattern: String? = nil,
              @EndpointsBuilder content: () -> Content)
  {
    self.id          = id
    self.pathPattern = pathPattern
    self.content     = content()
  }
  
  public func attachToRouter(_ router: RouteKeeper) throws {
    let app = Express(id: id, mount: pathPattern)
    try content.attachToRouter(app)
    router.use(app)
  }
}
