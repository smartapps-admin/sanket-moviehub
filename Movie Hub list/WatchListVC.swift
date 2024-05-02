
import UIKit

class WatchListCVC : UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.moviewImg.layer.cornerRadius = 10
        self.moviewImg.clipsToBounds = true
    }
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviewImg: UIImageView!
}

class WatchListVC: UIViewController {
    @IBOutlet weak var watchlistUITV: UICollectionView!
    var movies : [MovieElement]?
    override func viewDidLoad() {
        self.title = "Watchlist"
        super.viewDidLoad()
        self.movies = readMovieElements()
    }
    

    @IBAction func onClickAddMovies(_ sender: UIButton) {
        let nextVC = GenreVC.instantiateViewController() as? GenreVC
        self.navigationController?.pushViewController(nextVC!, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.movies = readMovieElements()
        DispatchQueue.main.async {
            self.watchlistUITV.reloadData()
        }
        if movies?.count == 0 || movies == nil {
            self.watchlistUITV.isHidden = true
        }
        else{
            self.watchlistUITV.isHidden = false
        }
    }

}

extension WatchListVC : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : WatchListCVC = collectionView.dequeueReusableCell(ofType: WatchListCVC.self, for: indexPath)
        cell.moviewImg.kf.setImage(with: URL(string: movies?[indexPath.row].thumbnail ?? ""),placeholder: UIImage(named: "M"))
        cell.movieTitle.text = movies?[indexPath.row].title
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextVc = DetailVC.instantiateViewController() as DetailVC
        nextVc.movie = movies?[indexPath.row]
        navigationController?.pushViewController(nextVc, animated: true)
    }
}

extension WatchListVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          
        return CGSize(width: watchlistUITV.bounds.width / 2 - 10, height: watchlistUITV.bounds.height / 3)
        }
}
