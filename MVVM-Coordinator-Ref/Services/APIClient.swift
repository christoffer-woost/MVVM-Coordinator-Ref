//
//  APIClient.swift
//  MVVM-Coordinator-Ref
//
//  Created by Christoffer Woost on 03.07.21.
//

import Foundation
import Combine

enum HTTPMethod: String {
    case get        = "GET"
    case head       = "HEAD"
    case post       = "POST"
    case put        = "PUT"
    case delete     = "DELETE"
    case connect    = "CONNECT"
    case options    = "OPTIONS"
    case trace      = "TRACE"
    case patch      = "PATCH"
}

protocol RequestConvertable {
    associatedtype Response: Decodable
    
    var endpoint: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var parameters: [String: String]? { get }
    var body: Data? { get }
    var timeoutInterval: TimeInterval { get }
}

extension RequestConvertable {
    
    var endpoint: URL { URL(string: "https://api.github.com")! }
    var headers: [String : String]? { ["Accept": "application/vnd.github.inertia-preview+json"] }
    var parameters: [String : String]? { nil }
    var body: Data? { nil }
    var timeoutInterval: TimeInterval { 10 }
    
}

extension RequestConvertable {
    var asURLRequest: URLRequest? {
        guard var components = URLComponents(url: endpoint.appendingPathComponent(path), resolvingAgainstBaseURL: false) else { return nil }
        components.queryItems = parameters?.map { URLQueryItem(name: $0, value: $1) }
        guard let url = components.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        headers?.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        request.httpBody = body
        request.timeoutInterval = timeoutInterval
        return request
    }
}

struct APIClient {
    
    static private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
    
    static func request<T: RequestConvertable>(_ request: T) -> AnyPublisher<T.Response, Error> {
        let urlRequest = request.asURLRequest!
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .map { $0.data }
            .decode(type: T.Response.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
//            URLSession.shared.rx.response(request: urlRequest)
//            .map { (response, responseData) in
//                guard (200..<300).contains(response.statusCode) else {
//                    if response.statusCode == 401 {
//                        if request.autoLogout {
//                            Container.shared.userManager.forceLogout()
//                        }
//                        return .failure(APIError.unauthorized)
//                    }
//                    return .failure(APIError.generalError)
//                }
//                do {
//                    return .success(try JSONDecoder().decode(T.Response.self, from: responseData))
//                } catch {
//                    print(error)
//                    return .failure(APIError.decodingError)
//                }
//            }
//            .catch { .of(.failure($0)) }
//            .observe(on: MainScheduler.asyncInstance)
    }
    
}

struct ProjectsAPIRequest: RequestConvertable {
    typealias Response = SearchResponse
    
    var path: String = "/search/repositories"
    var method: HTTPMethod = .get
    
    var parameters: [String : String]? = [
        "q": "language:swift",
        "sort": "stars",
        "per_page": "100"
    ]
}
