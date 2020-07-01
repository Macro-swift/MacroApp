//
//  MacroApp
//
//  Created by Helge Heß.
//  Copyright © 2020 ZeeZide GmbH. All rights reserved.
//

import MacroExpress

/**
 * An endpoint is just an object which can attach itself to a route.
 *
 * This is called `Endpoints` (plural), because there are usually groups of
 * endpoints, not just a single one.
 *
 * This package comes with Endpoints for the common Express function endpoints,
 * like: `Use`, `Get`, `Post`, or `Put`.
 * It also provides mounting via `Mount`.
 */
public protocol Endpoints {
  
  func attachToRouter(_ router: RouteKeeper) throws
}
