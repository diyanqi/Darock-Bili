//
//  SkinDownloadView.swift
//  DarockBili Watch App
//
//  Created by WindowsMEMZ on 2023/7/29.
//

import SwiftUI
import Alamofire
import ZipArchive

struct SkinDownloadView: View {
    @Environment(\.dismiss) var dismiss
    var name: String
    var link: String
    @State var downloadProgress = 0.0
    @State var isUnzipping = false
    var body: some View {
        VStack {
            Text(isUnzipping ? "Skin.unzipping" : "Skin.downloading")
                .font(.system(size: 18, weight: .bold))
            ProgressView(value: downloadProgress, total: 1.0)
        }
        .onAppear {
            let destination: DownloadRequest.Destination = { _, _ in
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let fileURL = documentsURL.appendingPathComponent("skin/package.zip")
                return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
            }
            AF.download(link, to: destination)
                .downloadProgress { p in
                    downloadProgress = p.fractionCompleted
                }
                .response { r in
                    if r.error == nil, let filePath = r.fileURL?.path {
                        debugPrint(filePath)
                        isUnzipping = true
                        try! SSZipArchive.unzipFile(atPath: filePath, toDestination: filePath.replacingOccurrences(of: "package.zip", with: "") + name, overwrite: true, password: nil)
                        isUnzipping = false
                        debugPrint(AppFileManager(path: "skin").GetRoot() ?? [[:]])
                        dismiss()
                    } else {
                        debugPrint(r.error as Any)
                    }
                }
        }
    }
}

struct SkinDownloadView_Previews: PreviewProvider {
    static var previews: some View {
        SkinDownloadView(name: "", link: "")
    }
}
