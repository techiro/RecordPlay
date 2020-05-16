import Cocoa
import AVFoundation
class ViewController: NSViewController,AVAudioRecorderDelegate,AVAudioPlayerDelegate {
    var recorder : AVAudioRecorder!
    var studentPlayer:AVAudioPlayer!
    var recordLogic = RecordLogic()
    var musicName = "sampleMusic"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func pushRecordBtn(_ sender: NSButton) {
        
        
        if sender.state == NSControl.StateValue.on{
            sender.image = NSImage(named: "NSTouchBarPauseTemplate")
            //録音準備
            let musicFolder = recordLogic.makeMusicFolder(with: musicName)
            //録音する音声ファイルを生成
            let recordFile = recordLogic.makeMusicFile(with: musicFolder)
            
            do{
                recorder = try AVAudioRecorder(url: recordFile, settings: [:])
                recorder!.delegate = self
                recorder!.prepareToRecord()
            }catch{
                print("Error initialize recorder, \(error.localizedDescription)")
            }
            
            //録音開始
            recorder!.record()
            
        }else{

            sender.image = NSImage(named: "NSTouchBarRecordStartTemplate")
            
            recorder!.stop()
        }
        
    }
    
    
    @IBAction func pushPlayBtn(_ sender: NSButton) {
        
        guard (recorder?.url != nil && recorder?.isRecording != true ) else {
                   sender.setNextState()
                   return
               }
        
        if sender.state == NSControl.StateValue.on{

                    do{
                        print("recorder!.url→\(recorder!.url)")
                        studentPlayer = try AVAudioPlayer(contentsOf: recorder!.url)
                        studentPlayer.delegate = self
                    }catch{
                        print(error.localizedDescription)
                    }
        //
                    studentPlayer.play()

                    sender.image = NSImage(named: "NSTouchBarPauseTemplate")
                    
                }else{
                    studentPlayer.pause()
                    sender.image = NSImage(named: "NSTouchBarPlayTemplate")
                }
        
    }
    
    

}

