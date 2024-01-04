//
//  NetworkManager.swift
//  GithubFollowes
//
//  Created by user on 03/01/24.
//

import UIKit
enum DataError: String, Error {
    case invalidResponse = "Invalid Response from the Server"
    case invalidURL = "Invalid Request from the User"
    case invalidData = "Invalid Data from the Server"
    case errorDecoding = "Invalid Response from the Servers"
}

class NetworkManager {
    static let shared = NetworkManager()
    let cache = NSCache<NSString,UIImage>()
    private init() {}
    
    func getfollowers(for userName: String, page: Int, completion: @escaping (Result<[Follower], DataError>) -> Void)
    {
        let endPoint = Constant.API.GithubBaseURL + "users/\(userName)/followers?per_page=100&&page=\(page)"
        guard let urlReq = URL(string: endPoint) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: urlReq) { data, resp, err in
            guard let data = data, err == nil else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = resp as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followerList = try decoder.decode([Follower].self, from: data)
                completion(.success(followerList))
                print(followerList)
            }
            catch {
                completion(.failure(.errorDecoding))
            }
        }.resume()
    }
    
    func getUsers(for userName: String, completion: @escaping (Result<[UserModel], DataError>) -> Void)
    {
        let endPoint = Constant.API.GithubBaseURL + "users/\(userName)/followers?per_page=100&&page=\(page)"
        guard let urlReq = URL(string: endPoint) else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: urlReq) { data, resp, err in
            guard let data = data, err == nil else {
                completion(.failure(.invalidData))
                return
            }
            guard let response = resp as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followerList = try decoder.decode([Follower].self, from: data)
                completion(.success(followerList))
                print(followerList)
            }
            catch {
                completion(.failure(.errorDecoding))
            }
        }.resume()
    }
    
}

