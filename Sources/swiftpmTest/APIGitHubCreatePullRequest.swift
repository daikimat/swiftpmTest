import Foundation

struct APIGitHubCreatePullRequest: Requestable {
    typealias Model = GitHubPull

    private let token: String
    private let title: String
    private let pullBody: String
    private let head: String
    private let base: String

    let url: String
    let httpMethod = "POST"

    var body: Data? {
        let body: [String: Any] = [
            "head": self.head,
            "base": self.base,
            "title": self.title,
            "body": self.pullBody,
        ]
        return try! JSONSerialization.data(withJSONObject: body, options: [])
    }
    var headers: [String: String] {
        return [
            "Content-type": "application/json; charset=utf-8",
            "Authorization": "token \(self.token)",
            "Accept": "application/vnd.github.v3+json",
        ]
    }

    init(
        token: String,
        owner: String,
        repo: String,
        head: String,
        base: String,
        title: String = "",
        body: String = ""
    ) {
        self.token = token
        self.url = "https://api.github.com/repos/\(owner)/\(repo)/pulls"
        self.head = head
        self.base = base
        self.title = title
        self.pullBody = body
    }

    func decode(from data: Data) throws -> GitHubPull {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(GitHubPull.self, from: data)
    }
}
