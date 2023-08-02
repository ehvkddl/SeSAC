//
//  DetailViewController.swift
//  BookWorm
//
//  Created by do hee kim on 2023/08/01.
//

import UIKit

enum Transition {
    case present
    case push
}

class DetailViewController: UIViewController {

    var contents: Movie?
    var transition: Transition?
    
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet var moviePosterImageView: UIImageView!
    
    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var runtimeAndRateLabel: UILabel!
    @IBOutlet var releaseDateLabel: UILabel!
    
    @IBOutlet var overviewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true

        let back = UIImage(systemName: transition == .present ? "xmark" : "chevron.backward")
        let selector = transition == .present ? #selector(closeButtonClicked) : #selector(backButtonClicked)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: back, style: .plain, target: self, action: selector)
        
        setBarButtonItemColor(color: .white)
        
        designCell()
        
        guard let movie = contents else { return }
        
        title = movie.title
        configureCell(movie: movie)
    }
    
    func configureCell(movie: Movie) {
        moviePosterImageView.image = UIImage(named: movie.title)
        
        movieTitleLabel.text = movie.title
        runtimeAndRateLabel.text = "\(movie.runtime)분 | ⭐️\(movie.rate)점"
        releaseDateLabel.text = "\(movie.releaseDate) 개봉"
        
        overviewLabel.text = movie.overview
    }
    
    func designCell() {
        backgroundView.backgroundColor = .black
        
        movieTitleLabel.textColor = .white
        movieTitleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        
        runtimeAndRateLabel.textColor = .white
        
        releaseDateLabel.textColor = .white
        releaseDateLabel.font = UIFont.systemFont(ofSize: 14, weight: .light)
        
        overviewLabel.numberOfLines = 0
    }
    
    @objc
    func closeButtonClicked() {
        dismiss(animated: true)
    }

    @objc
    func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }

}
