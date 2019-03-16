import Foundation
import SwiftCLI

public class CleanCommand: Command {
    // MARK: - Command
    public let name: String = "clean"
    public let shortDescription: String = "Deletes all checkouts and build prodcuts from within the current projects directory"

    // MARK: - Initializers
    public init() {}

    // MARK: - Instance Methods
    public func execute() throws {
        guard FileManager.default.fileExists(atPath: Constants.buildPath) else {
            print("Local build path is already clean.", level: .info)
            return
        }

        print("Calculating size of local build path ...", level: .info)
        let localBuildDirectorySizeInBytes = try FileManager.default.directorySizeInBytes(atPath: Constants.buildPath)

        print("Cleaning local build path ...", level: .info)
        try bash("rm -rf '\(Constants.buildPath)'")

        let byteCountFormatter = ByteCountFormatter()
        let localBuildPathSizeString = byteCountFormatter.string(fromByteCount: localBuildDirectorySizeInBytes)
        print("Successfully cleaned local build path. Total space freed up: \(localBuildPathSizeString)", level: .info)
    }
}