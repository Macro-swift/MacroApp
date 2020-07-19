//
//  MacroApp
//
//  Created by Helge Heß.
//  Copyright © 2020 ZeeZide GmbH. All rights reserved.
//

import protocol MacroExpress.RouteKeeper
import class    MacroExpress.Route

/**
 * `Route` creates a nested set of routes.
 *
 * Example:
 *
 *     MyApp: App {
 *         var body: some Endpoints {
 *             Route("/admin") {
 *                 Get("/users") { // this will match `/admin/users`
 *                     ...
 *                 }
 *             }
 *         }
 *     }
 *
 * There is also `Mount` which creates a full, nested `Express` application
 * object.
 *
 * ## Path Patterns
 *
 * The Route accepts a pattern for the path:
 * - the "*" string is considered a match-all.
 * - otherwise the string is split into path components (on '/')
 * - if it starts with a "/", the pattern will start with a Root symbol
 * - "*" (like in `/users/ * / view`) matches any component (spaces added)
 * - if the component starts with `:`, it is considered a variable.
 *   Example: `/users/:id/view`
 * - "text*", "*text*", "*text" creates hasPrefix/hasSuffix/contains patterns
 * - otherwise the text is matched AS IS
 *
 * Variables can be extracted using:
 *
 *     req.params[int: "id"]
 *
 * and companions.
 */
public struct Route<Content: Endpoints>: Endpoints {
  
  public let id          : String?
  public let pathPattern : String?
  public let content     : Content
  
  /**
   * Initialize a Route Endpoint, a way to attach an App to another App.
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
   * - Parameter pathPattern: A `Route` path pattern (documented in the struct)
   * - Parameter content: Closure which builds `Endpoints` to be added.
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
    let app = MacroExpress.Route(id: id, pattern: pathPattern)
    try content.attachToRouter(app)
    router.use(app)
  }
}
