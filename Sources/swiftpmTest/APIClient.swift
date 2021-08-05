import Foundation

class APIClient {
    func request<T: Requestable>(_ requestable: T) -> T.Model? {
        var result: T.Model? = nil
        let semaphore = DispatchSemaphore(value: 0)
        guard let request = requestable.urlRequest, let url = request.url else { return nil }
        print("🌐 \(requestable.httpMethod):\(url)")
        let task = URLSession.shared.dataTask(
            with: request,
            completionHandler: { (data, response, error) in
                if let error = error {
                    print("❌ Unknown: \(error)")
                    semaphore.signal()
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse else {
                    print("❌ No Response")
                    semaphore.signal()
                    return
                }

                if case 200..<300 = response.statusCode {
                    do {
                        let model = try requestable.decode(from: data)
                        print("✅ StatusCode: \(response.statusCode)")
                        dump(model)
                        result = model
                    } catch let decodeError {
                        print("❌ Decode Error: \(decodeError) : \(String(decoding: data, as: UTF8.self)))")
                    }
                } else {
                    print("❌ StatusCode: \(response.statusCode) : \(String(decoding: data, as: UTF8.self)))")
                }
                semaphore.signal()
            })
        task.resume()
        semaphore.wait()
        return result
    }
}
