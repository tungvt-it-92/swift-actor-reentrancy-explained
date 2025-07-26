//
//  ContentView.swift
//  SwiftActorBoostcamp
//

import SwiftUI

struct RefreshTokenWithActorButReentrancyView: View {
    var body: some View {
        VStack {
            Button {
                let accessTokenManager = AccessTokenManagerWithActorButReentrancy()
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

actor AccessTokenManagerWithActorButReentrancy {
    func getAccessToken() async -> String {
        print("AccessTokenManager START refreshTokenToken")
        defer {
            print("AccessTokenManager FINISH refreshTokenToken")
        }

        return await fetchValidAccessToken()
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
