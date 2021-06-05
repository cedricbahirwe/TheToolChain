//
//  ContentView.swift
//  RefreshableScrollView
//
//  Created by Cédric Bahirwe on 21/05/2021.
//

import SwiftUI


struct ContentView: View {
    @State var count = 5
    var body: some View {
        NavigationView {
            
            RefreshableScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 2) {
                    ForEach(1...count, id: \.self) { index in
                        Color.red
                            .frame(height: 183)
                            .overlay(Text(index.description).font(.largeTitle))
                            .onTapGesture {
                                count += 5
                            }
                    }
                }
            } onRefresh: { control in
                DispatchQueue.main.asyncAfter(deadline: .now()+2) {
                    control.endRefreshing()
                }
            }
            .padding()
            .navigationTitle("Pull Me Down")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct RefreshableScrollView<Content: View>: UIViewRepresentable {
    var content: Content
    
    var onRefresh: (UIRefreshControl) -> ()
    
    var refreshControl = UIRefreshControl()
    
    
    init(@ViewBuilder content: @escaping () -> Content, onRefresh: @escaping (UIRefreshControl) -> ()) {
        self.content = content()
        self.onRefresh = onRefresh
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull Me")
        refreshControl.tintColor = .red
        refreshControl.addTarget(context.coordinator, action: #selector(context.coordinator.onRefresh), for: .valueChanged)
        
        setupView(scrollView: scrollView)
        scrollView.refreshControl = refreshControl
        
        
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        setupView(scrollView: uiView)
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func setupView(scrollView: UIScrollView) {
        
        let host = UIHostingController(rootView: content.frame(maxHeight: .infinity, alignment: .top))
        
        host.view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            
            host.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            host.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            host.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            host.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            host.view.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            host.view.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor, constant: 1)
            
        ]
        
        scrollView.subviews.last?.removeFromSuperview()
        
        
        scrollView.addSubview(host.view)
        
        scrollView.addConstraints(constraints)
        
        
    }
    
    class Coordinator: NSObject {
        var parent: RefreshableScrollView
        
        
        init(parent: RefreshableScrollView) {
            self.parent = parent
        }
        
        @objc func onRefresh() {
            parent.onRefresh(parent.refreshControl )
        }
    }
}
