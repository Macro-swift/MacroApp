import XCTest
import MacroTestUtilities
import typealias connect.Next
import class     http.IncomingMessage
import class     http.ServerResponse
@testable import MacroApp

final class MacroAppTests: XCTestCase {

  func testBasicAppSetup() throws {
    struct TestApp: App {
      var body: some Endpoints {
        Post("/hello") { req, res, next in
          res.send("Hello World!")
        }
      }
    }
    
    let app       = TestApp()
    let endpoints = app.body
    
    XCTAssert(endpoints is Use)
    guard let use = endpoints as? Use else { return }
    
    XCTAssertNil  (use.id)
    XCTAssertEqual(use.pathPattern, "/hello")
    XCTAssertEqual(use.method, .POST)
    XCTAssertTrue (use.errorMiddleware.isEmpty)
    XCTAssertEqual(use.middleware.count, 1)
        
    let req = IncomingMessage(
      .init(version: .init(major: 1, minor: 1), method: .POST, uri: "/hello"))
    let res = TestServerResponse()
    
    var didCallNext = false
    try app.handle(request: req, response: res) { ( args : Any... ) in
      XCTAssert(args.isEmpty)
      didCallNext = true
    }
    XCTAssertFalse(didCallNext)
    XCTAssertEqual(res.statusCode, 200)
    XCTAssertEqual(try res.writtenContent.toString(), "Hello World!")
  }
  
  func testMountAppSetup() throws {
    struct InnerApp: App {
      var body: some Endpoints {
        Post("/hello") { req, res, next in
          res.send("Hello World!")
        }
      }
    }
    
    struct OuterApp: App {
      var body: some Endpoints {
        Mount {
          InnerApp()
        }
      }
    }
    
    let outerApp  = OuterApp()
    let endpoints = outerApp.body
    
    XCTAssert(endpoints is Mount<InnerApp>)
    guard let mount = endpoints as? Mount<InnerApp> else { return }
    
    XCTAssertNil(mount.id)
    XCTAssertNil(mount.pathPattern)
    
    let innerApp = mount.content
    let innerEndpoints = innerApp.body
    
    XCTAssert(innerEndpoints is Use)
    guard let use = innerEndpoints as? Use else { return }
    
    XCTAssertNil  (use.id)
    XCTAssertEqual(use.pathPattern, "/hello")
    XCTAssertEqual(use.method, .POST)
    XCTAssertTrue (use.errorMiddleware.isEmpty)
    XCTAssertEqual(use.middleware.count, 1)

    let req = IncomingMessage(
      .init(version: .init(major: 1, minor: 1), method: .POST, uri: "/hello"))
    let res = TestServerResponse()
    
    var didCallNext = false
    try outerApp.handle(request: req, response: res) { ( args : Any... ) in
      XCTAssert(args.isEmpty)
      didCallNext = true
    }
    XCTAssertFalse(didCallNext)
    XCTAssertEqual(res.statusCode, 200)
    XCTAssertEqual(try res.writtenContent.toString(), "Hello World!")
  }

  static var allTests = [
    ( "testBasicAppSetup", testBasicAppSetup ),
    ( "testMountAppSetup", testMountAppSetup ),
  ]
}
