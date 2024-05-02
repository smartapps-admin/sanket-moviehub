
import UIKit

class DetailVC: UIViewController {
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var yearTitle: UILabel!
    @IBOutlet weak var castTitle: UILabel!
    @IBOutlet weak var descriptionTitle: UILabel!
    @IBOutlet weak var addToWatchlistBtn: UIButton!
    var movie : MovieElement?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addToWatchlistBtn.layer.cornerRadius = 10
        self.addToWatchlistBtn.backgroundColor = #colorLiteral(red: 0.2831990719, green: 0.1200752482, blue: 0.07691653818, alpha: 1)
        self.movieImg.kf.setImage(with: URL(string: movie?.thumbnail ?? ""),placeholder: UIImage(named: "M"))
        self.movieTitle.text = movie?.title ?? "Some Issue"
        self.yearTitle.text = "\(movie?.year! ?? 0)"
        self.castTitle.text = movie?.cast?.isEmpty ?? false ? "No Cast Deatils" : movie?.cast?[0]
        self.descriptionTitle.text = movie?.extract ?? "No Description Available"
        self.addToWatchlistBtn.setTitle(readMovieElements(byTitle: (movie?.title)!) ?? false ? "Remove From Watchlist" : "Add to Watchlist", for: .normal)
       
    }
    

    @IBAction func onClickAddtoWatchlist(_ sender: Any) {
        readMovieElements(byTitle: (movie?.title)!) ?? false ? removeMovieElement(withTitle: (movie?.title)!) : addMovieElement(self.movie!)
        self.addToWatchlistBtn.setTitle(readMovieElements(byTitle: (movie?.title)!) ?? false ? "Remove From Watchlist" : "Add to Watchlist", for: .normal)
    }

}
