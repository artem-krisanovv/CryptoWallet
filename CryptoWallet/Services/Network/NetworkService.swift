import Foundation

final class NetworkService {
    static let shared = NetworkService()
    private let api = CoinAPI()
    private init() {}
    
    func fetchAssets(completion: @escaping (Result<[Crypto], Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: api.url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return
            }
            do {
                let result = try JSONDecoder().decode(AssetsResponse.self, from: data)
                let filtered = result.data.filter { self.api.allowedCoins.contains($0.symbol.lowercased()) }
                completion(.success(filtered))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
