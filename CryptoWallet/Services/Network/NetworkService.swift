import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(
        _ endPoint: String,
        host: String,
        httpMethod: HTTPMethod,
        completion: @escaping(Result<T, NetworkError>) -> Void
    )
}

extension NetworkServiceProtocol {
    func request<T: Decodable>(_ endPoint: String, completion: @escaping(Result<T, NetworkError>) -> Void) {
        request(
            endPoint,
            host: NetworkEndpoints.Host.messariAPI.rawValue,
            httpMethod: .get,
            completion: completion
        )
    }
}

struct NetworkService: NetworkServiceProtocol {
    func request<T>(
        _ endPoint: String,
        host: String,
        httpMethod: HTTPMethod,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) where T: Decodable {
        do {
            let request = try makeRequest(with: endPoint, host: host, httpMethod: httpMethod)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                
                if error != nil { return completion(.failure(.unknown)) }
                guard let data = data else { return completion(.failure(.unknown)) }
                
                do {
                    let decode = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decode))
                } catch {
                    completion(.failure(.invalidParams))
                }
            }.resume()
            
        } catch {
            completion(.failure(.unknown))
        }
    }
    
    func makeRequest(with endPoint: String, host: String, httpMethod: HTTPMethod) throws -> URLRequest {
        guard let components = URLComponents(string: host + endPoint) else {
            throw NetworkError.invalidURL
        }
        
        guard let urlReq = components.url else {
            throw NetworkError.invalidParams
        }
        
        var urlRequest = URLRequest(url: urlReq)
        urlRequest.httpMethod = httpMethod.rawValue
        
        return urlRequest
    }
    
    func fetchAssets(completion: @escaping (Result<[Crypto], NetworkError>) -> Void) {
        let endpoint = "/assets"
        request(endpoint, host: NetworkEndpoints.Host.messariAPI.rawValue, httpMethod: .get) { (result: Result<AssetsResponse, NetworkError>) in
            switch result {
            case .success(let assetsResponse):
                completion(.success(assetsResponse.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

