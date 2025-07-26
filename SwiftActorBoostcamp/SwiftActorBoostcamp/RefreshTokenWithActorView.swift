//
//  ContentView.swift
//  SwiftActorBoostcamp
//

import SwiftUI

struct RefreshTokenWithActorView: View {
    
    var body: some View {
        VStack {
            Button {
                let accessTokenManager = AccessTokenManagerWithActor()
                Task {
                    await withTaskGroup(of: Void.self) { group in
                        for _ in 0 ..< 10 { // Simulate 10 concurrent requests for an access token
                            group.addTask {
                                _ = await accessTokenManager.getAccessToken()
                            }
                        }
                    }
                }
            } label: {
                Text("Refresh token")
                    .padding(10)
                    .background {
                        Color.green
                    }
                    .cornerRadius(10)
                    .foregroundStyle(.white)
            }
        }
    }
}

actor AccessTokenManagerWithActor {
    typealias FetchValidTokenTask = Task<String, Never>
    private var fetchValidTokenTask: FetchValidTokenTask?
    
    func getAccessToken() async -> String {
        print("AccessTokenManager START getAccessToken")
        defer {
            print("AccessTokenManager FINISH refreshTokenToken")
            fetchValidTokenTask = nil
        }

        if fetchValidTokenTask == nil {
            fetchValidTokenTask = FetchValidTokenTask { await fetchValidAccessToken() }
        }

        let newToken = await fetchValidTokenTask!.value

        return newToken
    }

    private func fetchValidAccessToken() async -> String {
        print("🚀 AccessTokenManager START fetchValidAccessToken 🚀")
        defer {
            print("✅ AccessTokenManager FINISH fetchValidAccessToken ✅")
        }

        print("Access token expired!")
        print("Refreshing access token...")
        try? await Task.sleep(for: .seconds(2)) // Simulate network call
        print("Access token refreshed!")

        return "new-access-token"
    }
}
