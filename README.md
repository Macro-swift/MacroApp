<h2>MacroApp
  <img src="http://zeezide.com/img/macro/MacroExpressIcon128.png"
       align="right" width="100" height="100" />
</h2>

MacroApp layers on top of 
[MacroExpress](https://github.com/Macro-swift/MacroExpress/)
to provide a SwiftUI like, declarative setup of endpoints.

It is a little more opinionated than MacroExpress.

> [MacroExpress](https://github.com/Macro-swift/MacroExpress/)
> is a small, unopinionated "don't get into my way" / "I don't wanna `wait`" 
> asynchronous web framework for Swift.
> With a strong focus on replicating the Node APIs in Swift.
> But in a typesafe, and fast way.

MacroApp is just syntactic sugar (using Swift function builders) on top of
MacroExpress. The configuration is evaluated into a regular MacroExpress
based app (with routes and middleware).

## Example

MacroApp:

```swift
@main
struct HelloWorld: App {
  
  var body: some Endpoints {
    Use(logger("dev"), bodyParser.urlencoded())
          
    Route("/admin") {
      Get("/view") { req, res, _ in res.render("admin-index.html") }
      Render("help", template: "help")
    }
      
    Get { req, res, next in
      res.render("index.html")
    }
  }
}
```

Instead of this traditional route setup (as in [MacroExpress](https://github.com/Macro-swift/MacroExpress/)):

```swift
let app = express()

app.use(logger("dev"), bodyParser.urlencoded())

app.route("/admin")
   .get("/view") { req, res, _ in res.render("admin-index.html") }

app.get("/") { req, res, _ in res.render("index.html") }

app.listen(1337) {
    console.log("Server listening on http://localhost:1337")
}
```


## Environment Variables

- `macro.core.numthreads`
- `macro.core.iothreads`
- `macro.core.retain.debug`
- `macro.concat.maxsize`
- `macro.streams.debug.rc`
- `macro.router.debug`
- `macro.router.matcher.debug`

### Links

- [MacroExpress](https://github.com/Macro-swift/MacroExpress/)
- [Macro](https://github.com/Macro-swift/Macro/)
- [µExpress](http://www.alwaysrightinstitute.com/microexpress-nio2/)
- [Noze.io](http://noze.io)
- [SwiftNIO](https://github.com/apple/swift-nio)
- JavaScript Originals
  - [Connect](https://github.com/senchalabs/connect)
  - [Express.js](http://expressjs.com/en/starter/hello-world.html)
- Swift Apache
  - [mod_swift](http://mod-swift.org)
  - [ApacheExpress](http://apacheexpress.io)

### Who

**MacroExpress** is brought to you by
[Helge Heß](https://github.com/helje5/) / [ZeeZide](https://zeezide.de).
We like feedback, GitHub stars, cool contract work, 
presumably any form of praise you can think of.

There is a `#microexpress` channel on the 
[Noze.io Slack](http://slack.noze.io/). Feel free to join!
