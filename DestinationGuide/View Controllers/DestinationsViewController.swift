//
//  DestinationsViewController.swift
//  DestinationGuide
//
//  Created by Alexandre Guibert1 on 02/08/2021.
//

import UIKit
import Combine

class DestinationsViewModel {
    @Published var array = [Destination]()
    @Published var selectedDestination: DestinationDetails?
    @Published var error: String?
    
    init() {
        getDestinations()
    }
    
    func getDestinations() {
        DestinationFetchingService().getDestinations { destinations in
            self.array = Array(try! destinations.get()).sorted(by: { $0.name < $1.name })
        }
    }
    
    func getDestinationDetails(with id: Destination.ID) {
        DestinationFetchingService().getDestinationDetails(for: id) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(details):
                    self.selectedDestination = details
                case let .failure(error):
                    self.error = error.localizedDescription
                }
            }
            
        }
    }
    
    func numberOfItems() -> Int {
        array.count
    }
    
    func destination(for index: Int) -> Destination {
        array[index]
    }
    
    func title() -> String {
        "Toutes nos destinations"
    }
}

class DestinationsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var viewModel: DestinationsViewModel!
    var cancellables = Set<AnyCancellable>()
    
    lazy var collectionViewLayout: UICollectionViewLayout = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 16, left: 0, bottom: 32, right: 0)
        layout.minimumLineSpacing = 32
        layout.itemSize = .init(width: 342, height: 280)
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: self.collectionViewLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(DestinationCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SectionHeader")
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        
        return collectionView
    }()
  
    convenience init(viewModel: DestinationsViewModel) {
        self.init()
        self.viewModel = viewModel
        
        viewModel.$array
            .sink(receiveValue: { _ in
                self.reloadArray()
            })
            .store(in: &cancellables)
        
        viewModel.$selectedDestination
            .sink(receiveValue: { details in
                if let details = details {
                    self.navigationController?.pushViewController(DestinationDetailsController(title: details.name, webviewUrl: details.url), animated: true)
                }
            })
            .store(in: &cancellables)
        
        viewModel.$error
            .sink(receiveValue: { error in
                if let error = error {
                    let alert = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Annuler", style: .cancel))
                    
                    self.present(alert, animated: true)
                }
            })
            .store(in: &cancellables)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.frame = view.frame
        collectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let desti = viewModel.destination(for: indexPath.item)
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as? DestinationCell {
            cell.setupCell(destination: desti)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as! SectionHeader
            headerView.titleLabel.text = viewModel.title()
            return headerView
            
        default:
            
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        // Get the view for the first header
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView, viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader, at: indexPath)
        
        // Use this view to calculate the optimal size based on the collection view's width
        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width, height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required, // Width is fixed
                                                  verticalFittingPriority: .fittingSizeLevel) // Height can be as large as needed
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let desti = viewModel.destination(for: indexPath.item)
        
        viewModel.getDestinationDetails(with: desti.id)
    }
    
    // MARK: - Helpers
    
    private func reloadArray() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

class DestinationCell: UICollectionViewCell {
    
    var dataTask: URLSessionDataTask?
    
    //  MARK: - Components
    
    let labelDestination: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.text = "Asie"
        lbl.font = UIFont.avertaExtraBold(fontSize: 38)
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    //  Bouton plutôt qu'un label pour pouvoir mettre un padding
    //  Evite d'imbriquer un label dans une UIView
    
    let labelTag: UIButton = {
        let lbl = UIButton()
        lbl.setTitle("Test", for: .normal)
        lbl.setTitleColor(.white, for: .normal)
        lbl.contentEdgeInsets = UIEdgeInsets(top: 3, left: 8, bottom: 3, right: 8)
        lbl.titleLabel?.font = UIFont.avertaBold(fontSize: 16)
        lbl.isUserInteractionEnabled = false
        lbl.backgroundColor = UIColor.evaneos(color: .ink)
        lbl.layer.cornerRadius = 5
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let stackViewRating: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let imageViewBackground: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var gradientView: GradientView = {
        let gradientView = GradientView()
        gradientView.startColor = .black.withAlphaComponent(0)
        gradientView.endColor = .black.withAlphaComponent(0.5)
        
        return gradientView
    }()
    
    //  MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        
        self.shadow()
        self.addView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.gradientView.frame = imageViewBackground.frame
        
        self.imageViewBackground.addSubview(gradientView)
        self.backgroundView = self.imageViewBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Override func
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.stackViewRating.arrangedSubviews.forEach {
            NSLayoutConstraint.deactivate($0.constraints)
            $0.removeFromSuperview()
        }
        self.labelDestination.text = nil
        
        self.dataTask?.cancel()
    }
    
    func downloadImage(url: URL) {
        self.dataTask?.resume()
        
        self.dataTask = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, _  in
            if let data = data {
                DispatchQueue.main.async {
                    self.imageViewBackground.image = UIImage(data: data)
                }
            }
        })
        
        self.dataTask?.resume()
    }
    
    //  MARK: - Function
    
    func setupCell(destination: Destination) {
        self.labelDestination.text = destination.name
        self.configureStackView(rating: destination.rating)
        self.labelTag.setTitle(destination.tag, for: .normal)
        
        self.downloadImage(url: destination.picture)
        
        self.dataTask?.resume()
    }
    
    private func shadow() {
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4.0)
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 4.0
    }
    
    private func addView() {
        
        self.addSubview(labelTag)
        self.addSubview(labelDestination)
        self.addSubview(stackViewRating)
        
        self.constraintInit()
    }
    
    private func configureStackView(rating: Int) {
        var stars = [UIImageView]()
        
        for i in 0..<5 {
            let imageView = UIImageView()
            imageView.tintColor = UIColor.evaneos(color: .gold)
            if i < rating {
                let image = UIImage(systemName: "star.fill")
                imageView.image = image
            } else {
                let image = UIImage(systemName: "star")
                imageView.image = image
            }
            stars.append(imageView)
        }
        
        for star in stars {
            self.stackViewRating.addArrangedSubview(star)
        }
    }
    
    private func constraintInit() {
        NSLayoutConstraint.activate([
            self.labelTag.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.labelTag.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.labelTag.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            
            self.stackViewRating.bottomAnchor.constraint(equalTo: self.labelTag.topAnchor, constant: -8),
            self.stackViewRating.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            
            self.labelDestination.bottomAnchor.constraint(equalTo: self.stackViewRating.topAnchor, constant: 0),
            self.labelDestination.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            self.labelDestination.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 16)
        ])
    }
    
}

class SectionHeader: UICollectionReusableView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.avertaBold(fontSize: 28)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layoutMargins = .init(top: 8, left: 16, bottom: 8, right: 16)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            self.layoutMarginsGuide.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            self.layoutMarginsGuide.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            self.layoutMarginsGuide.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            self.layoutMarginsGuide.topAnchor.constraint(equalTo: titleLabel.topAnchor),
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
