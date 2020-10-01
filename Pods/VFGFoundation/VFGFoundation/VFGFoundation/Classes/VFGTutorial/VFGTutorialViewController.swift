//
//  VFGTutorialViewController.swift
//  VFGLogin
//
//  Created by Mohamed Mahmoud Zaki on 2/25/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit
import Lottie

open class VFGTutorialViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var pageControl: UIPageControl!
    var currentAnimation: String?
    public weak var delegate: VFGTutorialManagerProtocol?
    public var dataSource: VFGTutorialProtocol?

    public static func viewController(with dataModel: VFGTutorialProtocol?) -> VFGTutorialViewController {
        let storyboard = UIStoryboard(name: "Tutorial", bundle: Bundle.foundation)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "VFGTutorialViewController")
            as? VFGTutorialViewController else {
                return VFGTutorialViewController()
        }
        viewController.dataSource = dataModel
        return viewController
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        let newLayout = UICollectionViewFlowLayout()
        newLayout.itemSize = CGSize(width: view.frame.width, height: collectionView.frame.height)
        newLayout.scrollDirection = .horizontal
        newLayout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = newLayout

        setupCells()
        setupAnimation()
        setupLocalization()
        pageControl.numberOfPages = dataSource?.item?.count ?? 0
    }

    private func setupAnimation() {
        animationView.animation = Animation.named(dataSource?.item?.first?.fileName ?? "",
                                                  bundle: dataSource?.animationFileBundle ?? Bundle.main)
        currentAnimation = dataSource?.item?.first?.fileName
        animationView.play(fromFrame: dataSource?.item?.first?.startingFrame,
                           toFrame: dataSource?.item?.first?.endingFrame ?? 0,
                           completion: nil)
        animationView.contentMode = .scaleAspectFit
    }

    private func setupCells() {
        let nib = UINib(nibName: "VFGTutorialCellCollectionViewCell", bundle: Bundle.foundation)
        collectionView.register(nib, forCellWithReuseIdentifier: "VFGTutorialCellCollectionViewCell")
    }

    private func setupLocalization() {
        if let firstbuttonTitle = dataSource?.firstButtonTitle {
            loginButton.setTitle(firstbuttonTitle, for: .normal)
            loginButton.accessibilityIdentifier = "loginLoginTutorial"
        } else {
            loginButton.isHidden = true
        }
        if let secondButtonTitle = dataSource?.secondButtonTitle {
            registerButton.setTitle(secondButtonTitle, for: .normal)
            registerButton.accessibilityIdentifier = "loginRegisterTutorial"
        } else {
            registerButton.isHidden = true
        }
    }

    @IBAction func loginButton(_ sender: Any) {
        delegate?.firstActionTapped()
    }

    @IBAction func registerButton(_ sender: Any) {
        delegate?.secondActionTapped()
    }
}

extension VFGTutorialViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.item?.count ?? 0
    }

    public func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VFGTutorialCellCollectionViewCell",
                                                      for: indexPath)
        guard let tutorialCell = cell as? VFGTutorialCellCollectionViewCell else {
            return cell
        }
        tutorialCell.titleLabel.text = dataSource?.item?[indexPath.row].title
        tutorialCell.descriptionLabel.text = dataSource?.item?[indexPath.row].description
        return tutorialCell
    }
}

extension VFGTutorialViewController: UIScrollViewDelegate {
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let cellWidth = view.frame.width
        let oldPage = pageControl.currentPage
        let offsetX = scrollView.contentOffset.x
        updatePaging(cellWidth: cellWidth, oldPage: oldPage, offsetX: offsetX)
    }

    func updatePaging(cellWidth: CGFloat, oldPage: Int, offsetX: CGFloat) {
        pageControl.currentPage = Int(offsetX / cellWidth)
        if oldPage != pageControl.currentPage {
            let index = self.pageControl.currentPage
            if self.currentAnimation == self.dataSource?.item?[index].fileName {
                DispatchQueue.main.async {
                    self.animationView.play(fromFrame: self.dataSource?.item?[index].startingFrame,
                                            toFrame: self.dataSource?.item?[index].endingFrame ?? 0, completion: nil)
                }
            } else {
                self.currentAnimation = self.dataSource?.item?[index].fileName
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else {return}
                    self.animationView.animation = Animation.named(self.dataSource?.item?[index].fileName ?? "",
                                                                   bundle:
                        self.dataSource?.animationFileBundle ?? Bundle.main)
                    self.animationView.play()
                }
            }
        }
    }
}
