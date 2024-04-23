//
//  ContentView.swift
//  NewsIndo
//
//  Created by MACBOOK PRO on 23/04/24.
//

import SwiftUI
import SafariServices

struct NewsView: View {
    
    @StateObject private var newsViewModel = NewsViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(newsViewModel.articles) { article in
                    VStack(alignment: .leading, spacing: 16, content: {
                        
                        AsyncImage(url: URL(string: article.image.medium), content: { image in
                            image.resizable()
                                .scaledToFit()
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }, placeholder: {
                            WaitingView()
                        })
                        
                        Text(article.title)
                            .font(.headline)
                        
                        Text(article.author)
                            .font(.headline)
                            .foregroundStyle(.secondary)
                        
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
                    .padding(.bottom, 4)
                }
            }
            .listStyle(.plain)
            .navigationTitle(Constant.newsTitle)
            .task {
                await newsViewModel.fetchNews()
            }
            .overlay(newsViewModel.isLoading ? WaitingView() : nil)
        }
    }
}

#Preview {
    NewsView()
}

@ViewBuilder
func WaitingView() -> some View {
    VStack(spacing: 20, content: {
        ProgressView()
            .progressViewStyle(.circular)
            .tint(.secondary)
        
        Text("loading image ...")
    })
}

extension UIApplication {
    var firstKeyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes.compactMap { scene in
            scene as? UIWindowScene
        }
        .filter { filter in
            filter.activationState == .foregroundActive
        }
        .first?.keyWindow
    }
}
