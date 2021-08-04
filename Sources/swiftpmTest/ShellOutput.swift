import Foundation

struct ShellOutput {
    let data: Data
    let string: String?
    let lines: [String]
    let success: Bool
    
    init(fileHandle: FileHandle, terminationStatus: Int32) {
        self.data = fileHandle.readDataToEndOfFile()
        self.string = String(data: data, encoding: .utf8)
        self.lines = self.string?.components(separatedBy: "\n") ?? []
        self.success = terminationStatus == 0
    }
}
