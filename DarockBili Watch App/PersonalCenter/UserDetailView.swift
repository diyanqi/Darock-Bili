//
//  UserDetailView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/1.
//
//===----------------------------------------------------------------------===//
//
// This source file is part of the MeowBili open source project
//
// Copyright (c) 2023 Darock Studio and the MeowBili project authors
// Licensed under GNU General Public License v3
//
// See https://darock.top/LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

// UserDetailView 对于 watchOS 10 和其他版本是两套独立代码，更改时记得同时更改！

import SwiftUI
import DarockKit
import Alamofire
import SwiftyJSON
import CachedAsyncImage
import SDWebImageSwiftUI
import AuthenticationServices

struct UserDetailView: View {
    var uid: String
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var userFaceUrl = ""
    @State var username = ""
    @State var userLevel = 0
    @State var officialType = -1
    @State var officialTitle = ""
    @State var userSign = ""
    @State var followCount = -1
    @State var fansCount = -1
    @State var vipLabel = ""
    @State var videos = [[String: String]]()
    @State var viewSelector: UserDetailViewPubsType = .video
    @State var articles = [[String: String]]()
    @State var videoCount = 0
    @State var articalCount = 0
    @State var coinCount = -1
    @State var isFollowed = false
    @State var isSendbMessagePresented = false
    @State var isInfoSheetPresented = false
    var body: some View {
        Group {
            if #available(watchOS 10, *) {
                TabView {
                    VStack {
                        NavigationLink("", isActive: $isSendbMessagePresented, destination: {bMessageSendView(uid: Int64(uid)!, username: username)})
                            .frame(width: 0, height: 0)
                        FirstPageBase(uid: uid, userFaceUrl: $userFaceUrl, username: $username, followCount: $followCount, fansCount: $fansCount, coinCount: $coinCount, isFollowed: $isFollowed, isSendbMessagePresented: $isSendbMessagePresented)
                        Spacer()
                    }
                    .toolbar {
                        ToolbarItemGroup(placement: .bottomBar) {
                            Button(action: {
                                let headers: HTTPHeaders = [
                                    "cookie": "SESSDATA=\(sessdata);"
                                ]
                                AF.request("https://api.bilibili.com/x/relation/modify", method: .post, parameters: ModifyUserRelation(fid: Int64(uid)!, act: isFollowed ? 2 : 1, csrf: biliJct), headers: headers).response { response in
                                    debugPrint(response)
                                    let json = try! JSON(data: response.data!)
                                    let code = json["code"].int!
                                    if code == 0 {
                                        tipWithText(isFollowed ? String(localized: "Account.tips.unfollowed") : String(localized: "Account.tips.followed"), symbol: "checkmark.circle.fill")
                                        isFollowed.toggle()
                                    } else {
                                        tipWithText(json["message"].string!, symbol: "xmark.circle.fill")
                                    }
                                }
                            }, label: {
                                Image(systemName: isFollowed ? "person.badge.minus" : "person.badge.plus")
                            })
                            VStack {
                                if dedeUserID == uid {
                                    HStack {
                                        Image(systemName: "b.circle")
                                            .font(.system(size: 12))
                                            .opacity(0.55)
                                            .offset(y: 1)
                                        if coinCount != -1 {
                                            Text(String(coinCount))
                                                .font(.system(size: 14))
                                        } else {
                                            Text("114")
                                                .font(.system(size: 14))
                                                .redacted(reason: .placeholder)
                                        }
                                    }
                                }
                                Button(action: {
                                    isInfoSheetPresented = true
                                }, label: {
                                    Text(officialType == -1 ? "Account.info" : "Account.certification")
                                })
                                .buttonStyle(.borderless)
                                .font(.caption)
                            }
                            Button(action: {
                                isSendbMessagePresented = true
                            }, label: {
                                Image(systemName: "ellipsis.bubble")
                            })
                        }
                    }
                    .navigationTitle(username)
                    .sheet(isPresented: $isInfoSheetPresented, content: {
                        ScrollView {
                            SecondPageBase(officialType: $officialType, officialTitle: $officialTitle, userSign: $userSign, userLevel: $userLevel, vipLabel: $vipLabel)
                        }
                    })
                    ScrollView {
                        VideosListBase(uid: uid, username: $username, videos: $videos, articles: $articles, viewSelector: $viewSelector, videoCount: $videoCount, articalCount: $articalCount)
                            .tag(2)
                            .navigationTitle(viewSelector == .video ? "Account.videos.\(videoCount)" : "Account.articals.\(articalCount)")
                            .toolbar {
                                ToolbarItem(placement: .topBarTrailing) {
                                    Button(action: {
                                        if viewSelector == .video {
                                            viewSelector = .article
                                        } else if viewSelector == .article {
                                            viewSelector = .video
                                        }
                                    }, label: {
                                        Image(systemName: viewSelector == .video ? "play.circle" : "doc.text.image")
                                    })
                                }
                            }
                    }
                }
                .tabViewStyle(.verticalPage)
                .containerBackground(Color.accentColor.gradient, for: .navigation)
            } else {
                TabView {
                    ScrollView {
                        FirstPageBase(uid: uid, userFaceUrl: $userFaceUrl, username: $username, followCount: $followCount, fansCount: $fansCount, coinCount: $coinCount, isFollowed: $isFollowed, isSendbMessagePresented: $isSendbMessagePresented)
                            .offset(y: -10)
                            .navigationTitle(username)
                            .tag(1)
                        SecondPageBase(officialType: $officialType, officialTitle: $officialTitle, userSign: $userSign, userLevel: $userLevel, vipLabel: $vipLabel)
                            .tag(2)
                    }
                    VideosListBase(uid: uid, username: $username, videos: $videos, articles: $articles, viewSelector: $viewSelector, videoCount: $videoCount, articalCount: $articalCount)
                        .tag(3)
                        .navigationTitle(viewSelector == .video ? "Account.videos.\(videoCount)" : "Account.articals.\(articalCount)")
                }
            }
        }
        .onAppear {
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata); buvid3=\(globalBuvid3);",
                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
            ]
            biliWbiSign(paramEncoded: "mid=\(uid)".base64Encoded()) { signed in
                if let signed {
                    debugPrint(signed)
                    autoRetryRequestApi("https://api.bilibili.com/x/space/wbi/acc/info?\(signed)", headers: headers) { respJson, isSuccess in
                        if isSuccess {
                            //debugPrint(respJson)
                            if !CheckBApiError(from: respJson) { return }
                            userFaceUrl = respJson["data"]["face"].string ?? "E"
//                            AF.request(respJson["data"]["face"].string ?? "E").response { response in
//                                let data = response.data!
//                                let mColor = ColorThief.getColor(from: UIImage(data: data)!)!.makeUIColor()
//                                debugPrint(mColor)
//                            }
                            username = respJson["data"]["name"].string ?? "[加载失败]"
                            userLevel = respJson["data"]["level"].int ?? 0
                            officialType = respJson["data"]["official"]["type"].int ?? -1
                            officialTitle = respJson["data"]["official"]["title"].string ?? ""
                            userSign = respJson["data"]["sign"].string ?? "[加载失败]"
                            coinCount = respJson["data"]["coins"].int ?? -1
                            vipLabel = respJson["data"]["vip"]["label"]["text"].string ?? ""
                            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/relation/stat?vmid=\(uid)", headers: headers) { respJson, isSuccess in
                                if isSuccess {
                                    followCount = respJson["data"]["following"].int ?? -1
                                    fansCount = respJson["data"]["follower"].int ?? -1
                                }
                            }
                        }
                    }
                }
            }
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/relation?fid=\(uid)", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    if !CheckBApiError(from: respJson) { return }
                    if respJson["data"]["attribute"].int ?? 0 == 2 || respJson["data"]["attribute"].int ?? 0 == 6 {
                        isFollowed = true
                    }
                }
            }
        }
    }
    
    struct FirstPageBase: View {
        var uid: String
        @Binding var userFaceUrl: String
        @Binding var username: String
        @Binding var followCount: Int
        @Binding var fansCount: Int
        @Binding var coinCount: Int
        @Binding var isFollowed: Bool
        @Binding var isSendbMessagePresented: Bool
        @AppStorage("DedeUserID") var dedeUserID = ""
        @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
        @AppStorage("SESSDATA") var sessdata = ""
        @AppStorage("bili_jct") var biliJct = ""
        var body: some View {
            VStack {
                Spacer()
                    .frame(height: 20)
                HStack {
                    Spacer()
                    CachedAsyncImage(url: URL(string: userFaceUrl + "@50w_50h"))
                        .cornerRadius(100)
                        .frame(width: 50, height: 50)
                    Spacer()
                }
                HStack {
                    Spacer()
                    VStack {
                        if followCount != -1 {
                            Text(String(followCount))
                                .font(.system(size: 14))
                        } else {
                            Text("114")
                                .font(.system(size: 14))
                                .redacted(reason: .placeholder)
                        }
                        Text("Account.subscribed")
                            .font(.system(size: 12))
                            .opacity(0.6)
                            .lineLimit(1)
                    }
                    Spacer()
                    VStack {
                        if fansCount != -1 {
                            Text(String(fansCount).shorter())
                                .font(.system(size: 14))
                        } else {
                            Text("114")
                                .font(.system(size: 14))
                                .redacted(reason: .placeholder)
                        }
                        Text("Account.followers")
                            .font(.system(size: 12))
                            .opacity(0.6)
                            .lineLimit(1)
                    }
                    Spacer()
                }
//                .padding(.horizontal, 40)
                if #unavailable(watchOS 10) {
                    if dedeUserID == uid {
                        HStack {
                            Image(systemName: "b.circle")
                                .font(.system(size: 12))
                                .opacity(0.55)
                                .offset(y: 1)
                            Text(String(coinCount))
                                .font(.system(size: 14))
                        }
                    }
                    Button(action: {
                        let headers: HTTPHeaders = [
                            "cookie": "SESSDATA=\(sessdata);",
                            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                        ]
                        AF.request("https://api.bilibili.com/x/relation/modify", method: .post, parameters: ModifyUserRelation(fid: Int64(uid)!, act: isFollowed ? 2 : 1, csrf: biliJct), headers: headers).response { response in
                            debugPrint(response)
                            let json = try! JSON(data: response.data!)
                            let code = json["code"].int!
                            if code == 0 {
                                tipWithText(isFollowed ? String(localized: "Account.tips.unfollowed") : String(localized: "Account.tips.followed"), symbol: "checkmark.circle.fill")
                                isFollowed.toggle()
                            } else {
                                tipWithText(json["message"].string!, symbol: "xmark.circle.fill")
                            }
                        }
                    }, label: {
                        HStack {
                            Image(systemName: isFollowed ? "person.badge.minus" : "person.badge.plus")
                            Text(isFollowed ? String(localized: "Account.unfollow") : String(localized: "Account.follow"))
                        }
                    })
                    NavigationLink("", isActive: $isSendbMessagePresented, destination: {bMessageSendView(uid: Int64(uid)!, username: username)})
                        .frame(width: 0, height: 0)
                    Button(action: {
                        isSendbMessagePresented = true
                    }, label: {
                        HStack {
                            Image(systemName: "ellipsis.bubble")
                            Text("Account.direct-message")
                        }
                    })
                }
            }
        }
    }
    struct SecondPageBase: View {
        @Binding var officialType: Int
        @Binding var officialTitle: String
        @Binding var userSign: String
        @Binding var userLevel: Int
        @Binding var vipLabel: String
        let levelColors = [Color(red: 192/255, green: 192/255, blue: 192/255), //0
                           Color(red: 192/255, green: 192/255, blue: 192/255), //1
                           Color(red: 155/255, green: 208/255, blue: 160/255), //2
                           Color(red: 142/255, green: 203/255, blue: 235/255), //3
                           Color(red: 244/255, green: 190/255, blue: 146/255), //4
                           Color(red: 222/255, green: 111/255, blue: 60/255), //5
                           Color(red: 234/255, green: 51/255, blue: 35/255)]  //6
        var body: some View {
            VStack {
                if officialType != -1 {
                    HStack {
                        Image(systemName: "bolt.circle")
                            .foregroundColor(officialType == 0 ? Color(hex: 0xFDD663) : Color(hex: 0xA0C0F4))
                            .frame(width: 20, height: 20)
                        Text("\(Text(String(localized: "Account.certification")).bold())\n\(officialTitle)")
                            .font(.system(size: 15))
                        Spacer()
                    }
                }
                if !vipLabel.isEmpty {
                    HStack {
                        WebImage(url: URL(string: "https://s1.hdslb.com/bfs/seed/jinkela/short/user-avatar/big-vip.svg"))
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text(vipLabel)
                            .font(.system(size: 15))
                            .bold()
                        Spacer()
                    }
                }
                HStack {
                    Image(systemName: "graduationcap.circle")
                        .foregroundColor(levelColors[userLevel])
                        .frame(width: 20, height: 20)
                    Text("Lv\(userLevel)")
                        .font(.system(size: 15))
                        .bold()
                    Spacer()
                }
                HStack {
                    VStack {
                        Image(systemName: "info.circle")
                            .foregroundColor(.secondary)
                            .frame(width: 20, height: 20)
                        Spacer()
                    }
                    Text(userSign)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
//                            .opacity(0.6)
                    Spacer()
                }
            }
            .padding()
        }
    }
    struct VideosListBase: View {
        var uid: String
        @Binding var username: String
        @Binding var videos: [[String: String]]
        @Binding var articles: [[String: String]]
        @Binding var viewSelector: UserDetailViewPubsType
        @Binding var videoCount: Int
        @Binding var articalCount: Int
        @AppStorage("DedeUserID") var dedeUserID = ""
        @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
        @AppStorage("SESSDATA") var sessdata = ""
        @AppStorage("bili_jct") var biliJct = ""
        @State var isNoVideo = false
        @State var isNoArticle = false
        @State var isVideosLoaded = false
        @State var isArticlesLoaded = false
        @State var videoTotalPage = 1
        @State var videoNowPage = 1
        @State var articleTotalPage = 1
        @State var articleNowPage = 1
        @State var isVideoPageJumpPresented = false
        @State var videoTargetJumpPageCache = ""
        @State var isArticalPageJumpPresented = false
        @State var articleTargetJumpPageCache = ""
        var body: some View {
            VStack {
                Group {
                    if #unavailable(watchOS 10) {
                        Button(action: {
                            if viewSelector == .video {
                                viewSelector = .article
                            } else if viewSelector == .article {
                                viewSelector = .video
                            }
                        }, label: {
                            HStack {
                                Image(systemName: viewSelector == .video ? "play.circle" : "doc.text.image")
                                Text(viewSelector == .video ? String(localized: "Account.check-videos") : String(localized: "Account.check-articles"))
                            }
                        })
                        Spacer()
                            .frame(height: 20)
                    }
                    if viewSelector == .video {
                        VStack {
                            if videos.count != 0 {
                                ForEach(0...videos.count - 1, id: \.self) { i in
                                    VideoCard(["Pic": videos[i]["PicUrl"]!, "Title": videos[i]["Title"]!, "BV": videos[i]["BV"]!, "UP": username, "View": videos[i]["PlayCount"]!, "Danmaku": videos[i]["DanmakuCount"]!])
                                }
                                Spacer()
                                    .frame(height: 20)
                                VStack {
                                    if videoNowPage != 1 {
                                        Button(action: {
                                            videoNowPage -= 1
                                            RefreshVideos()
                                        }, label: {
                                            Text("Account.list.last-page")
                                                .bold()
                                        })
                                    }
                                    Text("\(videoNowPage) / \(videoTotalPage)")
                                        .font(.system(size: 18, weight: .bold))
                                        .sheet(isPresented: $isVideoPageJumpPresented, content: {
                                            VStack {
                                                Text("Account.list.goto")
                                                    .font(.system(size: 20, weight: .bold))
                                                HStack {
                                                    TextField("Account.list.destination", text: $videoTargetJumpPageCache)
                                                        .onSubmit {
                                                            if let cInt = Int(videoTargetJumpPageCache) {
                                                                if cInt <= 0 {
                                                                    videoTargetJumpPageCache = "1"
                                                                }
                                                                if cInt > videoTotalPage {
                                                                    videoTargetJumpPageCache = String(videoTotalPage)
                                                                }
                                                            } else {
                                                                videoTargetJumpPageCache = String(videoNowPage)
                                                            }
                                                        }
                                                    Text(" / \(videoTotalPage)")
                                                }
                                                Button(action: {
                                                    if let cInt = Int(videoTargetJumpPageCache) {
                                                        videoNowPage = cInt
                                                        RefreshVideos()
                                                    }
                                                    isVideoPageJumpPresented = false
                                                }, label: {
                                                    Text("Account.list.go")
                                                })
                                            }
                                        })
                                        .onTapGesture {
                                            videoTargetJumpPageCache = String(videoNowPage)
                                            isVideoPageJumpPresented = true
                                        }
                                    if videoNowPage != videoTotalPage {
                                        Button(action: {
                                            videoNowPage += 1
                                            RefreshVideos()
                                        }, label: {
                                            Text("Account.list.next-page")
                                                .bold()
                                        })
                                    }
                                }
                            } else {
                                if isNoVideo {
                                    Text("Account.list.no-video")
                                } else {
                                    ProgressView()
                                }
                            }
                        }
                    } else if viewSelector == .article {
                        VStack {
                            if articles.count != 0 {
                                ForEach(0...articles.count - 1, id: \.self) { i in
                                    Button(action: {
                                        let session = ASWebAuthenticationSession(url: URL(string: "https://www.bilibili.com/read/cv\(articles[i]["CV"]!)")!, callbackURLScheme: nil) { _, _ in
                                            return
                                        }
                                        session.prefersEphemeralWebBrowserSession = true
                                        session.start()
                                    }, label: {
                                        VStack {
                                            Text(articles[i]["Title"]!)
                                                .font(.system(size: 16, weight: .bold))
                                                .lineLimit(3)
                                            HStack {
                                                VStack {
                                                    Text(articles[i]["Summary"]!)
                                                        .font(.system(size: 10, weight: .bold))
                                                        .lineLimit(3)
                                                        .foregroundColor(.gray)
                                                    HStack {
                                                        Text(articles[i]["Type"]!)
                                                            .font(.system(size: 10))
                                                            .lineLimit(1)
                                                            .foregroundColor(.gray)
                                                        Label(articles[i]["View"]!, systemImage: "eye.fill")
                                                            .font(.system(size: 10))
                                                            .lineLimit(1)
                                                            .foregroundColor(.gray)
                                                        Label(articles[i]["Like"]!, systemImage: "hand.thumbsup.fill")
                                                            .font(.system(size: 10))
                                                            .lineLimit(1)
                                                            .foregroundColor(.gray)
                                                    }
                                                }
                                                WebImage(url: URL(string: articles[i]["Pic"]! + "@60w"), options: [.progressiveLoad])
                                                    .cornerRadius(5)
                                            }
                                        }
                                    })
                                    .buttonBorderShape(.roundedRectangle(radius: 14))
                                }
                                
                                if articleNowPage != 1 {
                                    Button(action: {
                                        articleNowPage -= 1
                                        RefreshArticles()
                                    }, label: {
                                        Text("Account.list.last-page")
                                            .bold()
                                    })
                                }
                                Text("\(articleNowPage) / \(articleTotalPage)")
                                    .font(.system(size: 18, weight: .bold))
                                    .sheet(isPresented: $isArticalPageJumpPresented, content: {
                                        VStack {
                                            Text("Account.list.goto")
                                                .font(.system(size: 20, weight: .bold))
                                            HStack {
                                                TextField("Account.list.destination", text: $articleTargetJumpPageCache)
                                                    .onSubmit {
                                                        if let cInt = Int(articleTargetJumpPageCache) {
                                                            if cInt <= 0 {
                                                                articleTargetJumpPageCache = "1"
                                                            }
                                                            if cInt > articleTotalPage {
                                                                articleTargetJumpPageCache = String(articleTotalPage)
                                                            }
                                                        } else {
                                                            articleTargetJumpPageCache = String(articleNowPage)
                                                        }
                                                    }
                                                Text(" / \(articleTotalPage)")
                                            }
                                            Button(action: {
                                                if let cInt = Int(articleTargetJumpPageCache) {
                                                    articleNowPage = cInt
                                                    RefreshArticles()
                                                }
                                                isArticalPageJumpPresented = false
                                            }, label: {
                                                Text("Account.list.go")
                                            })
                                        }
                                    })
                                    .onTapGesture {
                                        articleTargetJumpPageCache = String(articleNowPage)
                                        isArticalPageJumpPresented = true
                                    }
                                if articleNowPage != articleTotalPage {
                                    Button(action: {
                                        articleNowPage += 1
                                        RefreshArticles()
                                    }, label: {
                                        Text("Account.list.next-page")
                                            .bold()
                                    })
                                }
                            } else {
                                if isNoArticle {
                                    Text("Account.list.no-article")
                                } else {
                                    ProgressView()
                                }
                            }
                        }
                        .onAppear {
                            RefreshArticles()
                        }
                        .onDisappear {
                            articles = [[String: String]]()
                        }
                    }
                }
            }
            .onAppear {
                if !isVideosLoaded {
                    RefreshVideos()
                }
            }
        }
        
        func RefreshVideos() {
            videos = [[String: String]]()
            let headers: HTTPHeaders = [
                //"accept": "*/*",
                //"accept-encoding": "gzip, deflate, br",
                //"accept-language": "zh-CN,zh;q=0.9",
                //"cookie": "\(sessdata == "" ? "" : "SESSDATA=\(sessdata); ")buvid3=\(globalBuvid3); b_nut=\(Date.now.timeStamp); buvid4=\(globalBuvid4);", 
                "cookie": "SESSDATA=\(sessdata); buvid_fp=e651c1a382430ea93631e09474e0b395; buvid3=\(UuidInfoc.gen()); buvid4=buvid4-failed-1",
                //"origin": "https://space.bilibili.com",
                //"referer": "https://space.bilibili.com/\(uid)/video",
                //"User-Agent": "Mozilla/5.0" // Bypass? drdar://gh/SocialSisterYi/bilibili-API-collect/issues/868/1859065874
                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
            ]
            // FIXME: Official Wbi crypto logic for this request seems different from other APIs, some IP can get but some can't. It's hard to fix ~_~
            biliWbiSign(paramEncoded: "mid=\(uid)&ps=50&pn=\(videoNowPage)&dm_img_list=[]&dm_img_str=V2ViR0wgMS4wIChPcGVuR0wgRVMgMi4wIENocm9taXVtKQ&dm_cover_img_str=VjNEIDQuMkJyb2FkY2".base64Encoded()) { signed in
                if let signed {
                    debugPrint(signed)
                    autoRetryRequestApi("https://api.bilibili.com/x/space/wbi/arc/search?\(signed)", headers: headers) { respJson, isSuccess in
                        if isSuccess {
                            debugPrint(respJson)
                            if !CheckBApiError(from: respJson) { return } 
                            let vlist = respJson["data"]["list"]["vlist"]
                            for video in vlist {
                                videos.append(["Title": video.1["title"].string ?? "[加载失败]", "Length": video.1["length"].string ?? "E", "PlayCount": String(video.1["play"].int ?? -1), "PicUrl": video.1["pic"].string ?? "E", "BV": video.1["bvid"].string ?? "E", "Timestamp": String(video.1["created"].int ?? 0), "DanmakuCount": String(video.1["video_review"].int ?? -1)])
                            }
                            debugPrint(respJson["data"]["page"]["count"].int ?? 0)
                            videoTotalPage = Int((respJson["data"]["page"]["count"].int ?? 0) / 50) + 1
                            videoCount = respJson["data"]["page"]["count"].int ?? 0
                            if !isVideosLoaded {
                                if videos.count == 0 {
                                    isNoVideo = true
                                }
                                isVideosLoaded = true
                            }
                        }
                    }
                }
            }
        }
        func RefreshArticles() {
            articles = [[String: String]]()
            let headers: HTTPHeaders = [
                "accept-language": "en,zh-CN;q=0.9,zh;q=0.8",
                "cookie": "SESSDATA=\(sessdata);buvid3=\(globalBuvid3); buvid4=\(globalBuvid4);",
                "User-Agent": "Mozilla/5.0" // Bypass? drdar://gh/SocialSisterYi/bilibili-API-collect/issues/868/1859065874
            ]
            biliWbiSign(paramEncoded: "mid=\(uid)&ps=30&pn=\(articleNowPage)&sort=publish_time&platform=web".base64Encoded()) { signed in
                if let signed {
                    debugPrint(signed)
                    DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/space/wbi/article?\(signed)", headers: headers) { respJson, isSuccess in
                        if isSuccess {
                            debugPrint(respJson)
                            if !CheckBApiError(from: respJson) { return } 
                            let articlesJson = respJson["data"]["articles"]
                            for article in articlesJson {
                                articles.append(["Title": article.1["title"].string ?? "[加载失败]", "Summary": article.1["summary"].string ?? "[加载失败]", "Type": article.1["categories"][0]["name"].string ?? "[加载失败]", "View": String(article.1["stats"]["view"].int ?? -1), "Like": String(article.1["stats"]["like"].int ?? -1), "Pic": article.1["image_urls"][0].string ?? "E", "CV": String(article.1["id"].int ?? 0)])
                            }
                            articleTotalPage = Int(respJson["data"]["count"].int ?? 0 / 30) + 1
                            articalCount = respJson["data"]["count"].int ?? 0
                            if !isArticlesLoaded {
                                if articles.count == 0 {
                                    isNoArticle = true
                                }
                                isArticlesLoaded = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    struct ModifyUserRelation: Codable {
        let fid: Int64
        let act: Int
        var re_src: Int = 11
        let csrf: String
    }
}

enum UserDetailViewPubsType {
    case video
    case article
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(uid: "356891781")
    }
}
