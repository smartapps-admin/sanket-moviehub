
import UIKit
import Kingfisher

class HomeTVC : UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.homeCVC.delegate = self
        self.homeCVC.dataSource = self
    }
    var movies : [MovieElement] = []
    @IBOutlet weak var movieYearLbl: UILabel!
    @IBOutlet weak var homeCVC: UICollectionView!
    @IBAction func onClickSeeMore(_ sender: UIButton) {
        let nextVC = AllMovieVC.instantiateViewController() as? AllMovieVC
        nextVC?.movies = movies
        NavigationHelper.shared.navControl?.pushViewController(nextVC!, animated: true)
    }
}

class HomeCVC :UICollectionViewCell{
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBOutlet weak var movieImgView: UIImageView!
}

class HomeTCVC : UICollectionViewCell {
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBOutlet weak var movieImgView: UIImageView!
}




class HomeVC: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var homeTableView: UITableView!
    @IBOutlet weak var scrollCollectionVIew: UICollectionView!
    var timer : Timer?
    var counter = 0
    var moviesArray : [MovieElement]?
    let movieYears : [Int] = [1900,1910,1920,1930,1940,1950,1960,1970,1980,1990,2000,2010,2020]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeTableView.showsVerticalScrollIndicator = false
        pageControl.numberOfPages = 9
        pageControl.currentPage = 0
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(slide), userInfo: nil, repeats: true)
        self.title = "Home"
        moviesArray = getMovies()
        NavigationHelper.shared.navControl = self.navigationController
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollpos = scrollView.contentOffset.x / view.frame.width
        pageControl.currentPage = Int(scrollpos)
    }
    @objc func slide(){
        let index = IndexPath(item: counter, section: 0)
        if counter < 10 - 1 {
            scrollCollectionVIew.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            counter += 1
        }else {
            counter = 0
            pageControl.currentPage = counter
            scrollCollectionVIew.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            counter += 1
        }
    }


}

extension HomeVC : UICollectionViewDataSource ,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HomeCVC = collectionView.dequeueReusableCell(ofType: HomeCVC.self, for: indexPath)
        let movies = moviesArray?.prefix(10)
        guard let url = URL(string: moviesArray?.randomElement()?.thumbnail ?? "") else {
            return cell
        }
        cell.movieImgView.kf.setImage(with: url)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: scrollCollectionVIew.frame.size.width, height: scrollCollectionVIew.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
}

extension HomeTVC : UICollectionViewDataSource ,UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HomeTCVC = collectionView.dequeueReusableCell(ofType: HomeTCVC.self, for: indexPath)
        cell.movieImgView.kf.setImage(with:  URL(string: self.movies[indexPath.row].thumbnail ?? ""),placeholder: UIImage(named: "M"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVC = DetailVC.instantiateViewController() as? DetailVC
        nextVC?.movie = movies[indexPath.row]
        NavigationHelper.shared.navControl?.pushViewController(nextVC!, animated: true)
    }
    
}

extension HomeVC : UITableViewDataSource ,UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UIScreen.main.bounds.height / 4
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return movieYears.count
   }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : HomeTVC = tableView.dequeueReusableCell(ofType: HomeTVC.self, for: indexPath)
        cell.movieYearLbl.text = String(movieYears[indexPath.row])
        var moviesArray = getMovies(Ofyear: self.movieYears[indexPath.row])
        cell.movies = moviesArray
        DispatchQueue.main.async {
            cell.homeCVC.reloadData()
        }
        return cell
    }
    
    
}
