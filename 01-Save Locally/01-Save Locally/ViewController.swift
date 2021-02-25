//
//  ViewController.swift
//  01-Save Locally
//
//  Created by Cédric Bahirwe on 07/02/2021.
//
import UIKit

class ViewController: UIViewController {
    enum StorageType {
        case userDefaults
        case fileSystem
    }
    @IBOutlet weak var userNameLabel: UILabel!
    var newName: String!
    
    @IBOutlet weak var retrieveImage: UIImageView!
//    @IBOutlet weak var retrieveImage: UIImageView!
    
    @IBOutlet weak var saveButton: UIButton!
    var currentImage: UIImage!
    
    @IBOutlet weak var retrieveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "CEDRIC"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importPicture))
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        displayNewImage()
    }
    @objc
    func importPicture() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    private func store(image: UIImage, forKey key: String, withStorageType storageType: StorageType) {
        if let pngRepresentation = image.pngData() {
            switch storageType {
            case .fileSystem:
                if let filePath = filePath(forKey: key) {
                    do  {
                        try pngRepresentation.write(to: filePath,
                                                    options: .atomic)
                    } catch let err {
                        print("Saving file resulted in error: ", err)
                    }
                }
            case .userDefaults:
                UserDefaults.standard.set(pngRepresentation, forKey: key)
            }
        }
    }
    
    private func retrieveImage(forKey key: String, inStorageType storageType: StorageType) -> UIImage? {
        switch storageType {
        case .fileSystem:
            if let filePath = self.filePath(forKey: key),
                let fileData = FileManager.default.contents(atPath: filePath.path),
                let image = UIImage(data: fileData) {
                return image
            }
        case .userDefaults:
            if let imageData = UserDefaults.standard.object(forKey: key) as? Data,
                let image = UIImage(data: imageData) {
                
                return image
            }
        }
        return nil
    }
    
    private func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }
        
        return documentURL.appendingPathComponent(key + ".png")
    }
    
    
    @IBAction func didSave(_ sender: Any) {
        let alert = UIAlertController(title: "Change Display name", message: "Do you want to change your displayed name: \(userNameLabel.text!)"  , preferredStyle: .alert)
        
        let updateName = UIAlertAction(title: "Update", style: .default) { [weak alert] _ in
            guard let textField = alert?.textFields else { return }
            if let newName = textField[0].text {
                self.newName = newName
            }
            self.userNameLabel.text =  !self.newName.isEmpty ? self.newName : self.userNameLabel.text
        }
        alert.addTextField { (textField) in
            textField.placeholder = self.userNameLabel.text
            textField.text = ""
            updateName.isEnabled = false
            NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: textField, queue: OperationQueue.main) { (notification) in
                updateName.isEnabled = !textField.text!.trimmingCharacters(in: .whitespaces).isEmpty
            }
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancel)
        alert.addAction(updateName)
        present(alert, animated: true)
    }
    
    func save() {
        if let buildingImage = UIImage(named: "zoom") {
            DispatchQueue.global(qos: .background).async {
                self.store(image: buildingImage,
                            forKey: "zoomImage",
                            withStorageType: .fileSystem)
            }
        }
    }
    func save(image: UIImage?) {
        if let buildingImage = image {
            DispatchQueue.global(qos: .background).async {
                self.store(image: buildingImage, forKey: "user_avatar", withStorageType: .fileSystem)
            }
        }
    }
    @IBAction func didRetrieve(_ sender: Any) {
        displayNewImage()
    }
    func displayNewImage() {
        DispatchQueue.global(qos: .background).async {
            if let savedImage = self.retrieveImage(forKey: "user_avatar",
                                                    inStorageType: .fileSystem) {
                DispatchQueue.main.async {
                    self.retrieveImage.image = savedImage
                }
            }
        }
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as?  UIImage else { return }
         dismiss(animated: true)
        currentImage = image
        save(image: currentImage)
    }
}


extension UIImage {

    func save(at directory: FileManager.SearchPathDirectory,
              pathAndImageName: String,
              createSubdirectoriesIfNeed: Bool = true,
              compressionQuality: CGFloat = 1.0)  -> URL? {
        do {
        let documentsDirectory = try FileManager.default.url(for: directory, in: .userDomainMask,
                                                             appropriateFor: nil,
                                                             create: false)
        return save(at: documentsDirectory.appendingPathComponent(pathAndImageName),
                    createSubdirectoriesIfNeed: createSubdirectoriesIfNeed,
                    compressionQuality: compressionQuality)
        } catch {
            print("-- Error: \(error)")
            return nil
        }
    }

    func save(at url: URL,
              createSubdirectoriesIfNeed: Bool = true,
              compressionQuality: CGFloat = 1.0)  -> URL? {
        do {
            if createSubdirectoriesIfNeed {
                try FileManager.default.createDirectory(at: url.deletingLastPathComponent(),
                                                        withIntermediateDirectories: true,
                                                        attributes: nil)
            }
            guard let data = jpegData(compressionQuality: compressionQuality) else { return nil }
            try data.write(to: url)
            return url
        } catch {
            print("-- Error: \(error)")
            return nil
        }
    }
}

extension UIImage {
    convenience init?(fileURLWithPath url: URL, scale: CGFloat = 1.0) {
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data, scale: scale)
        } catch {
            print("-- Error: \(error)")
            return nil
        }
    }
}
