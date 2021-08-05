import ArgumentParser

struct SwiftpmTest: ParsableCommand {
  @Argument(help: "GitHubのPull Request read/write 権限を持つToken")
  var githubToken: String

  mutating func run() throws {
    Shell.run("git, checkout", "-b", "newBranch")
    Shell.run("git", "commit", "-m", "empty commit", "--allow-empty")    
    Shell.run("git", "push", "origin", "newBranch")
    let apiGitHubCreatePullRequest = APIGitHubCreatePullRequest(
        token: self.githubToken,
        owner: "daikimat",
        repo: "swiftpmTest",
        head: "newBranch",
        base: "main",
        title: "Sample PR",
        body: ""
    )
    _ = APIClient().request(apiGitHubCreatePullRequest)
  }
}

print("Hello, world!")
SwiftpmTest.main()