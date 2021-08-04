import ArgumentParser

struct SwiftpmTest: ParsableCommand {
  @Argument(help: "引数１")
  var arg1: String

  mutating func run() throws {
    print(self.arg1)
    print(self.arg1)
    print(self.arg1)
    Shell.run("pwd")
    Shell.run("ls, -la")
  }
}

print("Hello, world!")
SwiftpmTest.main()