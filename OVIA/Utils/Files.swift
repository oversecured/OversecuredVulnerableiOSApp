import Foundation

fileprivate let cacheFileLocation = "oversecured.OVIA/Cache.db"

class Files {
    private init() {
    }
    
    static func dumpCacheFile(to toDir: URL) {
        guard toDir.startAccessingSecurityScopedResource() else {
            return
        }
        defer {
            toDir.stopAccessingSecurityScopedResource()
        }
        let cacheFile = getCacheDirectoryPath().appendingPathComponent(cacheFileLocation)
        let destination = toDir.appendingPathComponent(cacheFile.lastPathComponent)
        try! FileManager.default.copyItem(at: cacheFile, to: destination)
    }
    
    static func getCacheDirectoryPath() -> URL {
        let arrayPaths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        let cacheDirectoryPath = arrayPaths[0]
        return cacheDirectoryPath
    }
}
