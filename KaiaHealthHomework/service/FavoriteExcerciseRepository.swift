//
//  FavoriteExcerciseRepository.swift
//  KaiaHealthHomework
//
//  Created by Jakub Matula on 14/12/2021.
//

import Foundation

protocol ExcerciseRepository {
    func fetchExcercises() async throws -> [Excercise]
}

class RemoteExcerciseRepository: ExcerciseRepository {
    private let session: URLSession
    private let decoder: JSONDecoder

    init(session: URLSession, decoder: JSONDecoder) {
        self.session = session
        self.decoder = decoder
    }

    func fetchExcercises() async throws -> [Excercise] {
        let url = URL(string: "https://jsonblob.com/api/jsonBlob/027787de-c76e-11eb-ae0a-39a1b8479ec2")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decoder.decode([Excercise].self, from: data)
    }
}
