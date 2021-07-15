//
//  ViewController.swift
//  Mindteck
//
//  Created by Samir Samanta on 07/07/21.
//

import UIKit

struct ProfileList {
  var name = String()
  var image = String()
}

class ViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var pageView: UIPageControl!
    @IBOutlet weak var txtSearch: UITextField!
    
    var imgArr = [  UIImage(named:"darjeeling"),
                    UIImage(named:"Digha") ,
                    UIImage(named:"jhargram") ,
                    UIImage(named:"Sikkim") ,
                    UIImage(named:"Sundarban")]
    
    var timer = Timer()
    var counter = 0
    let nameList = [ProfileList(name:"Alexandra Daddario",image:"Alexandra Daddario"),
                    ProfileList(name:"Angelina Jolie",image:"Angelina Jolie") ,
                    ProfileList(name:"Anne Hathaway",image:"Anne Hathaway") ,
                    ProfileList(name:"Dakota Johnson",image:"Dakota Johnson") ,
                    ProfileList(name:"Emma Stone", image:"Emma Stone") ,
                    ProfileList(name:"Emma Watson",image:"Emma Watson") ,
                    ProfileList(name:"Halle Berry",image:"Halle Berry") ,
                    ProfileList(name:"Jennifer Lawrence",image:"Jennifer Lawrence") ,
                    ProfileList(name:"Jessica Alba",image:"Jessica Alba") ,
                    ProfileList(name:"Scarlett Johansson",image:"Scarlett Johansson") ]
    var filterArray = [ProfileList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInitialization()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func viewInitialization(){
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        self.listTableView.register(UINib(nibName: "ListCell", bundle: Bundle.main), forCellReuseIdentifier: "ListCell")
        self.txtSearch.delegate = self
        self.filterArray = nameList
        
        pageView.numberOfPages = imgArr.count
        pageView.currentPage = 0
        pageView.pageIndicatorTintColor = UIColor.black
        
        
        DispatchQueue.main.async {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.changeImage), userInfo: nil, repeats: true)
        }
    }
    @objc func changeImage() {
        if counter < imgArr.count {
            let index = IndexPath.init(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            pageView.currentPage = counter
            counter += 1
        } else {
            counter = 0
            let index = IndexPath.init(item: counter, section: 0)
            self.sliderCollectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: false)
            pageView.currentPage = counter
            counter = 1
        }
    }
    
    func filterContentForSearchText(searchText: String) {
        if searchText != "" {
            filterArray = nameList.filter { term in
                return term.name.lowercased().contains(searchText.lowercased())
            }
        }else{
            filterArray = nameList
        }
        
        self.listTableView.reloadData()
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        if let vc = cell.viewWithTag(111) as? UIImageView {
            vc.image = imgArr[indexPath.row]
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = sliderCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let Cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! ListCell
        Cell.initializeCellDetails(cellDic: filterArray[indexPath.row])
        return Cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {

    }
    func textFieldDidEndEditing(_ textField: UITextField) {

    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let txtAfterUpdate = textField.text! as NSString
        let updateText = txtAfterUpdate.replacingCharacters(in: range, with: string) as NSString
        print("Updated TextField:: \(updateText)")
        self.filterContentForSearchText(searchText: updateText as String)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true
    }
}

class RoundUIView: UIView {
    
    @IBInspectable var borderColor: UIColor = UIColor.white {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.5 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var shadowColor: UIColor = UIColor.white {
        didSet {
            self.layer.shadowColor = shadowColor.cgColor
        }
    }
    
    //shadowOpacity
    @IBInspectable var shadowOpacity:  CGFloat = 0.5 {
        didSet {
            self.layer.shadowOpacity = Float(shadowOpacity)
        }
    }
    
    @IBInspectable
    var shadowOffset : CGSize{
        get{
            return layer.shadowOffset
        }set{
            layer.shadowOffset = newValue
        }
    }
}
