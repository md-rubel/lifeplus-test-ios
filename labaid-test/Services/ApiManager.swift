//
//  ApiManager.swift
//  labaid-test
//
//  Created by MD RUBEL on 20/1/21.
//

import Foundation

class ApiManager {
    
    public static let shared = ApiManager()
    
    private func getUrlRequest(with url: URL, method: Method, json: [String: Any]? = nil, token: String? = nil) -> URLRequest {
                
        var urlReq = URLRequest(url: url)
        urlReq.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        if let token = token {
            let authorizationKey = "Bearer ".appending(token)
            urlReq.addValue(authorizationKey, forHTTPHeaderField: "Authorization")
        }
        
        urlReq.httpMethod = method.description
        
        if let json = json {
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            urlReq.httpBody = jsonData
        }
        
        return urlReq
    }

    
    func loginWith(email: String, password: String, completion: @escaping ((UserModel?) -> Void)) {
        
        let link = Links.LOGIN.replacingOccurrences(of: " ", with: "%20")
        
        guard let url = URL(string: link) else { return }
        
        let parameters = [
            "email": email,
            "password": password
        ]
        
        let urlReq  = getUrlRequest(with: url, method: .post, json: parameters)
        
        URLSession.shared.dataTask(with: urlReq) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let responseModel = try JSONDecoder().decode(UserModel.self, from: data)
                completion(responseModel)
                
            } catch {
                completion(nil)
            }

        }.resume()
    }
    
    func registerWith(name: String, email: String, password: String, phone: String, completion: @escaping ((UserModel?) -> Void)) {
        
        let link = Links.REGISTER.replacingOccurrences(of: " ", with: "%20")
        
        guard let url = URL(string: link) else { return }
        
        let parameters = [
            "name": name,
            "email": email,
            "password": password,
            "phone": phone
        ]
        
        let urlReq  = getUrlRequest(with: url, method: .post, json: parameters)
        
        URLSession.shared.dataTask(with: urlReq) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let responseModel = try JSONDecoder().decode(UserModel.self, from: data)
                completion(responseModel)
                
            } catch {
                completion(nil)
            }

        }.resume()
    }
    
    func logoutWith(token: String, completion: @escaping ((Bool) -> Void)) {
        
        let link = Links.LOG_OUT.replacingOccurrences(of: " ", with: "%20")
        
        guard let url = URL(string: link) else { return }
        
        let urlReq  = getUrlRequest(with: url, method: .post, token: token)
        
        URLSession.shared.dataTask(with: urlReq) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse, error == nil else {
                completion(false)
                return
            }
            
            if httpResponse.statusCode == 200 {
                completion(true)
                
            } else {
                completion(false)
            }

        }.resume()
    }
    
    func search(for name: String, completion: @escaping ((SearchModel?) -> Void)) {
        
        let link = "\(Links.SEARCH)?q=\(name)"
        
        guard let url = URL(string: link.replacingOccurrences(of: " ", with: "%20")) else { return }
        
        let urlReq  = getUrlRequest(with: url, method: .get)
        
        URLSession.shared.dataTask(with: urlReq) { (data, response, error) in
            
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                let responseModel = try JSONDecoder().decode(SearchModel.self, from: data)
                completion(responseModel)
                
            } catch {
                completion(nil)
            }

        }.resume()
    }
}

fileprivate enum Method: Int, CustomStringConvertible {
    
    case post
    case get
    
    var description: String {
        switch self {
        case .post: return "POST"
        case .get: return "GET"
        }
    }
}
