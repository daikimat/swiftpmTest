import Foundation

protocol Requestable {
    associatedtype Model

    var url: String { get }
    var httpMethod: String { get }
    var headers: [String: String] { get }
    var body: Data? { get }

    func decode(from data: Data) throws -> Model
}

extension Requestable {
    var urlRequest: URLRequest? {
        guard let url = URL(string: url) else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        if let body = body {
            request.httpBody = body
        }
        headers.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }
        return request
    }
}
