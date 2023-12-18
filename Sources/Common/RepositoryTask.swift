import Foundation

class RepositoryTask: Resumable {
    
    var networkTask: NetworkCallable
    var isCancelled: Bool = false
    
    init(networkTask: NetworkCallable) {
        self.networkTask = networkTask
    }
    
    var progress: Progress {
        return networkTask.progress
    }
    
    func cancel() {
        networkTask.cancel()
        isCancelled = true
    }
    func resume() {
        networkTask.resume()
    }
    
    func suspend() {
        networkTask.suspend()
    }
}

extension NetworkCallable {
    func toResumable() -> Resumable {
        RepositoryTask(networkTask: self)
    }
}
