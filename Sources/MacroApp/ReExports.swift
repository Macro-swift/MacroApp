//
//  MacroApp
//
//  Created by Helge Heß.
//  Copyright © 2020 ZeeZide GmbH. All rights reserved.
//

@_exported import func      MacroCore.nextTick
@_exported import func      MacroCore.setTimeout
@_exported import enum      MacroCore.console
@_exported import enum      MacroCore.process
@_exported import func      MacroCore.concat
@_exported import enum      MacroCore.json
@_exported import struct    MacroCore.Buffer
@_exported import enum      MacroCore.ReadableError
@_exported import enum      MacroCore.WritableError

@_exported import enum      dotenv.dotenv

@_exported import class     http.IncomingMessage
@_exported import class     http.OutgoingMessage
@_exported import class     http.ServerResponse

@_exported import enum      mime.mime
@_exported import func      connect.connect
@_exported import typealias connect.Middleware
@_exported import typealias connect.Next
@_exported import func      connect.cookieParser
@_exported import let       connect.cookies
@_exported import func      connect.cors
@_exported import func      connect.logger
@_exported import func      connect.methodOverride
@_exported import func      connect.pause
@_exported import enum      connect.qs
@_exported import func      connect.serveStatic
@_exported import func      connect.session
@_exported import func      connect.typeIs

@_exported import class     express.Express
@_exported import typealias express.ExpressEngine
@_exported import protocol  express.RouteKeeper

// We need to import those fully, because they contain query a few extensions,
// which we can't import selectively :-/
@_exported import MacroCore
@_exported import connect
@_exported import express

// MARK: - Submodules in `fs` Target

import enum      fs.FileSystemModule
import enum      fs.PathModule
import enum      fs.JSONFileModule
public typealias fs          = FileSystemModule
public typealias path        = PathModule
public typealias jsonfile    = JSONFileModule

// MARK: - Submodules in `http` Target

import enum      http.HTTPModule
import enum      http.BasicAuthModule
import enum      http.QueryStringModule
public typealias http        = HTTPModule
public typealias basicAuth   = BasicAuthModule
public typealias querystring = QueryStringModule

// MARK: - Process stuff

public var argv : [ String ]          { return process.argv }
public var env  : [ String : String ] { return process.env  }