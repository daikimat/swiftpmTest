struct GitHubPull: Codable {
    let number: Int
    let title: String
    let body: String?
    let head: GithubBranch
    let base: GithubBranch
}
