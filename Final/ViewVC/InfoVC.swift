//
//  InfoVC.swift
//  Final
//
//  Created by Huseyn Hasanov on 29.03.22.
//

import UIKit
import SDWebImage
class InfoVC: UIViewController {
    
    var vm = SearchVM()
    var infoData: NewsData?
    
    var savedID: [String] = UserDefaults.standard.object(forKey: "SaveID") as? [String] ?? []
    var savedName: [String] = UserDefaults.standard.object(forKey: "SavedNames") as? [String] ?? []
    var savedPicture: [String] = UserDefaults.standard.object(forKey: "SavedPictures") as? [String] ?? []
    var savedPublishedDate: [String] = UserDefaults.standard.object(forKey: "SavedDate") as? [String] ?? []
    var savedAuthor: [String] = UserDefaults.standard.object(forKey: "SavedAuthor") as? [String] ?? []
    var savedTopic: [String] = UserDefaults.standard.object(forKey: "SavedTopic") as? [String] ?? []
    var savedExcrept: [String] = UserDefaults.standard.object(forKey: "SavedExcrept") as? [String] ?? []
    var savedSummary: [String] = UserDefaults.standard.object(forKey: "SavedSummary") as? [String] ?? []
    var savedLInk: [String] = UserDefaults.standard.object(forKey: "SavedLink") as? [String] ?? []
    var savedAuthorTwiter: [String] =  UserDefaults.standard.object(forKey: "SavedTwiter") as? [String] ?? []
    
    var image: String?
    var topic: String?
    var name: String?
    var summary: String?
    var link: String?
    var excrept: String?
    var author: String?
    var Publish_Date: String?
    var twiterAuthor: String?
    var ID: String?
    
