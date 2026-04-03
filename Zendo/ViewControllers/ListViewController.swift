import SwiftUI

struct SessionListView: View {
    @EnvironmentObject var store: SessionStore
    @Environment(\.horizontalSizeClass) var sizeClass
    @State private var sessionToDelete: Session?
    @State private var sessionToStart: Session?
    @State private var showingZenAlert = false
    @State private var navigateToTimer = false

    private var isRegular: Bool { sizeClass == .regular }

    var body: some View {
        List {
            ForEach(store.sessions) { session in
                Button {
                    sessionToStart = session
                    showingZenAlert = true
                } label: {
                    HStack(spacing: isRegular ? 28 : 20) {
                        if let img = UIImage(named: "zen.png") {
                            Image(uiImage: img)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: isRegular ? 70 : 55,
                                       height: isRegular ? 70 : 55)
                                .background(Color.zendoZenBg)
                                .clipShape(RoundedRectangle(cornerRadius: 6))
                        }

                        Text(session.title)
                            .font(.system(size: isRegular ? 36 : 30, weight: .bold))
                            .foregroundStyle(.primary)

                        Spacer()

                        Image(systemName: "chevron.right")
                            .foregroundStyle(.secondary)
                    }
                    .padding(.vertical, isRegular ? 22 : 16)
                }
                .listRowBackground(Color.zendoBackground)
                .listRowSeparator(.hidden)
            }
            .onDelete { indexSet in
                if let index = indexSet.first {
                    sessionToDelete = store.sessions[index]
                }
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .background(Color.zendoBackground)
        .navigationDestination(isPresented: $navigateToTimer) {
            if let session = sessionToStart {
                SessionTimerView(session: session)
                    .onDisappear {
                        navigateToTimer = false
                        sessionToStart = nil
                    }
            }
        }
        .alert(
            "Entering Zen Time",
            isPresented: $showingZenAlert
        ) {
            Button("Cancel", role: .cancel) {
                sessionToStart = nil
            }
            Button("OK") {
                navigateToTimer = true
            }
        } message: {
            Text("You are entering Zen time. Interference from the outside world will be diminished. You can also choose to set Do Not Disturb, for absolute stillness.")
        }
        .alert(
            "Delete Session",
            isPresented: Binding(
                get: { sessionToDelete != nil },
                set: { if !$0 { sessionToDelete = nil } }
            )
        ) {
            Button("No", role: .cancel) { sessionToDelete = nil }
            Button("Yes", role: .destructive) {
                if let session = sessionToDelete {
                    store.remove(session)
                }
                sessionToDelete = nil
            }
        } message: {
            if let session = sessionToDelete {
                Text("Delete \"\(session.title)\"? \(AlertMessages.deletePrompt)")
            }
        }
    }
}
