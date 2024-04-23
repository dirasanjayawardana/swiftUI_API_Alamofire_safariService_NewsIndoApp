//
//  NewsTechnologyViewModel.swift
//  NewsIndo
//
//  Created by MACBOOK PRO on 23/04/24.
//

import Foundation

@MainActor
class NewsTechnologyViewModel: ObservableObject {
    @Published var articlesTechnology = [ArticleTechnology]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchNewsTechnology() async {
        isLoading = true
        defer { isLoading = false } // eksekusi isLoading diatur kembali ke false sebelum fungsi selesai
        errorMessage = nil
        
        do {
            articlesTechnology = try await APIService.shared.fetchNewsTechnology()
            // isLoading = false
        } catch {
            errorMessage = "\(error.localizedDescription). Failed to fetch news from Api!"
            print(errorMessage ?? "N/A") // Cetak pesan error
            // isLoading = false
        }
    }
}
