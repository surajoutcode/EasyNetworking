import Foundation

public protocol Resumable {
    func cancel()
    func resume()
    func suspend()
    var progress: Progress { get }
}
