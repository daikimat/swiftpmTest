import Foundation

struct Shell {
    @discardableResult
    static func run(_ args: String...) -> ShellOutput {
        print("$ \(args.joined(separator: " "))")
        let task = Process()
        let pipe = Pipe()
        task.launchPath = "/usr/bin/env"
        task.arguments = args
        task.standardOutput = pipe
        task.launch()
        task.waitUntilExit()
        let output = ShellOutput(fileHandle: pipe.fileHandleForReading, terminationStatus: task.terminationStatus)
        if let outputString = output.string {
            print(outputString)
        }
        return output
    }
}
