//
//  UserModel.swift
//  GithubFollowes
//
//  Created by user on 03/01/24.
//

import Foundation

struct UserModel: Codable {
    var login: String
    var avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    var publicRepos: Int
    var publicGists: Int
    var htmlUrl: String
    var followers: Int
    var following: Int
}
