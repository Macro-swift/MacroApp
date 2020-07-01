//
//  MacroApp
//
//  Created by Helge Heß.
//  Copyright © 2020 ZeeZide GmbH. All rights reserved.
//

/**
 * The function builder to trigger building of `Endpoint` elements.
 */
@_functionBuilder public struct EndpointsBuilder {}

public extension EndpointsBuilder {

  @inlinable
  static func buildBlock() -> Empty {
    return Empty()
  }

  @inlinable
  static func buildBlock<V: Endpoints>(_ content: V) -> V {
    return content
  }

  @inlinable
  static func buildIf<V: Endpoints>(_ content: V)  -> V  { return content }
  @inlinable
  static func buildIf<V: Endpoints>(_ content: V?) -> V? { return content }

  @inlinable
  static func buildEither<T: Endpoints, F: Endpoints>(first: T) -> IfElse<T, F>
  {
    return IfElse(first: first)
  }
  @inlinable
  static func buildEither<T: Endpoints, F: Endpoints>(second: F) -> IfElse<T, F>
  {
    return IfElse(second: second)
  }
}

public extension EndpointsBuilder { // Tuples
  
  @inlinable
  static func buildBlock<C0: Endpoints, C1: Endpoints>(_ c0: C0, _ c1: C1)
              -> Tuple2<C0, C1>
  {
    return Tuple2(c0, c1)
  }
  @inlinable
  static func buildBlock<C0: Endpoints, C1: Endpoints, C2: Endpoints>
                (_ c0: C0, _ c1: C1, _ c2: C2) -> Tuple3<C0, C1, C2>
  {
    return Tuple3(c0, c1, c2)
  }
  @inlinable
  static func buildBlock<C0: Endpoints, C1: Endpoints, C2: Endpoints, C3: Endpoints>
                (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3)
                -> Tuple4<C0, C1, C2, C3>
  {
    return Tuple4(c0, c1, c2, c3)
  }
  @inlinable
  static func buildBlock<C0: Endpoints, C1: Endpoints, C2: Endpoints, C3: Endpoints,
                         C4: Endpoints>
                (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4)
                -> Tuple5<C0, C1, C2, C3, C4>
  {
    return Tuple5(c0, c1, c2, c3, c4)
  }
  @inlinable
  static func buildBlock<C0: Endpoints, C1: Endpoints, C2: Endpoints, C3: Endpoints,
                         C4: Endpoints, C5: Endpoints>
                (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4, _ c5: C5)
                -> Tuple6<C0, C1, C2, C3, C4, C5>
  {
    return Tuple6(c0, c1, c2, c3, c4, c5)
  }
  @inlinable
  static func buildBlock<C0: Endpoints, C1: Endpoints, C2: Endpoints, C3: Endpoints,
                         C4: Endpoints, C5: Endpoints, C6: Endpoints>
                (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4,
                 _ c5: C5, _ c6: C6)
                -> Tuple7<C0, C1, C2, C3, C4, C5, C6>
  {
    return Tuple7(c0, c1, c2, c3, c4, c5, c6)
  }
  @inlinable
  static func buildBlock<C0: Endpoints, C1: Endpoints, C2: Endpoints, C3: Endpoints,
                         C4: Endpoints, C5: Endpoints, C6: Endpoints, C7: Endpoints>
                (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4,
                 _ c5: C5, _ c6: C6, _ c7: C7 )
                -> Tuple8<C0, C1, C2, C3, C4, C5, C6, C7>
  {
    return Tuple8(c0, c1, c2, c3, c4, c5, c6, c7)
  }
  @inlinable
  static func buildBlock<C0: Endpoints, C1: Endpoints, C2: Endpoints, C3: Endpoints,
                         C4: Endpoints, C5: Endpoints, C6: Endpoints, C7: Endpoints,
                         C8: Endpoints>
                (_ c0: C0, _ c1: C1, _ c2: C2, _ c3: C3, _ c4: C4,
                 _ c5: C5, _ c6: C6, _ c7: C7, _ c8: C8)
                -> Tuple9<C0, C1, C2, C3, C4, C5, C6, C7, C8>
  {
    return Tuple9(c0, c1, c2, c3, c4, c5, c6, c7, c8)
  }
}

// MARK: - Empty

extension EndpointsBuilder {
  public struct Empty: Endpoints {
    public init() {}
  }
}

extension Optional: Endpoints where Wrapped : Endpoints {
}


// MARK: - Conditional

extension EndpointsBuilder {

  public struct IfElse<TrueContent, FalseContent> : Endpoints
           where TrueContent: Endpoints, FalseContent: Endpoints
  {
    public typealias Body = Never
    
    @usableFromInline
    enum Content {
      case first (TrueContent)
      case second(FalseContent)
    }
    @usableFromInline let content : Content
    
    @inlinable
    public init(first  : TrueContent)  { content = .first(first)   }
    @inlinable
    public init(second : FalseContent) { content = .second(second) }
  }
}

// MARK: - Tuple specialization

extension Group : Endpoints where Content : Endpoints {
  
  public typealias Body = Never
  
  @inlinable
  public init(@EndpointsBuilder _ content: () -> Content) {
    self.content = content()
  }
}

extension Tuple2: Endpoints where T1: Endpoints, T2: Endpoints {
  public typealias Body = Never
}
extension Tuple3: Endpoints where T1: Endpoints, T2: Endpoints, T3: Endpoints {
  public typealias Body = Never
}
extension Tuple4: Endpoints where T1: Endpoints, T2: Endpoints, T3: Endpoints,
                                  T4: Endpoints
{
  public typealias Body = Never
}
extension Tuple5: Endpoints where T1: Endpoints, T2: Endpoints, T3: Endpoints,
                                  T4: Endpoints, T5: Endpoints
{
  public typealias Body = Never
}
extension Tuple6: Endpoints where T1: Endpoints, T2: Endpoints, T3: Endpoints,
                                  T4: Endpoints, T5: Endpoints, T6: Endpoints
{
  public typealias Body = Never
}
extension Tuple7: Endpoints where T1: Endpoints, T2: Endpoints, T3: Endpoints,
                                  T4: Endpoints, T5: Endpoints, T6: Endpoints,
                                  T7: Endpoints
{
  public typealias Body = Never
}
extension Tuple8: Endpoints where T1: Endpoints, T2: Endpoints, T3: Endpoints,
                                  T4: Endpoints, T5: Endpoints, T6: Endpoints,
                                  T7: Endpoints, T8: Endpoints
{
  public typealias Body = Never
}
extension Tuple9: Endpoints where T1: Endpoints, T2: Endpoints, T3: Endpoints,
                                  T4: Endpoints, T5: Endpoints, T6: Endpoints,
                                  T7: Endpoints, T8: Endpoints, T9: Endpoints
{
  public typealias Body = Never
}
