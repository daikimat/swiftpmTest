import ArgumentParser

struct SwiftpmTest: ParsableCommand {
  @Argument(help: "GitHubのPull Request read/write 権限を持つToken")
  var githubToken: String

  mutating func run() throws {
    Shell.run("git, checkout", "-b", "newBranch")
    Shell.run("git", "commit", "-m", "empty commit", "--allow-empty")    
    guard
        Shell.run(
            "git", "push", "--force", "origin", ""
        ).success
    else { return }

    let apiGitHubCreatePullRequest = APIGitHubCreatePullRequest(
        token: self.githubToken,
        owner: "daikimat",
        repo: "swiftpmTest",
        head: "newBranch",
        base: "master",
        title: "Sample PR",
        body: ""
    )
    _ = APIClient().request(apiGitHubCreatePullRequest)
  }
}

print("Hello, world!")
SwiftpmTest.main()