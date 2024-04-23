//
//  NewsTechnologyView.swift
//  NewsIndo
//
//  Created by MACBOOK PRO on 23/04/24.
//

import SwiftUI
import SafariServices

struct NewsTechnologyView: View {
    
    @StateObject private var newsTechnologyViewModel = NewsTechnologyViewModel()
    
    @State private var searchInput: String = ""
    
    var newsTechnologyResult: [ArticleTechnology] {
        guard !searchInput.isEmpty else {
            return newsTechnologyViewModel.articlesTechnology
        }
        return newsTechnologyViewModel.articlesTechnology.filter { article in
            article.title.lowercased().contains(searchInput.lowercased())
        }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(newsTechnologyResult) { article in
                    if newsTechnologyViewModel.isLoading {
                        ComponentNewsCard(article: article)
                        .redacted(reason: .placeholder)
                    } else {
                        ComponentNewsCard(article: article)
                    }
                    
                }
            }
            .listStyle(.plain)
            .navigationTitle(Constant.newsTechnologyTitle)
            .task {
                newsTechnologyViewModel.isLoading = true
                await newsTechnologyViewModel.fetchNewsTechnology()
                newsTechnologyViewModel.isLoading = false
            }
            .refreshable {
                newsTechnologyViewModel.isLoading = true
                await newsTechnologyViewModel.fetchNewsTechnology()
                newsTechnologyViewModel.isLoading = false
            }
            .searchable(
                text: $searchInput,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search technology news"
            )
            .overlay {
                if newsTechnologyResult.isEmpty, !newsTechnologyViewModel.isLoading {
                    ContentUnavailableView.search(text: searchInput)
                }
                if newsTechnologyResult.isEmpty, newsTechnologyViewModel.isLoading {
                    WaitingView()
                }
            }
        }
    }
}

#Preview {
    NewsTechnologyView()
}

struct ComponentNewsCard: View {
    var article: ArticleTechnology
    var body: some View {
        HStack(spacing: 16, content: {
            
            AsyncImage(url: URL(string: article.image.small), content: { image in
                image.resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            }, placeholder: {
                WaitingView()
            })
            
            
            VStack(alignment: .leading, spacing: 8, content: {
                
                Text(article.title)
                    .font(.headline)
                    .lineLimit(2, reservesSpace: true)
                
                HStack {
                    Text(DateUtility.formatDateToRelativeString(dateString: article.isoDate))
                        .font(.subheadline)
                    
                    Button(action: {
                        let viewController = SFSafariViewController(url: URL(string: article.link)!)
                        
                        UIApplication.shared.firstKeyWindow?
                            .rootViewController?.present(viewController, animated: true)
                    }, label: {
                        Text("Selengkapnya")
                            .font(.headline)
                            .foregroundStyle(.blue)
                    })
                }
                
            })
            
        })
    }
}
