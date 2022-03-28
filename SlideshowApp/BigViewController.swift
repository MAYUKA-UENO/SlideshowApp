
import UIKit

class BigViewController: UIViewController
{
    var BigPicture = UIImage()//写真宣言
    
    @IBOutlet weak var Modoru: UIButton!
    @IBOutlet weak var BigImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        BigImage()

    }

    func BigImage()
    {
        BigImageView.image = BigPicture
    }

    
}
