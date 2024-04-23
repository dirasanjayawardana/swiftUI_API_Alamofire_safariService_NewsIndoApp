//
//  NewsViewModel.swift
//  NewsIndo
//
//  Created by MACBOOK PRO on 23/04/24.
//

import Foundation

@MainActor
class NewsViewModel: ObservableObject {
    @Published var articles = [NewsArticle]()
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchNews() async {
        isLoading = true
        defer { isLoading = false } // eksekusi isLoading diatur kembali ke false sebelum fungsi selesai
        errorMessage = nil // Bersihkan pesan error sebelumnya
        
        do {
            articles = try await APIService.shared.fetchNews() // Coba ambil berita dari API
            // isLoading = false // Tidak perlu lagi karena defer sudah menanganinya
        } catch {
            errorMessage = "\(error.localizedDescription). Failed to fetch news from Api!" // Atur pesan error jika gagal
            print(errorMessage ?? "N/A") // Cetak pesan error
            // isLoading = false // Tidak perlu lagi karena defer sudah menanganinya
        }
    }
}
