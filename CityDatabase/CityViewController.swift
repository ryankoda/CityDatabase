import UIKit
import CoreData

class CityViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    var y:City?
    var tempName:String?
    var tempDescription:String?
    var tempImage:UIImage?
    var tempRow:Int?
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityDescription: UILabel!
    @IBOutlet weak var imageSource: UISegmentedControl!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        picker.delegate = self
        self.cityName.text = self.tempName
        self.cityDescription.text = self.tempDescription
        self.cityImage.image = self.tempImage
    }
    @IBAction func ChoosePicture(_ sender: Any)
    {
        if imageSource.selectedSegmentIndex == 0
        {
            if UIImagePickerController.isSourceTypeAvailable(.camera)
            {
                picker.allowsEditing = false
                picker.sourceType = UIImagePickerController.SourceType.camera
                picker.cameraCaptureMode = .photo
                picker.modalPresentationStyle = .fullScreen
                present(picker, animated:true, completion:nil)
            }
        }
        else
        {
            picker.allowsEditing = false
            picker.sourceType = .photoLibrary
            picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            picker.modalPresentationStyle = .popover
            present(picker, animated:true, completion:nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        picker .dismiss(animated:true, completion:nil)
        cityImage.image=info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        let imageData: NSData = cityImage.image!.pngData() as! NSData
        y!.cityImage = imageData
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "mapView")
        {
            if let viewController: MapSearchViewController = segue.destination as? MapSearchViewController
            {
                viewController.selectedCity = cityName.text
            }
        }
    }
    @IBAction func mapUnwind(segue:UIStoryboardSegue)
    {
        
    }
}