    //backbtn
    @IBAction func BackBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        
    }
    @IBOutlet weak var BackBtnOutlet: UIButton!{
        didSet{
            BackBtnOutlet.setTitle(name, for: .normal)
        }
    }
    @IBOutlet weak var SaveShareOUtlet: UIButton!{
        didSet{
        SaveShareOUtlet.setImage(SaveShareOUtlet.imageView?.image?.rotate(radians: .pi/2), for: .normal)
        SaveShareOUtlet.layer.cornerRadius = 15
        }
    }
    @IBAction func SaveShareBtn(_ sender: UIButton) {
        if SaveBtnShareBtnView.isHidden{
            SaveBtnShareBtnView.isHidden = false
        }else{
            SaveBtnShareBtnView.isHidden = true
        }
    }

    @IBOutlet weak var SaveBtnOUtlet: UIButton!
    @IBAction func SaveBtnAction(_ sender: UIButton) {
        if !(savedID.contains(ID ?? "")){
            savedAuthor.append(author ?? "")
            savedName.append(name ?? "")
            savedPicture.append(image ?? "")
            savedID.append(ID ?? "")
            savedPublishedDate.append(Publish_Date ?? "")
            savedTopic.append(topic ?? "")
            savedExcrept.append(excrept ?? "")
            savedSummary.append(summary ?? "")
            savedLInk.append(link ?? "")
            savedAuthorTwiter.append(twiterAuthor ?? "")
            SaveBtnOUtlet.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        }else{
            savedSummary.remove(at: savedSummary.firstIndex(of: summary ?? "") ?? 0)
            savedExcrept.remove(at: savedExcrept.firstIndex(of: excrept ?? "") ?? 0)
            savedLInk.remove(at: savedLInk.firstIndex(of: link ?? "") ?? 0)
            savedName.remove(at: savedName.firstIndex(of: name ?? "") ?? 0)
            savedPublishedDate.remove(at: savedPublishedDate.firstIndex(of: Publish_Date ?? "") ?? 0)
            savedAuthor.remove(at: savedAuthor.firstIndex(of: author ?? "")!)
            savedPicture.remove(at: savedPicture.firstIndex(of: image ?? "") ?? 0)
            savedID.remove(at: savedID.firstIndex(of: ID ?? "") ?? 0)
            savedTopic.remove(at: savedTopic.firstIndex(of: topic ?? "") ?? 0)
            savedAuthorTwiter.remove(at: savedAuthorTwiter.firstIndex(of: twiterAuthor ?? "") ?? 0)
            SaveBtnOUtlet.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }
        UserDefaults.standard.set(savedName, forKey:  "SavedNames")
        UserDefaults.standard.set(savedAuthor, forKey: "SavedAuthor" )
        UserDefaults.standard.set(savedPicture,forKey: "SavedPictures")
        UserDefaults.standard.set(savedID,forKey: "SaveID")
        UserDefaults.standard.set(savedTopic,forKey: "SavedTopic")
        UserDefaults.standard.set(savedPublishedDate,forKey: "SavedDate")
        UserDefaults.standard.set(savedExcrept, forKey: "SavedExcrept")
        UserDefaults.standard.set(savedSummary, forKey: "SavedSummary")
        UserDefaults.standard.set(savedLInk, forKey: "SavedLink")
        UserDefaults.standard.set(savedAuthorTwiter, forKey: "SavedTwiter")
    }
    @IBAction func ShareBtn(_ sender: UIButton){
        if let image = UIImage(named: "scale.3d"){
            (sender as AnyObject).setImage(image, for: .normal)
        }
        let text = link
              
              let textToShare = [ text ]
        let activityViewController = UIActivityViewController(activityItems: textToShare as [Any], applicationActivities: nil)
              activityViewController.popoverPresentationController?.sourceView = self.view
              
              activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
              
              self.present(activityViewController, animated: true, completion: nil)
    }
 
    override func viewDidAppear(_ animated: Bool){
        savedSummary = UserDefaults.standard.object(forKey: "SavedSummary") as? [String] ?? []
        savedExcrept = UserDefaults.standard.object(forKey: "SavedExcrept") as? [String] ?? []
        savedLInk = UserDefaults.standard.object(forKey: "SavedLink") as? [String] ?? []
        savedAuthorTwiter = UserDefaults.standard.object(forKey: "SavedTwiter") as? [String] ?? []
        savedName = UserDefaults.standard.object(forKey: "SavedNames") as? [String] ?? []
        savedPicture = UserDefaults.standard.object(forKey: "SavedPictures") as? [String] ?? []
        savedPublishedDate = UserDefaults.standard.object(forKey: "SavedDate") as? [String] ?? []
        savedAuthor = UserDefaults.standard.object(forKey: "SavedAuthor") as? [String] ?? []
        savedID = UserDefaults.standard.object(forKey: "SaveID") as? [String] ?? []
        savedTopic = UserDefaults.standard.object(forKey: "SavedTopic") as? [String] ?? []
        if savedID.contains(ID ?? ""){
            SaveBtnOUtlet.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        }else{
            SaveBtnOUtlet.setImage(UIImage(systemName: "bookmark"),  for: .normal)
        }
        if !(savedID.contains(ID ?? "")){
            print("Hello")
            SaveBtnOUtlet.setImage(UIImage(systemName: "bookmark"), for: .normal)
        }else{
            SaveBtnOUtlet.setImage(UIImage(systemName: "bookmark.fill"),  for: .normal)
            
        }
}
    @IBOutlet weak var SaveBtnShareBtnView: UIView!{
        didSet{
            SaveBtnShareBtnView.layer.cornerRadius = 15
            SaveBtnShareBtnView.isHidden = true
        }
    }
    @IBOutlet weak var BackBtnView: UIView!{
        didSet{
            BackBtnView.layer.cornerRadius = 15
        }
    }

    @IBOutlet weak var TopicLabe: UILabel!
    @IBOutlet weak var TopicView: UIView!{
        didSet{
            TopicView.layer.cornerRadius = 13
        }
    }
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var AuthorLabel: UILabel!
    @IBOutlet weak var ExcreptLabel: UILabel!
    @IBOutlet weak var SummaryLabel: UILabel!
    @IBOutlet weak var LinkLabel: UILabel!
    @IBOutlet weak var MediaView: UIImageView!



    @IBOutlet weak var viewOnTop: UIView!{
        didSet{
            AuthorLabel.text = author
            TitleLabel.text = name
            TopicLabe.text = topic
            SummaryLabel.text = summary
            ExcreptLabel.text = excrept
            MediaView.sd_setImage(with: URL(string: image ?? ""), completed: nil)
            viewOnTop.clipsToBounds = true
            viewOnTop.layer.cornerRadius = 20
            viewOnTop.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped(_:)))
        tapgesture.numberOfTapsRequired = 1
        self.AuthorLabel.isUserInteractionEnabled = true
        self.AuthorLabel.addGestureRecognizer(tapgesture)

        let tap = UITapGestureRecognizer(target: self, action: #selector(Tapped(_:)))
        tap.numberOfTapsRequired = 1
        self.LinkLabel.isUserInteractionEnabled = true
        self.LinkLabel.addGestureRecognizer(tap)
    

    }
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        print("Taped")
      
            if  let url = URL(string: "https://twitter.com/\(twiterAuthor ?? "")"){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            print("https://twitter.com/\(twiterAuthor ?? "")")
        }
    }
    @objc func Tapped(_ sender: UITapGestureRecognizer) {
        print("labeltaped")
        
        if let firstURLString = link, let url = URL(string: firstURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    
    }

extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return rotatedImage ?? self
        }
        return self
    }
}
