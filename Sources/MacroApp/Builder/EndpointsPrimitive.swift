//
//  MacroApp
//
//  Created by Helge Heß.
//  Copyright © 2020 ZeeZide GmbH. All rights reserved.
//

import protocol MacroExpress.RouteKeeper

extension Never: Endpoints {
  struct AttemptToAttachNeverToRouter: Swift.Error {}
  public func attachToRouter(_ router: RouteKeeper) throws {
    throw AttemptToAttachNeverToRouter()
  }
}

extension EndpointsBuilder.Empty {
  public func attachToRouter(_ router: RouteKeeper) throws {}
}

extension EndpointsBuilder.IfElse {
  
  public func attachToRouter(_ router: RouteKeeper) throws {
    switch content {
      case .first (let endpoints): try endpoints.attachToRouter(router)
      case .second(let endpoints): try endpoints.attachToRouter(router)
    }
  }
}

extension Optional where Wrapped: Endpoints {
  
  public func attachToRouter(_ router: RouteKeeper) throws {
    switch self {
      case .some(let endpoints): try endpoints.attachToRouter(router)
      case .none: return
    }
  }
}

extension Group where Content: Endpoints{
  public func attachToRouter(_ router: RouteKeeper) throws {
    try content.attachToRouter(router)
  }
}


// Lots of boilerplate :-) Should be generated, but well, we only really do
// this once.

extension Tuple2 where T1: Endpoints, T2: Endpoints {
  public func attachToRouter(_ router: RouteKeeper) throws {
    try value1.attachToRouter(router)
    try value2.attachToRouter(router)
  }
}

extension Tuple3 where T1: Endpoints, T2: Endpoints, T3: Endpoints {
  public func attachToRouter(_ router: RouteKeeper) throws {
    try value1.attachToRouter(router)
    try value2.attachToRouter(router)
    try value3.attachToRouter(router)
  }
}

extension Tuple4 where T1: Endpoints, T2: Endpoints, T3: Endpoints,
                       T4: Endpoints
{
  public func attachToRouter(_ router: RouteKeeper) throws {
    try value1.attachToRouter(router)
    try value2.attachToRouter(router)
    try value3.attachToRouter(router)
    try value4.attachToRouter(router)
  }
}

extension Tuple5 where T1: Endpoints, T2: Endpoints, T3: Endpoints,
                       T4: Endpoints, T5: Endpoints
{
  public func attachToRouter(_ router: RouteKeeper) throws {
    try value1.attachToRouter(router)
    try value2.attachToRouter(router)
    try value3.attachToRouter(router)
    try value4.attachToRouter(router)
    try value5.attachToRouter(router)
  }
}

extension Tuple6 where T1: Endpoints, T2: Endpoints, T3: Endpoints,
                       T4: Endpoints, T5: Endpoints, T6: Endpoints
{
  public func attachToRouter(_ router: RouteKeeper) throws {
    try value1.attachToRouter(router)
    try value2.attachToRouter(router)
    try value3.attachToRouter(router)
    try value4.attachToRouter(router)
    try value5.attachToRouter(router)
    try value6.attachToRouter(router)
  }
}

extension Tuple7 where T1: Endpoints, T2: Endpoints, T3: Endpoints,
                       T4: Endpoints, T5: Endpoints, T6: Endpoints,
                       T7: Endpoints
{
  public func attachToRouter(_ router: RouteKeeper) throws {
    try value1.attachToRouter(router)
    try value2.attachToRouter(router)
    try value3.attachToRouter(router)
    try value4.attachToRouter(router)
    try value5.attachToRouter(router)
    try value6.attachToRouter(router)
    try value7.attachToRouter(router)
  }
}

extension Tuple8 where T1: Endpoints, T2: Endpoints, T3: Endpoints,
                       T4: Endpoints, T5: Endpoints, T6: Endpoints,
                       T7: Endpoints, T8: Endpoints
{
  public func attachToRouter(_ router: RouteKeeper) throws {
    try value1.attachToRouter(router)
    try value2.attachToRouter(router)
    try value3.attachToRouter(router)
    try value4.attachToRouter(router)
    try value5.attachToRouter(router)
    try value6.attachToRouter(router)
    try value7.attachToRouter(router)
    try value8.attachToRouter(router)
  }
}

extension Tuple9 where T1: Endpoints, T2: Endpoints, T3: Endpoints,
                       T4: Endpoints, T5: Endpoints, T6: Endpoints,
                       T7: Endpoints, T8: Endpoints, T9: Endpoints
{
  public func attachToRouter(_ router: RouteKeeper) throws {
    try value1.attachToRouter(router)
    try value2.attachToRouter(router)
    try value3.attachToRouter(router)
    try value4.attachToRouter(router)
    try value5.attachToRouter(router)
    try value6.attachToRouter(router)
    try value7.attachToRouter(router)
    try value8.attachToRouter(router)
    try value9.attachToRouter(router)
  }
}
