import UIKit

class CityTableViewCell: UITableViewCell
{

    @IBOutlet weak var cellImage: UIImageView!
    {
        didSet
        {
            cellImage.layer.borderWidth = 1
            cellImage.layer.masksToBounds = false
            cellImage.clipsToBounds = true
        }
    }
    @IBOutlet weak var cellName: UILabel!
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
}
