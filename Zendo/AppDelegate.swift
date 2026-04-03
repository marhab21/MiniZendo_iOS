import SwiftUI

@main
struct MiniZendoApp: App {
    @StateObject private var store = SessionStore()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                Group {
                    if store.sessions.isEmpty {
                        HelpView()
                            .navigationTitle("Mini Zendo")
                    } else {
                        SessionListView()
                            .navigationTitle("Session List")
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            AddSessionView()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title)
                                .fontWeight(.semibold)
                        }
                    }
                }
            }
            .environmentObject(store)
        }
    }
}
