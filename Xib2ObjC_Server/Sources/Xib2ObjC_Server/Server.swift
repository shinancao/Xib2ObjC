//
//  Server.swift
//  Xib2ObjC_Server
//
//  Created by 张楠[产品技术中心] on 2019/6/23.
//

import Foundation
import Socket

import XibProcessor
import Rainbow

class Server {
    
    static let quitCommand: String = "quit"
    static let shutdownCommand: String = "shutdown"
    static let parseCommand: String = "parse:"
    static let bufferSize = 4096
    
    let port: Int
    var listenSocket: Socket? = nil
    var continueRunningValue = true
    var connectedSockets = [Int32: Socket]()
    let socketLockQueue = DispatchQueue(label: "com.ibm.serverSwift.socketLockQueue")
    var continueRunning: Bool {
        set(newValue) {
            socketLockQueue.sync {
                self.continueRunningValue = newValue
            }
        }
        get {
            return socketLockQueue.sync {
                self.continueRunningValue
            }
        }
    }
    
    init(port: Int) {
        self.port = port
    }
    
    deinit {
        // Close all open sockets...
        for socket in connectedSockets.values {
            socket.close()
        }
        self.listenSocket?.close()
    }
    
    func run() {
        
        let queue = DispatchQueue.global(qos: .userInteractive)
        
        queue.async { [unowned self] in
            
            do {
                // Create an IPV6 socket...
                try self.listenSocket = Socket.create(family: .inet6)
                
                guard let socket = self.listenSocket else {
                    
                    print("Unable to unwrap socket...")
                    return
                }
                
                try socket.listen(on: self.port)
                
                print("Listening on port: \(socket.listeningPort)")
                
                repeat {
                    let newSocket = try socket.acceptClientConnection()
                    
                    print("Accepted connection from: \(newSocket.remoteHostname) on port \(newSocket.remotePort)")
//                    print("Socket Signature: \(String(describing: newSocket.signature?.description))")
                    
                    self.addNewConnection(socket: newSocket)
                    
                } while self.continueRunning
                
            }
            catch let error {
                guard let socketError = error as? Socket.Error else {
                    print("Unexpected error...")
                    return
                }
                
                if self.continueRunning {
                    
                    print("Error reported:\n \(socketError.description)")
                    
                }
            }
        }
        dispatchMain()
    }
    
    func addNewConnection(socket: Socket) {
        
        // Add the new socket to the list of connected sockets...
        socketLockQueue.sync { [unowned self, socket] in
            self.connectedSockets[socket.socketfd] = socket
        }
        
        // Get the global concurrent queue...
        let queue = DispatchQueue.global(qos: .default)
        
        // Create the run loop work item and dispatch to the default priority global queue...
        queue.async { [unowned self, socket] in
            
            var shouldKeepRunning = true
            
            var readData = Data(capacity: Server.bufferSize)
            
            do {
                // Write the welcome string...
//                try socket.write(from: "Hello, type 'quit' to end session\nor 'shutdown' to stop server.\n")
                
                repeat {
                    let bytesRead = try socket.read(into: &readData)
                    
                    if bytesRead > 0 {
                        guard let response = String(data: readData, encoding: .utf8) else {
                            
                            print("Error decoding response...")
                            readData.count = 0
                            break
                        }
                        
                        if response.hasPrefix(Server.shutdownCommand) {
                            
                            print("Shutdown requested by connection at \(socket.remoteHostname):\(socket.remotePort)")
                            
                            // Shut things down...
                            self.shutdownServer()
                            
                            return
                        }
                        
                        print("Server received from connection at \(socket.remoteHostname):\(socket.remotePort): " + response.blue.bold)
                        
                        if response.hasPrefix(Server.quitCommand) || response.hasSuffix(Server.quitCommand) {
                            shouldKeepRunning = false
                        }
                        
                        if response.hasPrefix(Server.parseCommand) {
                            let xibName = String(response.split(separator: ":").last ?? "")
                            self.paserXib(name: xibName)
                        }
                    }
                    
                    if bytesRead == 0 {
                        
                        shouldKeepRunning = false
                        break
                    }
                    
                    readData.count = 0
                    
                } while shouldKeepRunning
                
                print("Socket: \(socket.remoteHostname):\(socket.remotePort) closed...")
                socket.close()
                
                self.socketLockQueue.sync { [unowned self, socket] in
                    self.connectedSockets[socket.socketfd] = nil
                }
                
            }
            catch let error {
                guard let socketError = error as? Socket.Error else {
                    print("Unexpected error by connection at \(socket.remoteHostname):\(socket.remotePort)...")
                    return
                }
                if self.continueRunning {
                    print("Error reported by connection at \(socket.remoteHostname):\(socket.remotePort):\n \(socketError.description)")
                }
            }
        }
    }
    
    func shutdownServer() {
        print("\nShutdown in progress...")
        
        self.continueRunning = false
        
        // Close all open sockets...
        for socket in connectedSockets.values {
            
            self.socketLockQueue.sync { [unowned self, socket] in
                self.connectedSockets[socket.socketfd] = nil
                socket.close()
            }
        }
        
        DispatchQueue.main.sync {
            exit(0)
        }
    }
    
    func paserXib(name: String) {
        guard name != "" else {
            print("xib name is empty.".red.bold)
            return
        }
        
        // get complete xib path
        let fileMgr = FileManager.default
        var path = fileMgr.currentDirectoryPath
        path = path.replacingOccurrences(of: "Server", with: "Client") + "/Xib/" + name + ".xib"
        
        let processor = XibProcessor()
        processor.input = path

        do {
            let filePath = try processor.process()
            print("\(filePath).h is generated.".green.bold)
            print("\(filePath).m is generated.".green.bold)
        } catch Xib2ObjCError.createOutputDirFailed(let errorMsg){
            print(errorMsg.red.bold)
        } catch Xib2ObjCError.xibFileNotExist(let errorMsg) {
            print(errorMsg.red.bold)
        } catch Xib2ObjCError.unknownXibObject(let errorMsg) {
            print(errorMsg.red.bold)
        } catch Xib2ObjCError.parseXibToXmlFailed(let errorMsg) {
            print(errorMsg.red.bold)
        } catch {
            print("Unexpected error: \(error).".red.bold)
        }
    }
}
