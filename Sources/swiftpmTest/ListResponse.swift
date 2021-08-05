struct ListResponse<T:Codable>: Codable {
    let items: [T]
}

extension ListResponse {
    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        for item in items {
            try container.encode(item)
        }
    }
    init(from decoder: Decoder) throws {
        var items: [T] = []
        var unkeyedContainer = try decoder.unkeyedContainer()
        while !unkeyedContainer.isAtEnd {
            let item = try unkeyedContainer.decode(T.self)
            items.append(item)
        }
        self.init(items: items)
    }
}
