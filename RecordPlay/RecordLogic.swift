
import Foundation

struct RecordLogic {
    
    let format:DateFormatter!
    
    init() {
        self.format = DateFormatter()
        format.timeStyle = .full
        format.dateStyle = .long
        format.locale = Locale(identifier: "ja_JP")
    }
    //MARK: -Saving Recording Data
    
    mutating func makeMusicFolder(with musicName:String) -> String{
//        let saveDir = FileManager.default.currentDirectoryPath + "/Music/" + musicName
        let saveDir = NSHomeDirectory() + "/Music/RecordPlay/" + musicName

        do {
            try FileManager.default.createDirectory( atPath: saveDir, withIntermediateDirectories: true, attributes: nil)


        } catch {
            print("Error makeing Record Data Folder,\(error)")
        }
        
        return saveDir
    }
    
    func makeMusicFile(with musicFolder:String) -> URL{
        //fileのパスを生成
          let saveFileName = returnFileName(with: Date()) + ".caf"
          let filePath = musicFolder + "/" + saveFileName
          let stringurl = "file://" + filePath
//          fileURL = URL(fileURLWithPath: documentDirPath)
          //fileのパスをStringからURLに変換
          let encodeUrlString = stringurl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
          return URL(string: encodeUrlString)!
    }

    
    

    func returnFileName(with now:Date) -> String {
        let str = self.format.string(from: now)
        let longdata = str.replacingCharacters(in: str.range(of: "日本標準時")!, with: "")
        return longdata.components(separatedBy: CharacterSet.whitespaces).joined()
    }

    
}
