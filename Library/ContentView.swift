//
//  ContentView.swift
//  Library
//
//  Created by Сергей Римкевич on 09.02.2025.
//

import SwiftUI

struct IdentifableString: Identifiable {
    let id = UUID()
    let value: String
}

struct ContentView: View {
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let photos = ["Gallery", "Gallery 2", "Gallery 3", "Gallery 4", "gallery 5", "Gallery 6", ]
    
    @State private var selectedPhoto: IdentifableString? = nil
    
    @State private var isBlurred = false
    @State private var showButtons = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        avatarView()
                            .padding(.top, 40)
                        
                        titleView()
                        
                        mainInfo()
                            .background(Color.black.mix(with: .white , by: 0.2))
                            .cornerRadius(16)
                            .padding(.top, 14)
                            .padding(.horizontal, 16)
                        
                        Spacer()
                        
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        postsInfo()
                        
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 0) {
                                ForEach(photos, id: \.self) { photo in
                                    Image(photo)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(minWidth: 135, maxWidth: .infinity, maxHeight: 200)
                                        .clipped()
                                        .padding(.horizontal, 1)
                                        .padding(.top, 1)
                                        .padding(.bottom, 1)
                                        .onTapGesture { selectedPhoto = IdentifableString(value: photo)
                                        }
                                }
                            }
                        }
                        .sheet(item: $selectedPhoto ) {
                            photo in
                            FullScreenPhotoView(imageName: photo.value)
                                .background(TransparentBackground())
                        }
                    }
                    
                    Spacer()
                    
                }
            }
            .blur(radius: isBlurred ? 10 : 0)
            .animation(.easeInOut, value: isBlurred)
            
            if showButtons {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation {
                            isBlurred = false
                            showButtons = false
                    }
                }
                VStack {
                    Button(action: {
                        print("Кнопка 1 нажата")
                    }) {
                        Text("Позвонить через телеграмм")
                            .foregroundStyle(.white)
                            .font(.system(size: 14))
                            .frame(height: 20)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 16)
                    }
                    
                    Rectangle()
                        .frame(height: 0.3)
                        .foregroundStyle(.white.opacity(0.2))
                    
                    Button(action: {
                        print("Кнопка 2 нажата")
                    }) {
                        Text("Видеозвонок через телеграмм")
                            .foregroundStyle(.white)
                            .font(.system(size: 14))
                            .frame(height: 20)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 16)
                    }
                    
                    Rectangle()
                        .frame(height: 0.3)
                        .foregroundStyle(.white.opacity(0.2))
                                        
                }
                .transition(.scale)
                .background(Color.black.mix(with: .white , by: 0.4))
                .cornerRadius(16)
                .padding(.top, 14)
                .padding(.horizontal, 16)
                
            }
        }
    }
    
    private func avatarView() -> some View {
        Image(.avatar)
            .resizable()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(
                        .green.opacity(0.9),
                        lineWidth: 2
                    )
            )
    }
    
    private func titleView() -> some View {
        VStack(spacing: 0) {
            Text("Маша")
                .font(.largeTitle)
                .fontWeight(.regular)
                .foregroundStyle(.white)
                .padding(.top, 12)
            
            Text("В сети")
                .foregroundStyle(.gray.opacity(0.9))
                .padding(.top, 4)
        }
    }
    
    private func mainInfo() -> some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 0) {
                Button(action: {
                    withAnimation {
                        isBlurred.toggle()
                        showButtons.toggle()
                    }
                }) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("мобильный")
                            .foregroundStyle(.white)
                            .font(.system(size: 14))
                        
                        Text("+7 999 222 95 54")
                            .foregroundStyle(.blue)
                            .font(.system(size: 18))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 16)
                }
                
                Rectangle()
                    .frame(height: 0.3)
                    .foregroundStyle(.white.opacity(0.2))
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("имя пользователя")
                        .foregroundStyle(.white)
                        .font(.system(size: 14))
                    
                    Text("@asdsad")
                        .foregroundStyle(.blue)
                        .font(.system(size: 18))
                }
                .frame(height: 40)
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                
                Rectangle()
                    .frame(height: 0.3)
                    .foregroundStyle(.white.opacity(0.2))
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("дата рождения")
                        .foregroundStyle(.white)
                        .font(.system(size: 14))
                    
                    Text("18 сент 2003 (21 год)")
                        .foregroundStyle(.white)
                        .font(.system(size: 18))
                }
                .frame(height: 40)
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                
                Rectangle()
                    .frame(height: 0.3)
                    .foregroundStyle(.white.opacity(0.2))
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("о себе")
                        .foregroundStyle(.white)
                        .font(.system(size: 14))
                    
                    Text("Танцую жоска 🫶🏼")
                        .foregroundStyle(.white)
                        .font(.system(size: 18))
                }
                .frame(height: 40)
                .padding(.vertical, 10)
                .padding(.horizontal, 16)
                
                Rectangle()
                    .frame(height: 0.3)
                    .foregroundStyle(.white.opacity(0.2))
                
            }
            .blur(radius: isBlurred ? 5 : 0)
        }
    }
    private func postsInfo() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 0) {
                Text("Публикации")
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.black.mix(with: .white, by: 0.7))
                    .font(.system(size: 12))
                    .padding(.horizontal, 60)
                    .padding(.top, 20)
                    .padding(.bottom, 15)
                    .background(Color.black.mix(with: .white , by: 0.2))
                
                Text("Архив публикации")
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.black.mix(with: .white, by: 0.7))
                    .font(.system(size: 12))
                    .padding(.horizontal, 60)
                    .padding(.top, 20)
                    .padding(.bottom, 15)
                    .background(Color.black.mix(with: .white , by: 0.2))
                
                Text("Голосовые сообщения")
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.black.mix(with: .white, by: 0.7))
                    .font(.system(size: 12))
                    .padding(.horizontal, 60)
                    .padding(.top, 20)
                    .padding(.bottom, 15)
                    .background(Color.black.mix(with: .white , by: 0.2))
                
            }
        }
        .background(Color.black.mix(with: .white , by: 0.2))
        .padding(.top, 30)
    }
    
    struct FullScreenPhotoView: View {
        var imageName: String
        
        var body: some View {
            VStack {
                
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .edgesIgnoringSafeArea(.all)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black.opacity(0.5))
        }
    }
    
    struct TransparentBackground:
        UIViewRepresentable {
        func makeUIView(context: Context) -> UIView {
            let view = UIView()
            view.backgroundColor = .clear
            return view
        }
        
        func updateUIView(_ uiView: UIView, context: Context) {}
    }
}

    struct ContentView_Previews:
        PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
