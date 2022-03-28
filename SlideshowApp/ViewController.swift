
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var SusumuButton: UIButton!
    @IBOutlet weak var ModoruButton: UIButton!
    @IBOutlet weak var StartStopButton: UIButton!
    @IBOutlet weak var ImageViewButton: UIButton!
    @IBOutlet weak var ImageView: UIImageView!
    
    var PicturesIndex:Int = 0//写真の配列管理用インデックスを宣言
    var timer: Timer!//スライドショーにしようするタイマーを宣言
    var timer_sec: Float = 0//スライドショーを2秒ごとに管理するための時間宣言
    var SlideShowStarting: Bool = false//自動スライドショー中かどうかの判定用Bool。自動スライドショーが始まっていたらtrueになる

    var ImageGallery:[UIImage] = //スライドショーに表示させる画像を宣言
    [
        UIImage(named: "HongKong01")!,//0
        UIImage(named: "HongKong02")!,//1
        UIImage(named: "HongKong03")!//2
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        FirstImage()
    }
    
    func SusumuImage()
    {
        PicturesIndex += 1
        if(PicturesIndex == ImageGallery.count)
        {PicturesIndex = 0}//もしPicturesIndexが3になったら、ImageGalleryのマックス数と同じなので0に戻す＝最初の画像に戻す
        ImageViewButton.setImage(ImageGallery[PicturesIndex], for: .normal)
        ImageView.image = ImageGallery[PicturesIndex]
    }

    func ModoruImage()
    {
        PicturesIndex -= 1
        if(PicturesIndex == -1)
        {PicturesIndex = 2}//もしPicturesIndexが-1になったら、2につながる＝最後の画像に飛ぶ
        ImageViewButton.setImage(ImageGallery[PicturesIndex], for: .normal)
        ImageView.image = ImageGallery[PicturesIndex]

    }
    
    @objc func updateImage(_ timer: Timer)//画像を自動スライドするためのタイマーの管理。2.0秒ごとに呼び出される
    {
        self.SusumuImage()
    }
    
    func FirstImage()//進むや戻るを押す前のデフォルト状態
    {
        ImageView.image = ImageGallery[PicturesIndex]
    }


    @IBAction func Susumu(_ sender: Any)
    {
        if SlideShowStarting == false//自動スライドショー中は押せないようにBoolで管理
        {
            SusumuImage()//@objc func SusumuImage()を呼び出している
        }
    }
    
    @IBAction func Modoru(_ sender: Any)
    {
        if SlideShowStarting == false//自動スライドショー中は押せないようにBoolで管理
        {
            ModoruImage()//@objc func ModoruImage()を呼び出している
        }
    }
    
    @IBAction func StartStop(_ sender: Any)//再生/停止ボタン
    {
        if self.timer != nil //nilじゃなかったら（つまり自動スライドショーがスタートしたあとだったら）停止する
        {
            self.timer.invalidate()
            self.timer = nil
            SlideShowStarting = false//自動スライドショー中かどうかの判定用Boolをfalseにする
        }
        else //nilだったら（つまり自動スライドショーがスタートしてなかったら）タイマー作動
        {//2秒ごとにupdateImageを呼び出す
            self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(updateImage(_:)), userInfo: nil, repeats: true)
            SlideShowStarting = true//自動スライドショー中かどうかの判定用Boolをtrueにする
        }
    }
    
    @IBAction func unwind(_ segue: UIStoryboardSegue){}
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?)
    {
        let bigViewController:BigViewController = segue.destination as! BigViewController
        bigViewController.BigPicture = ImageGallery[PicturesIndex]

    }
        
}

