//
//  VideoDetailView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/6/30.
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

import AVKit
import SwiftUI
import Marquee
import SFSymbol
import WatchKit
import DarockKit
import Alamofire
import SwiftyJSON
import AVFoundation
import CachedAsyncImage
import SDWebImageSwiftUI

struct VideoDetailView: View {
    public static var willPlayVideoLink = ""
    public static var willPlayVideoBV = ""
    public static var willPlayVideoCID: Int64 = 0
    @State var videoDetails: [String: String]
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @AppStorage("RecordHistoryTime") var recordHistoryTime = "into"
    @AppStorage("VideoGetterSource") var videoGetterSource = "official"
    @State var isLoading = false
    @State var isLiked = false
    @State var isCoined = false
    @State var isFavoured = false
    @State var isCoinViewPresented = false
    @State var videoPages = [[String: String]]()
    @State var goodVideos = [[String: String]]()
    @State var owner = [String: String]()
    @State var stat = [String: String]()
    @State var honors = [String]()
    @State var tags = [String]()
    @State var subTitles = [[String: String]]()
    @State var ownerFansCount = 0
    @State var nowPlayingCount = "0"
    @State var publishTime = ""
    @State var videoDesc = ""
    @State var isVideoPlayerPresented = false
    @State var isMoreMenuPresented = false
    @State var isDownloadPresented = false
    @State var isNowPlayingPresented = false
    @State var backgroundPicOpacity = 0.0
    @State var mainVerticalTabViewSelection = 1
    @State var videoPartShouldShowDownloadTip = false
    var body: some View {
        TabView {
            if #available(watchOS 10, *) {
                ZStack {
                    Group {
                        TabView(selection: $mainVerticalTabViewSelection) {
                            VStack {
                                NavigationLink("", isActive: $isNowPlayingPresented, destination: {AudioPlayerView(videoDetails: videoDetails, subTitles: subTitles)})
                                    .frame(width: 0, height: 0)
                                
                                DetailViewFirstPageBase(videoDetails: $videoDetails, videoPages: $videoPages, honors: $honors, subTitles: $subTitles, isLoading: $isLoading)
                                    .offset(y: 16)
                                    .toolbar {
                                        ToolbarItem(placement: .topBarTrailing) {
                                            Button(action: {
                                                isMoreMenuPresented = true
                                            }, label: {
                                                Image(systemName: "ellipsis")
                                            })
                                            .sheet(isPresented: $isMoreMenuPresented, content: {
                                                List {
                                                    Button(action: {
                                                        if videoPages.count <= 1 {
                                                            isDownloadPresented = true
                                                        } else {
                                                            videoPartShouldShowDownloadTip = true
                                                            mainVerticalTabViewSelection = 3
                                                            isMoreMenuPresented = false
                                                        }
                                                    }, label: {
                                                        Label("Video.download", systemImage: "arrow.down.doc")
                                                    })
                                                    Button(action: {
                                                        let headers: HTTPHeaders = [
                                                            "cookie": "SESSDATA=\(sessdata)",
                                                            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                                        ]
                                                        AF.request("https://api.bilibili.com/x/v2/history/toview/add", method: .post, parameters: ["bvid": videoDetails["BV"]!, "csrf": biliJct], headers: headers).response { response in
                                                            do {
                                                                let json = try JSON(data: response.data ?? Data())
                                                                if let code = json["code"].int {
                                                                    if code == 0 {
                                                                        tipWithText(String(localized: "Video.added"), symbol: SFSymbol.Checkmark.circleFill.rawValue)
                                                                    } else {
                                                                        tipWithText(json["message"].string ?? String(localized: "Video.unkonwn-error"), symbol: SFSymbol.Xmark.circleFill.rawValue)
                                                                    }
                                                                } else {
                                                                    tipWithText(String(localized: "Video.unkonwn-error"), symbol: SFSymbol.Xmark.circleFill.rawValue)
                                                                }
                                                            } catch {
                                                                tipWithText(String(localized: "Video.unkonwn-error"), symbol: SFSymbol.Xmark.circleFill.rawValue)
                                                            }
                                                        }
                                                    }, label: {
                                                        Label("Video.watch-later", systemImage: "memories.badge.plus")
                                                    })
                                                }
                                            })
                                        }
                                        ToolbarItemGroup(placement: .bottomBar) {
                                            Button(action: {
                                                isLoading = true
                                                
                                                if videoGetterSource == "official" {
                                                    let headers: HTTPHeaders = [
                                                        "cookie": "SESSDATA=\(sessdata)",
                                                        "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                                    ]
                                                    DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/view?bvid=\(videoDetails["BV"]!)", headers: headers) { respJson, isSuccess in
                                                            if !CheckBApiError(from: respJson) { return }
                                                            let cid = respJson["data"]["pages"][0]["cid"].int64!
                                                            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/player/playurl?platform=html5&bvid=\(videoDetails["BV"]!)&cid=\(cid)", headers: headers) { respJson, isSuccess in
                                                                if !CheckBApiError(from: respJson) { return }
                                                                VideoDetailView.willPlayVideoLink = respJson["data"]["durl"][0]["url"].string!.replacingOccurrences(of: "\\u0026", with: "&")
                                                                VideoDetailView.willPlayVideoCID = cid
                                                                VideoDetailView.willPlayVideoBV = videoDetails["BV"]!
                                                                isVideoPlayerPresented = true
                                                                isLoading = false
                                                            }
                                                        }
                                                } else if videoGetterSource == "injahow" {
                                                    DarockKit.Network.shared.requestString("https://api.injahow.cn/bparse/?bv=\(videoDetails["BV"]!.dropFirst().dropFirst())&p=1&type=video&q=32&format=mp4&otype=url") { respStr, isSuccess in
                                                        if isSuccess {
                                                            VideoDetailView.willPlayVideoLink = respStr
                                                            VideoDetailView.willPlayVideoBV = videoDetails["BV"]!
                                                            isNowPlayingPresented = true
                                                            isLoading = false
                                                        }
                                                    }
                                                }
                                            }, label: {
                                                Image(systemName: "waveform")
                                            })
                                            if videoPages.count <= 1 {
                                                Button(action: {
                                                    isLoading = true
                                                    debugPrint(videoDetails["BV"]!)
                                                    if videoGetterSource == "official" {
                                                        let headers: HTTPHeaders = [
                                                            "cookie": "SESSDATA=\(sessdata)",
                                                            "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                                        ]
                                                        DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/view?bvid=\(videoDetails["BV"]!)", headers: headers) { respJson, isSuccess in
                                                            if !CheckBApiError(from: respJson) { return }
                                                            let cid = respJson["data"]["pages"][0]["cid"].int64!
                                                            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/player/playurl?platform=html5&bvid=\(videoDetails["BV"]!)&cid=\(cid)", headers: headers) { respJson, isSuccess in
                                                                if !CheckBApiError(from: respJson) { return }
                                                                VideoDetailView.willPlayVideoLink = respJson["data"]["durl"][0]["url"].string!.replacingOccurrences(of: "\\u0026", with: "&")
                                                                VideoDetailView.willPlayVideoCID = cid
                                                                VideoDetailView.willPlayVideoBV = videoDetails["BV"]!
                                                                isVideoPlayerPresented = true
                                                                isLoading = false
                                                            }
                                                        }
                                                    } else if videoGetterSource == "injahow" {
                                                        DarockKit.Network.shared.requestString("https://api.injahow.cn/bparse/?bv=\(videoDetails["BV"]!.dropFirst().dropFirst())&p=1&type=video&q=32&format=mp4&otype=url") { respStr, isSuccess in
                                                            if isSuccess {
                                                                VideoDetailView.willPlayVideoLink = respStr
                                                                VideoDetailView.willPlayVideoBV = videoDetails["BV"]!
                                                                isVideoPlayerPresented = true
                                                                isLoading = false
                                                            }
                                                        }
                                                    }
                                                }, label: {
                                                    Image(systemName: "play.fill")
                                                })
                                                
                                            } else {
                                                Button(action: {
                                                    mainVerticalTabViewSelection = 3
                                                }, label: {
                                                    Image(systemName: "rectangle.stack")
                                                })
                                            }
                                        }
                                    }
                                    .tag(1)
                            }
                            DetailViewSecondPageBase(videoDetails: $videoDetails, owner: $owner, stat: $stat, honors: $honors, tags: $tags, videoDesc: $videoDesc, isLiked: $isLiked, isCoined: $isCoined, isFavoured: $isFavoured, isCoinViewPresented: $isCoinViewPresented, ownerFansCount: $ownerFansCount, nowPlayingCount: $nowPlayingCount, publishTime: $publishTime)
                                .tag(2)
                            if videoPages.count > 1 {
                                DetailViewVideoPartPageBase(videoDetails: $videoDetails, videoPages: $videoPages, isLoading: $isLoading, videoPartShouldShowDownloadTip: $videoPartShouldShowDownloadTip)
                                    .tag(3)
                            }
                        }
                        .tabViewStyle(.verticalPage)
                    }
                    .blur(radius: isLoading ? 14 : 0)
                    if isLoading {
                        Text("Video.analyzing")
                            .font(.title2)
                            .bold()
                    }
                }
                .sheet(isPresented: $isDownloadPresented, content: {VideoDownloadView(bvid: videoDetails["BV"]!, videoDetails: videoDetails)})
                .sheet(isPresented: $isVideoPlayerPresented, content: {
                    VideoPlayerView()
                        .navigationBarHidden(true)
                })
                .containerBackground(for: .navigation) {
                    if !isInLowBatteryMode {
                        ZStack {
                            CachedAsyncImage(url: URL(string: videoDetails["Pic"]!)) { phase in
                                switch phase {
                                case .empty:
                                    Color.black
                                case .success(let image):
                                    image
                                        .onAppear {
                                            backgroundPicOpacity = 1.0
                                        }
                                case .failure:
                                    Color.black
                                @unknown default:
                                    Color.black
                                }
                            }
                            .blur(radius: 20)
                            .opacity(backgroundPicOpacity)
                            .animation(.easeOut(duration: 1.2), value: backgroundPicOpacity)
                            Color.black
                                .opacity(0.4)
                        }
                    }
                }
                .tag(1)
            } else {
                ZStack {
                    Group {
                        ScrollView {
                            DetailViewFirstPageBase(videoDetails: $videoDetails, videoPages: $videoPages, honors: $honors, subTitles: $subTitles, isLoading: $isLoading)
                            DetailViewSecondPageBase(videoDetails: $videoDetails, owner: $owner, stat: $stat, honors: $honors, tags: $tags, videoDesc: $videoDesc, isLiked: $isLiked, isCoined: $isCoined, isFavoured: $isFavoured, isCoinViewPresented: $isCoinViewPresented, ownerFansCount: $ownerFansCount, nowPlayingCount: $nowPlayingCount, publishTime: $publishTime)
                        }
                    }
                    .blur(radius: isLoading ? 14 : 0)
                    if isLoading {
                        Text("Video.analyzing")
                            .font(.title2)
                            .bold()
                    }
                }
                .tag(1)
            }
            if #available(watchOS 10, *) {
                VideoCommentsView(oid: String(videoDetails["BV"]!.dropFirst().dropFirst()))
                    .containerBackground(for: .navigation) {
                        ZStack {
                            CachedAsyncImage(url: URL(string: videoDetails["Pic"]!))
                                .blur(radius: 20)
                            Color.black
                                .opacity(0.4)
                        }
                    }
                    .tag(2)
            } else {
                VideoCommentsView(oid: String(videoDetails["BV"]!.dropFirst().dropFirst()))
            }
            if goodVideos.count != 0 {
                List {
                    ForEach(0...goodVideos.count - 1, id: \.self) { i in
                        VideoCard(goodVideos[i])
                    }
                }
                .tag(3)
            }
        }
        .accentColor(.white)
        .animation(.smooth, value: isLoading)
        .navigationTitle("视频")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            let headers: HTTPHeaders = [
                "cookie": "SESSDATA=\(sessdata)",
                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
            ]
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/archive/has/like?bvid=\(videoDetails["BV"]!)", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    if respJson["data"].int ?? 0 == 1 {
                        isLiked = true
                    }
                }
            }
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/archive/coins?bvid=\(videoDetails["BV"]!)", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    if respJson["data"]["multiply"].int ?? 0 != 0 {
                        isCoined = true
                    }
                }
            }
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/v2/fav/video/favoured?aid=\(videoDetails["BV"]!)", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    if respJson["data"]["favoured"].bool ?? false == true {
                        isFavoured = true
                    }
                }
            }
            
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/archive/related?bvid=\(videoDetails["BV"]!)", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    let datas = respJson["data"]
                    for data in datas {
                        if data.1["bvid"].string == nil {
                            return
                        }
                        goodVideos.append(["Pic": data.1["pic"].string ?? "E", "Title": data.1["title"].string ?? "[加载失败]", "BV": data.1["bvid"].string!, "UP": data.1["owner"]["name"].string ?? "[加载失败]", "View": String(data.1["stat"]["view"].int ?? -1), "Danmaku": String(data.1["stat"]["danmaku"].int ?? -1)])
                    }
                }
            }
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/view?bvid=\(videoDetails["BV"]!)", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    debugPrint("----------Prints from VideoDetailView.onAppear.*.requsetJSON(*/view)----------")
                    debugPrint(respJson)
                    if !CheckBApiError(from: respJson) { return }
                    owner = ["Name": respJson["data"]["owner"]["name"].string ?? "[加载失败]", "Face": respJson["data"]["owner"]["face"].string ?? "E", "ID": String(respJson["data"]["owner"]["mid"].int64 ?? -1)]
                    stat = ["Like": String(respJson["data"]["stat"]["like"].int ?? -1), "Coin": String(respJson["data"]["stat"]["coin"].int ?? -1), "Favorite": String(respJson["data"]["stat"]["favorite"].int ?? -1)]
                    videoDesc = respJson["data"]["desc"].string ?? "[加载失败]".replacingOccurrences(of: "\\n", with: "\n")

                    // Publish time calculation
                    let df = DateFormatter()
                    df.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    let pubTimestamp = respJson["data"]["pubdate"].int ?? 1
                    publishTime = df.string(from: Date(timeIntervalSince1970: Double(pubTimestamp)))
                    
                    for _ in 1...4 {
                        honors.append("")
                    }
                    for honor in respJson["data"]["honor_reply"]["honor"] {
                        honors[honor.1["type"].int! - 1] = honor.1["desc"].string ?? "[加载失败]"
                    }
                    for page in respJson["data"]["pages"] {
                        videoPages.append(["CID": String(page.1["cid"].int ?? 0), "Index": String(page.1["page"].int ?? 0), "Title": page.1["part"].string ?? "[加载失败]"])
                    }
                    if let mid = respJson["data"]["owner"]["mid"].int {
                        DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/relation/stat?vmid=\(mid)", headers: headers) { respJson, isSuccess in
                            if isSuccess {
                                ownerFansCount = respJson["data"]["follower"].int ?? -1
                            }
                        }
                    }
                    if let cid = respJson["data"]["pages"][0]["cid"].int {
                        DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/player/online/total?bvid=\(videoDetails["BV"]!)&cid=\(cid)", headers: headers) { respJson, isSuccess in
                            if isSuccess {
                                nowPlayingCount = respJson["data"]["total"].string ?? "[加载失败]"
                            }
                        }
                        DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/player/v2?bvid=\(videoDetails["BV"]!)&cid=\(cid)", headers: headers) { respJson, isSuccess in
                            debugPrint("----------Prints from VideoDetailView.onAppear.*.requsetJSON(*/player/v2)----------")
                            debugPrint(respJson)
                            if let subTitleUrl = respJson["data"]["subtitle"]["subtitles"][0]["subtitle_url"].string {
                                DarockKit.Network.shared.requestJSON(subTitleUrl) { respJson, isSuccess in
                                    let subTitles = respJson["body"]
                                    for subTitle in subTitles {
                                        self.subTitles.append(["Start": String(subTitle.1["from"].double!), "End": String(subTitle.1["to"].double!), "Content": subTitle.1["content"].string!])
                                    }
                                }
                            }
                        }
                    }
                }
            }
            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/tag/archive/tags?bvid=\(videoDetails["BV"]!)", headers: headers) { respJson, isSuccess in
                if isSuccess {
                    debugPrint("----------Prints from VideoDetailView.onAppear.*.requsetJSON(*/tags)----------")
                    debugPrint(respJson)
                    for tag in respJson["data"] {
                        tags.append(tag.1["tag_name"].string ?? "[加载失败]")
                    }
                }
            }
            if recordHistoryTime == "into" {
                AF.request("https://api.bilibili.com/x/click-interface/web/heartbeat", method: .post, parameters: ["bvid": videoDetails["BV"]!, "mid": dedeUserID, "type": 3, "dt": 2, "play_type": 2, "csrf": biliJct], headers: headers).response { response in
                    debugPrint(response)
                }
            }
            
            if videoDetails["Title"]!.contains("<em class=\"keyword\">") {
                videoDetails["Title"] = "\(String(videoDetails["Title"]!.hasPrefix("<em class=\"keyword\">") ? "" : (videoDetails["Title"]!.split(separator: "<em class=\"keyword\">")[0])))\(String(videoDetails["Title"]!.split(separator: "<em class=\"keyword\">")[videoDetails["Title"]!.hasPrefix("<em class=\"keyword\">") ? 0 : 1].split(separator: "</em>")[0]))\(String(videoDetails["Title"]!.hasSuffix("</em>") ? "" : videoDetails["Title"]!.split(separator: "</em>")[1]))"
            }
        }
        .onDisappear {
            goodVideos = [[String: String]]()
            owner = [String: String]()
            stat = [String: String]()
            videoDesc = ""
            SDImageCache.shared.clearMemory()
        }
    }
    
    struct DetailViewFirstPageBase: View {
        @Binding var videoDetails: [String: String]
        @Binding var videoPages: [[String: String]]
        @Binding var honors: [String]
        @Binding var subTitles: [[String: String]]
        @Binding var isLoading: Bool
        @AppStorage("DedeUserID") var dedeUserID = ""
        @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
        @AppStorage("SESSDATA") var sessdata = ""
        @AppStorage("bili_jct") var biliJct = ""
        @AppStorage("VideoGetterSource") var videoGetterSource = "official"
        @State var isVideoPlayerPresented = false
        @State var isMoreMenuPresented = false
        @State var isDownloadPresented = false
        @State var isNowPlayingPresented = false
        @State var isCoverImageViewPresented = false
        var body: some View {
            VStack {
                Spacer()
                WebImage(url: URL(string: videoDetails["Pic"]! + "@240w_160h")!, options: [.progressiveLoad, .scaleDownLargeImages])
                    .placeholder {
                        RoundedRectangle(cornerRadius: 14)
                            .frame(width: 120, height: 80)
                            .foregroundColor(Color(hex: 0x3D3D3D))
                            .redacted(reason: .placeholder)
                    }
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 80)
                    .cornerRadius(14)
                    .shadow(color: .black.opacity(0.5), radius: 5, x: 1, y: 2)
                    .offset(y: 8)
                    .sheet(isPresented: $isCoverImageViewPresented, content: {ImageViewerView(url: videoDetails["Pic"]!)})
                    .onTapGesture {
                        isCoverImageViewPresented = true
                    }
                Spacer()
                    .frame(height: 20)
                HStack {
                    if honors.count >= 4 {
                        if honors[3] != "" {
                            HStack {
                                Image(systemName: SFSymbol.Flame.fill.rawValue)
                                Text("Video.trending")
                            }
                            .font(.system(size: 11))
                            .foregroundColor(.red)
                            .padding(5)
                            .background {
                                Capsule()
                                    .fill(.white)
                                    .opacity(0.3)
                            }
                        }
                    }
                    Marquee {
                        HStack {
                            Text(videoDetails["Title"]!)
                                .lineLimit(1)
                                .font(.system(size: 12, weight: .bold))
                                .multilineTextAlignment(.center)
                        }
                    }
                    .marqueeWhenNotFit(true)
                    .marqueeDuration(10)
                    .frame(height: 20)
                    .padding(.horizontal, 10)
                }
                Text(videoDetails["UP"]!)
                    .lineLimit(1)
                    .font(.system(size: 12))
                    .padding(.horizontal, 40)
                    .padding(.vertical, 0)
                    .opacity(0.65)
                Spacer()
                    .frame(height: 20)
                if #unavailable(watchOS 10) {
                    Button(action: {
                        isLoading = true
                        
                        if videoGetterSource == "official" {
                            let headers: HTTPHeaders = [
                                "cookie": "SESSDATA=\(sessdata)",
                                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                            ]
                            DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/web-interface/view?bvid=\(videoDetails["BV"]!)", headers: headers) { respJson, isSuccess in
                                if !CheckBApiError(from: respJson) { return }
                                let cid = respJson["data"]["pages"][0]["cid"].int64!
                                DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/player/playurl?platform=html5&bvid=\(videoDetails["BV"]!)&cid=\(cid)", headers: headers) { respJson, isSuccess in
                                    if !CheckBApiError(from: respJson) { return }
                                    VideoDetailView.willPlayVideoLink = respJson["data"]["durl"][0]["url"].string!.replacingOccurrences(of: "\\u0026", with: "&")
                                    VideoDetailView.willPlayVideoCID = cid
                                    VideoDetailView.willPlayVideoBV = videoDetails["BV"]!
                                    isVideoPlayerPresented = true
                                    isLoading = false
                                }
                            }
                        } else if videoGetterSource == "injahow" {
                            DarockKit.Network.shared.requestString("https://api.injahow.cn/bparse/?bv=\(videoDetails["BV"]!.dropFirst().dropFirst())&p=1&type=video&q=32&format=mp4&otype=url") { respStr, isSuccess in
                                if isSuccess {
                                    VideoDetailView.willPlayVideoLink = respStr
                                    VideoDetailView.willPlayVideoBV = videoDetails["BV"]!
                                    isVideoPlayerPresented = true
                                    isLoading = false
                                }
                            }
                        }
                    }, label: {
                        Label("Video.play", systemImage: "play.fill")
                    })
                    .sheet(isPresented: $isVideoPlayerPresented, content: {
                        VideoPlayerView()
                            .navigationBarHidden(true)
                    })
                    NavigationLink("", isActive: $isNowPlayingPresented, destination: {AudioPlayerView(videoDetails: videoDetails, subTitles: subTitles)})
                        .frame(width: 0, height: 0)
                    Button(action: {
                        isLoading = true
                        
                        if videoGetterSource == "official" {
                            let headers: HTTPHeaders = [
                                "cookie": "SESSDATA=\(sessdata)",
                                "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                            ]
                            AF.request("https://api.bilibili.com/x/web-interface/view?bvid=\(videoDetails["BV"]!)", headers: headers).response { response in
                                let cid = Int64((String(data: response.data!, encoding: .utf8)?.components(separatedBy: "\"pages\":[{\"cid\":")[1].components(separatedBy: ",")[0])!)!
                                VideoDetailView.willPlayVideoCID = cid
                                AF.request("https://api.bilibili.com/x/player/playurl?platform=html5&bvid=\(videoDetails["BV"]!)&cid=\(cid)", headers: headers).response { response in
                                    VideoDetailView.willPlayVideoLink = (String(data: response.data!, encoding: .utf8)?.components(separatedBy: ",\"url\":\"")[1].components(separatedBy: "\",")[0])!.replacingOccurrences(of: "\\u0026", with: "&")
                                    VideoDetailView.willPlayVideoBV = videoDetails["BV"]!
                                    isNowPlayingPresented = true
                                    isLoading = false
                                }
                            }
                        } else if videoGetterSource == "injahow" {
                            DarockKit.Network.shared.requestString("https://api.injahow.cn/bparse/?bv=\(videoDetails["BV"]!.dropFirst().dropFirst())&p=1&type=video&q=32&format=mp4&otype=url") { respStr, isSuccess in
                                if isSuccess {
                                    VideoDetailView.willPlayVideoLink = respStr
                                    VideoDetailView.willPlayVideoBV = videoDetails["BV"]!
                                    isNowPlayingPresented = true
                                    isLoading = false
                                }
                            }
                        }
                    }, label: {
                        Label("Video.play-in-audio", systemImage: "waveform")
                    })
                    Button(action: {
                        isMoreMenuPresented = true
                    }, label: {
                        Label("Video.more", systemImage: "ellipsis")
                    })
                    .sheet(isPresented: $isMoreMenuPresented, content: {
                        List {
                            Button(action: {
                                isDownloadPresented = true
                            }, label: {
                                Label("Video.download", image: "arrow.down.doc")
                            })
                            .sheet(isPresented: $isDownloadPresented, content: {VideoDownloadView(bvid: videoDetails["BV"]!, videoDetails: videoDetails)})
                            Button(action: {
                                let headers: HTTPHeaders = [
                                    "cookie": "SESSDATA=\(sessdata)",
                                    "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                ]
                                AF.request("https://api.bilibili.com/x/v2/history/toview/add", method: .post, parameters: ["bvid": videoDetails["BV"]!, "csrf": biliJct], headers: headers).response { response in
                                    do {
                                        let json = try JSON(data: response.data ?? Data())
                                        if let code = json["code"].int {
                                            if code == 0 {
                                                tipWithText(String(localized: "Video.added"), symbol: SFSymbol.Checkmark.circleFill.rawValue)
                                            } else {
                                                tipWithText(json["message"].string ?? String(localized: "Video.unkonwn-error"), symbol: SFSymbol.Xmark.circleFill.rawValue)
                                            }
                                        } else {
                                            tipWithText(String(localized: "Video.unkonwn-error"), symbol: SFSymbol.Xmark.circleFill.rawValue)
                                        }
                                    } catch {
                                        tipWithText(String(localized: "Video.unkonwn-error"), symbol: SFSymbol.Xmark.circleFill.rawValue)
                                    }
                                }
                            }, label: {
                                Label("Video.watch-later", systemImage: "memories.badge.plus")
                            })
                        }
                    })
                }
            }
        }
    }
    struct DetailViewSecondPageBase: View {
        @Binding var videoDetails: [String: String]
        @Binding var owner: [String: String]
        @Binding var stat: [String: String]
        @Binding var honors: [String]
        @Binding var tags: [String]
        @Binding var videoDesc: String
        @Binding var isLiked: Bool
        @Binding var isCoined: Bool
        @Binding var isFavoured: Bool
        @Binding var isCoinViewPresented: Bool
        @Binding var ownerFansCount: Int
        @Binding var nowPlayingCount: String
        @Binding var publishTime: String
        @AppStorage("DedeUserID") var dedeUserID = ""
        @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
        @AppStorage("SESSDATA") var sessdata = ""
        @AppStorage("bili_jct") var biliJct = ""
        @State var tagText = ""
        @State var ownerBlockOffset: CGFloat = 20
        @State var statLineOffset: CGFloat = 20
        @State var danmakuCountOffset: CGFloat = 20
        @State var nowWatchingCountOffset: CGFloat = 20
        @State var totalPlayedCountOffset: CGFloat = 20
        @State var publishTimeTextOffset: CGFloat = 20
        @State var bvidTextOffset: CGFloat = 20
        @State var descOffset: CGFloat = 20
        @State var tagOffset: CGFloat = 20
        @State var isFavoriteChoosePresented = false
        @State var tagDisplayedNum = 0
        var body: some View {
            ScrollView {
                VStack {
                    if owner["ID"] != nil {
                        NavigationLink(destination: {UserDetailView(uid: owner["ID"]!)}, label: {
                            HStack {
                                AsyncImage(url: URL(string: owner["Face"]! + "@40w"))
                                    .cornerRadius(100)
                                    .frame(width: 40, height: 40)
                                VStack {
                                    HStack {
                                        Text(owner["Name"]!)
                                            .font(.system(size: 16, weight: .bold))
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.1)
                                        Spacer()
                                    }
                                    HStack {
                                        Text("Video.fans.\(Int(String(ownerFansCount).shorter()) ?? 0)")
                                            .font(.system(size: 11))
                                            .lineLimit(1)
                                            .opacity(0.6)
                                        Spacer()
                                    }
                                }
                                Spacer()
                            }
                        })
                        .buttonBorderShape(.roundedRectangle(radius: 18))
                        .offset(y: ownerBlockOffset)
                        .animation(.easeOut(duration: 0.3), value: ownerBlockOffset)
                        .onAppear {
                            ownerBlockOffset = 0
                        }
                        .accessibilityIdentifier("AuthorDetailButton")
                    }
                    LazyVStack {
                        HStack {
                            Button(action: {
                                let headers: HTTPHeaders = [
                                    "cookie": "SESSDATA=\(sessdata); buvid3=\(globalBuvid3)",
                                    "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                ]
                                AF.request("https://api.bilibili.com/x/web-interface/archive/like", method: .post, parameters: ["bvid": videoDetails["BV"]!, "like": isLiked ? 2 : 1, "eab_x": 2, "ramval": 0, "source": "web_normal", "ga": 1, "csrf": biliJct], headers: headers).response { response in
                                    debugPrint(response)
                                    isLiked ? tipWithText(String(localized: "Video.action.canceled"), symbol: "checkmark.circle.fill") : tipWithText(String(localized: "Video.action.liked"), symbol: "checkmark.circle.fill")
                                    isLiked.toggle()
                                }
                            }, label: {
                                VStack {
                                    Image(systemName: isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
                                        .foregroundColor(isLiked ? Color(hex: 0xfa678e)  : .white)
                                    Text(stat["Like"]?.shorter() ?? "")
                                        .font(.system(size: 11))
                                        .foregroundColor(isLiked ? Color(hex: 0xfa678e)  : .white)
                                        .opacity(isLiked ? 1 : 0.6)
                                        .minimumScaleFactor(0.1)
                                        .scaledToFit()
                                }
                            })
                            .buttonBorderShape(.roundedRectangle(radius: 18))
                            Button(action: {
                                if !isCoined {
                                    isCoinViewPresented = true
                                }
                            }, label: {
                                VStack {
                                    Image(systemName: isCoined ? "b.circle.fill" : "b.circle")
                                        .foregroundColor(isCoined ? Color(hex: 0xfa678e)  : .white)
                                        .bold()
                                    Text(stat["Coin"]?.shorter() ?? "")
                                        .font(.system(size: 11))
                                        .foregroundColor(isCoined ? Color(hex: 0xfa678e)  : .white)
                                        .opacity(isCoined ? 1 : 0.6)
                                        .minimumScaleFactor(0.1)
                                        .scaledToFit()
                                }
                            })
                            .buttonBorderShape(.roundedRectangle(radius: 18))
                            .sheet(isPresented: $isCoinViewPresented, content: {VideoThrowCoinView(bvid: videoDetails["BV"]!)})
                            Button(action: {
                                isFavoriteChoosePresented = true
                            }, label: {
                                VStack {
                                    Image(systemName: isFavoured ? "star.fill" : "star")
                                        .foregroundColor(isFavoured ? Color(hex: 0xf9678f) : .white)
                                    Text(stat["Favorite"]?.shorter() ?? "")
                                        .font(.system(size: 11))
                                        .foregroundColor(isFavoured ? Color(hex: 0xfa678e)  : .white)
                                        .opacity(isFavoured ? 1 : 0.6)
                                        .minimumScaleFactor(0.1)
                                        .scaledToFit()
                                }
                            })
                        }
                        .buttonBorderShape(.roundedRectangle(radius: 18))
                        .offset(y: statLineOffset)
                        .animation(.easeOut(duration: 0.4), value: statLineOffset)
                        .onAppear {
                            statLineOffset = 0
                        }
                        .sheet(isPresented: $isFavoriteChoosePresented, content: {VideoFavoriteAddView(videoDetails: $videoDetails, isFavoured: $isFavoured)})
                        Spacer()
                            .frame(height: 10)
                        VStack {
                            HStack {
                                Image(systemName: "text.word.spacing")
                                Text("Video.details.danmaku.\(Int(videoDetails["Danmaku"]!.shorter()) ?? 0)")
                                Spacer()
                            }
                            .offset(y: danmakuCountOffset)
                            .animation(.easeOut(duration: 0.55), value: danmakuCountOffset)
                            .onAppear {
                                danmakuCountOffset = 0
                            }
                            HStack {
                                Image(systemName: "person.2")
                                Text("Video.details.watching-people.\(Int(nowPlayingCount) ?? 0)")
                                    .offset(x: -1)
                                Spacer()
                            }
                            .offset(x: -2, y: nowWatchingCountOffset)
                            .animation(.easeOut(duration: 0.65), value: nowWatchingCountOffset)
                            .onAppear {
                                nowWatchingCountOffset = 0
                            }
                            HStack {
                                Image(systemName: "play.circle")
                                Text("Video.details.watches.\(Int(videoDetails["View"]!.shorter()) ?? 0)")
                                    .offset(x: 1)
                                Spacer()
                            }
                            .offset(y: totalPlayedCountOffset)
                            .animation(.easeOut(duration: 0.75), value: totalPlayedCountOffset)
                            .onAppear {
                                totalPlayedCountOffset = 0
                            }
                            HStack {
                                Image(systemName: "clock")
                                Text("Video.details.publish-time.\(publishTime)")
                                Spacer()
                            }
                            .offset(y: publishTimeTextOffset)
                            .animation(.easeOut(duration: 0.85), value: publishTimeTextOffset)
                            .onAppear {
                                publishTimeTextOffset = 0
                            }
                            HStack {
                                Image(systemName: "movieclapper")
                                Text(videoDetails["BV"]!)
                                Spacer()
                            }
                            .offset(x: -1, y: bvidTextOffset)
                            .animation(.easeOut(duration: 0.85), value: bvidTextOffset)
                            .onAppear {
                                bvidTextOffset = 0
                            }
                        }
                        .font(.system(size: 11))
                        .opacity(0.6)
                        .padding(.horizontal, 10)
                        Spacer()
                            .frame(height: 5)
                        HStack {
                            VStack {
                                Image(systemName: "info.circle")
                                Spacer()
                            }
                            Text(videoDesc)
                            Spacer()
                        }
                        .font(.system(size: 12))
                        .opacity(0.65)
                        .padding(.horizontal, 8)
                        .offset(y: descOffset)
                        .animation(.easeOut(duration: 0.4), value: descOffset)
                        .onAppear {
                            descOffset = 0
                        }
                        /* Text(videoDesc)
                            .font(.system(size: 12))
                            .opacity(0.65)
                            .padding(.horizontal, 8)
                            .offset(y: descOffset)
                            .animation(.easeOut(duration: 0.4), value: descOffset)
                            .onAppear {
                                descOffset = 0
                            } */
                        HStack {
                            VStack {
                                Image(systemName: "tag")
                                Spacer()
                            }
                            Text(tagText)
                            Spacer()
                        }
                        .font(.system(size: 12))
                        .opacity(0.65)
                        .padding(.horizontal, 8)
                        .offset(y: descOffset)
                        .animation(.easeOut(duration: 0.4), value: descOffset)
                        .onAppear {
                            tagDisplayedNum = 0
                            tagOffset = 0
                            tagText = ""
                            for text in tags {
                                tagDisplayedNum += 1
                                if tagDisplayedNum == tags.count {
                                    tagText += text
                                } else {
                                    tagText += text + " / "
                                }
                            }
                        }
                    }
                }
            }
        }

        struct VideoFavoriteAddView: View {
            @Binding var videoDetails: [String: String]
            @Binding var isFavoured: Bool
            @Environment(\.dismiss) var dismiss
            @AppStorage("DedeUserID") var dedeUserID = ""
            @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
            @AppStorage("SESSDATA") var sessdata = ""
            @AppStorage("bili_jct") var biliJct = ""
            @State var favoriteFolderList = [[String: String]]()
            @State var isFavoriteTargetIn = [Bool]()
            @State var isItemLoading = [Bool]()
            var body: some View {
                NavigationStack {
                    List {
                        if isItemLoading.count != 0 {
                            ForEach(0..<favoriteFolderList.count, id: \.self) { i in
                                Button(action: {
                                    isItemLoading[i] = true
                                    let headers: HTTPHeaders = [
                                        "cookie": "SESSDATA=\(sessdata);",
                                        "referer": "https://www.bilibili.com/video/\(videoDetails["BV"]!)/",
                                        "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                    ]
                                    let avid = bv2av(bvid: videoDetails["BV"]!)
                                    AF.request("https://api.bilibili.com/x/v3/fav/resource/deal", method: .post, parameters: ["rid": avid, "type": 2, "\(isFavoriteTargetIn[i] ? "del" : "add")_media_ids": Int(favoriteFolderList[i]["ID"]!)!, "csrf": biliJct], headers: headers).response { response in
                                        debugPrint(response)
                                        if let rpd = response.data {
                                            if !CheckBApiError(from: try! JSON(data: rpd)) {
                                                isItemLoading[i] = false
                                                return
                                            }
                                            isFavoriteTargetIn[i].toggle()
                                            isFavoured = false
                                            for i in isFavoriteTargetIn {
                                                if i {
                                                    isFavoured = true
                                                    break
                                                }
                                            }
                                        }
                                        isItemLoading[i] = false
                                     }
                                }, label: {
                                    HStack {
                                        if !isItemLoading[i] {
                                            if isFavoriteTargetIn[i] {
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(Color.blue)
                                            }
                                            Text(favoriteFolderList[i]["Title"]!)
                                        } else {
                                            Spacer()
                                            ProgressView()
                                            Spacer()
                                        }
                                    }
                                })
                            }
                        } else {
                            HStack {
                                Spacer()
                                ProgressView()
                                Spacer()
                            }
                        }
                    }
                    .navigationTitle(String(localized: "Video.add-to-favorites"))
                    .navigationBarTitleDisplayMode(.inline)
                }
                .onAppear {
                    let headers: HTTPHeaders = [
                        "cookie": "SESSDATA=\(sessdata);",
                        "User-Agent": "Mozilla/5.0"
                    ]
                    let avid = bv2av(bvid: videoDetails["BV"]!)
                    DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/v3/fav/folder/created/list-all?type=2&rid=\(avid)&up_mid=\(dedeUserID)", headers: headers) { respJson, isSuccess in
                        if isSuccess {
                            if !CheckBApiError(from: respJson) { return }
                            for folder in respJson["data"]["list"] {
                                favoriteFolderList.append(["ID": String(folder.1["id"].int ?? 0), "Title": folder.1["title"].string ?? "", "Count": String(folder.1["media_count"].int ?? 0)])
                                isFavoriteTargetIn.append((folder.1["fav_state"].int ?? 0) == 0 ? false : true)
                                isItemLoading.append(false)
                            }
                        }
                    }
                }
            }
        }
    }
    struct DetailViewVideoPartPageBase: View {
        @Binding var videoDetails: [String: String]
        @Binding var videoPages: [[String: String]]
        @Binding var isLoading: Bool
        @Binding var videoPartShouldShowDownloadTip: Bool
        @AppStorage("DedeUserID") var dedeUserID = ""
        @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
        @AppStorage("SESSDATA") var sessdata = ""
        @AppStorage("bili_jct") var biliJct = ""
        @AppStorage("VideoGetterSource") var videoGetterSource = "official"
        @State var isVideoPlayerPresented = false
        @State var downloadTipOffset: CGFloat = 0.0
        @State var downloadTipOpacity: CGFloat = 1.0
        @State var isDownloadPresented = false
        var body: some View {
            List {
                if videoPages.count != 0 {
                    ForEach(0..<videoPages.count, id: \.self) { i in
                        Button(action: {
                            isLoading = true
                            
                            if videoGetterSource == "official" {
                                let headers: HTTPHeaders = [
                                    "cookie": "SESSDATA=\(sessdata)",
                                    "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                ]
                                let cid = videoPages[i]["CID"]!
                                VideoDetailView.willPlayVideoCID = Int64(cid)!
                                DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/player/playurl?platform=html5&bvid=\(videoDetails["BV"]!)&cid=\(cid)", headers: headers) { respJson, isSuccess in
                                    if isSuccess {
                                        if !CheckBApiError(from: respJson) { return }
                                        VideoDetailView.willPlayVideoLink = respJson["data"]["durl"][0]["url"].string!.replacingOccurrences(of: "\\u0026", with: "&")
                                        VideoDetailView.willPlayVideoBV = videoDetails["BV"]!
                                        isVideoPlayerPresented = true
                                        isLoading = false
                                    }
                                }
                            } else if videoGetterSource == "injahow" {
                                DarockKit.Network.shared.requestString("https://api.injahow.cn/bparse/?bv=\(videoDetails["BV"]!.dropFirst().dropFirst())&p=\(i + 1)&type=video&q=32&format=mp4&otype=url") { respStr, isSuccess in
                                    if isSuccess {
                                        VideoDetailView.willPlayVideoLink = respStr
                                        VideoDetailView.willPlayVideoBV = videoDetails["BV"]!
                                        isVideoPlayerPresented = true
                                        isLoading = false
                                    }
                                }
                            }
                        }, label: {
                            ZStack {
                                HStack {
                                    Text(String(i + 1))
                                    Text(videoPages[i]["Title"]!)
                                    Spacer()
                                }
                                if videoPartShouldShowDownloadTip && i == 0 {
                                    HStack {
                                        Spacer()
                                        Image(systemName: "hand.point.up.left")
                                            .font(.system(size: 30))
                                            .offset(x: downloadTipOffset, y: 10)
                                            .opacity(downloadTipOpacity)
                                            .animation(.easeOut(duration: 2.0), value: downloadTipOffset)
                                            .animation(.easeIn(duration: 1.0), value: downloadTipOpacity)
                                            .onAppear {
                                                DispatchQueue(label: "com.darock.DarockBili.PartVideoDownloadTip", qos: .userInteractive).async {
                                                    downloadTipOffset = -40
                                                    sleep(3)
                                                    downloadTipOpacity = 0
                                                    sleep(1)
                                                    videoPartShouldShowDownloadTip = false
                                                }
                                            }
                                    }
                                }
                            }
                        })
                        .swipeActions {
                            Button(action: {
                                if videoGetterSource == "official" {
                                    let headers: HTTPHeaders = [
                                        "cookie": "SESSDATA=\(sessdata)",
                                        "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                                    ]
                                    let cid = videoPages[i]["CID"]!
                                    VideoDetailView.willPlayVideoCID = Int64(cid)!
                                    DarockKit.Network.shared.requestJSON("https://api.bilibili.com/x/player/playurl?platform=html5&bvid=\(videoDetails["BV"]!)&cid=\(cid)", headers: headers) { respJson, isSuccess in
                                        if isSuccess {
                                            if !CheckBApiError(from: respJson) { return }
                                            VideoDownloadView.downloadLink = respJson["data"]["durl"][0]["url"].string!.replacingOccurrences(of: "\\u0026", with: "&")
                                            isDownloadPresented = true
                                        }
                                    }
                                } else if videoGetterSource == "injahow" {
                                    DarockKit.Network.shared.requestString("https://api.injahow.cn/bparse/?bv=\(videoDetails["BV"]!.dropFirst().dropFirst())&p=\(i + 1)&type=video&q=32&format=mp4&otype=url") { respStr, isSuccess in
                                        if isSuccess {
                                            VideoDownloadView.downloadLink = respStr
                                            isDownloadPresented = true
                                        }
                                    }
                                }
                            }, label: {
                                Image(systemName: "arrow.down.doc")
                            })
                        }
                    }
                }
            }
            .sheet(isPresented: $isDownloadPresented, content: {VideoDownloadView(bvid: videoDetails["BV"]!, videoDetails: videoDetails)})
            .sheet(isPresented: $isVideoPlayerPresented, content: {
                VideoPlayerView()
                    .navigationBarHidden(true)
            })
        }
    }
}

struct VideoThrowCoinView: View {
    var bvid: String
    @Environment(\.dismiss) var dismiss
    @AppStorage("DedeUserID") var dedeUserID = ""
    @AppStorage("DedeUserID__ckMd5") var dedeUserID__ckMd5 = ""
    @AppStorage("SESSDATA") var sessdata = ""
    @AppStorage("bili_jct") var biliJct = ""
    @State var choseCoin = 2
    var body: some View {
        VStack {
            Picker("Video.coin.throw", selection: $choseCoin) {
                Label("Video.coin.throw.1", systemImage: "circlebadge")
                    .tag(1)
                Label("Video.coin.throw.2", systemImage: "circlebadge.2")
                    .tag(2)
            }
            .pickerStyle(.wheel)
            /* HStack {
                Button(action: {
                    choseCoin = 1
                }, label: {
                    Image("Coin1Icon")
                        .resizable()
                })
                .frame(width: 86, height: 126.5)
                .buttonBorderShape(.roundedRectangle(radius: 8))
                .border(choseCoin == 1 ? .blue : .black, width: 5)
                Button(action: {
                    choseCoin = 2
                }, label: {
                    Image("Coin2Icon")
                        .resizable()
                })
                .frame(width: 86, height: 126.5)
                .buttonBorderShape(.roundedRectangle(radius: 8))
                .border(choseCoin == 2 ? .blue : .black, width: 5)
            } */
            Button(action: {
                let headers: HTTPHeaders = [
                    "cookie": "SESSDATA=\(sessdata)",
                    "User-Agent": "Mozilla/5.0 (X11; CrOS x86_64 14541.0.0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36"
                ]
                AF.request("https://api.bilibili.com/x/web-interface/coin/add", method: .post, parameters: BiliVideoCoin(bvid: bvid, multiply: choseCoin, csrf: biliJct), headers: headers).response { response in
                    debugPrint(response)
                    dismiss()
                }
            }, label: {
                Text("Video.coin.throw")
            })
        }
    }
}

struct BiliVideoLike: Codable {
    let bvid: String
    let like: Int
    let csrf: String
}
struct BiliVideoCoin: Codable {
    let bvid: String
    let multiply: Int
    var select_like: Int = 0
    let csrf: String
}
struct BiliVideoFavourite: Codable {
    let rid: UInt64
    var type: Int = 2
    var add_media_ids: Int? = nil
    var del_media_ids: Int? = nil
    let csrf: String
}

struct VideoDetailView_Previews: PreviewProvider {
    static var previews: some View {
        VideoDetailView(videoDetails: ["Pic": "http://i1.hdslb.com/bfs/archive/453a7f8deacb98c3b083ead733291f080383723a.jpg", "Title": "解压视频：20000个小球Marble run动画", "BV": "BV1PP41137Px", "UP": "小球模拟", "View": "114514", "Danmaku": "1919810"])
    }
}
