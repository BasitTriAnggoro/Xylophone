//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVAudioPlayer?
//    var soundName = ["C","D","E","F","G","A","B"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        playSound(soundName : sender.currentTitle!)
        sender.alpha = 0.5
        /*dispatchQueue : objek yang mengelola eksekusi secara serial atau bersamaan di thread utama / latar belakang */
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
            sender.alpha = 1
        }
    }
    
    func playSound(soundName: String){
        /*BUNDLE merujuk pada kumpulan file dan sumber daya yang dikelola sebagai satu unit. Biasanya digunakan untuk
         mengorganisasi file yang terkait dengan aplikasi, seperti gambar, video, suara, storyboard, dan file lainnya yang
         diperlukan untuk menjalankan aplikasi*/
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav") else { return }
        
        do{
            /*AVAudioSession digunakan untuk mengelola pengaturan audio dalam aplikasi iOS dan macOS. Untuk mengatur/mengonfigurasi
             kategori audio, mode, dan pengaturan input/output suara.*/
            /*Dalam konteks AVAudioSession, metode sharedInstance() digunakan untuk mendapatkan satu-satunya instance (singleton)
             dari AVAudioSession yang digunakan oleh aplikasi. Singleton adalah pola desain yang memastikan bahwa hanya ada satu
             instance dari sebuah kelas, dan instance tersebut bisa diakses dari mana saja dalam aplikasi.Dengan memanggil
             sharedInstance(), kita mendapatkan akses ke AVAudioSession yang sudah diinisialisasi oleh sistem,
             bisa digunakan untuk mengatur kategori audio, mode, atau mengelola input/output audio aplikasi.*/
            try AVAudioSession.sharedInstance().setCategory(.playback, mode:.default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            // work on iOS 11 player, earlier: AVFileTypeMPEGLayer3
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            guard let player = player else { return }
            player.play()
        }catch let error{
            print(error.localizedDescription)
        }
    }
    
    

}

