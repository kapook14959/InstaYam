//
//  CommentsViewController.swift
//  InstaYam

import UIKit

protocol CommentsViewControllerOutput: AnyObject {
    
}

enum Emoji: String {
    case heart = "\u{2764}"
    case hand = "\u{1F64C}"
    case fire = "\u{1F525}"
    case crap = "\u{1F44F}"
    case sad = "\u{1F97A}"
    case love = "\u{1F63B}"
    case wow = "\u{1F62E}"
    case laugh = "\u{1F602}"
}

class CommentsViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var commentImage: UIImageView!
    @IBOutlet private weak var commentTextField: UITextField!
    
    var interactor: CommentsInteractorOutput!
    var router: CommentsRouterInput!
    var emoji: [Emoji]! = [.heart, .hand, .fire, .crap, .sad, .love, .wow, .laugh]
    var str: String = ""
    
    // MARK: - Object lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let router = CommentsRouter()
        router.viewController = self
        
        let presenter = CommentsPresenter()
        presenter.viewController = self
        
        let interactor = CommentsInteractor()
        interactor.presenter = presenter
        
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Comments"
        navigationController?.navigationBar.tintColor = UIColor.black
        setupTableView()
        setupViews()
    }
    
    // MARK: - SetupViews
    private func setupTableView() {
        let descriptionNib = UINib(nibName: "DescriptionTableViewCell", bundle: nil)
        let commentsNib = UINib(nibName: "CommentsTableViewCell", bundle: nil)
        let emojiNib = UINib(nibName: "EmojiCollectionViewCell", bundle: nil)
        tableView.register(descriptionNib, forCellReuseIdentifier: "DescriptionCell")
        tableView.register(commentsNib, forCellReuseIdentifier: "CommentsCell")
        collectionView.register(emojiNib, forCellWithReuseIdentifier: "EmojiCell")
        tableView.dataSource = self
        tableView.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupViews() {
        commentTextField.delegate = self
        commentTextField.layer.cornerRadius = 20.0
        commentTextField.layer.borderWidth = 1.0
        commentTextField.layer.borderColor = UIColor.gray.cgColor
        commentTextField.placeholder = "    Add a Comment..."
        let placeHolderRect = CGRect(x: 20, y: 0, width: 0, height: 0)
        commentTextField.placeholderRect(forBounds: placeHolderRect)
        commentTextField.setPaddingLeft(space: 20)
        commentImage.layer.cornerRadius = commentImage.frame.height / 2
        let url = URL(string: interactor.feed.image)
        commentImage.downloadImage(from: url!)
    }
    
    // MARK: - Event handling
    
    // MARK: - Actions
    
    // MARK: - Private func
}

// MARK: - Display logic

extension CommentsViewController: CommentsViewControllerOutput {
    
}

// MARK: - Start Any Extensions

extension CommentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return interactor.comments.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as? DescriptionTableViewCell else { return UITableViewCell() }
            descriptionCell.updateUI(feed: interactor.feed)
            return descriptionCell
        } else {
            guard let commentsCell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as? CommentsTableViewCell else { return UITableViewCell() }
            commentsCell.updateUI(comments: interactor.comments[indexPath.row - 1], feed: interactor.feed)
            return commentsCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension CommentsViewController: UITableViewDelegate {
    
}

extension CommentsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emoji.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCell", for: indexPath) as? EmojiCollectionViewCell else { return UICollectionViewCell() }
        cell.updateUI(emoji: emoji[indexPath.row])
        cell.delegate = self
        return cell
    }
}

extension CommentsViewController: UICollectionViewDelegate {
    
}

extension CommentsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 20) / CGFloat(emoji.count)
        return CGSize(width: width, height: collectionView.frame.height)
    }
}

extension CommentsViewController: EmojiCollectionViewCellDelegate {
    func didTapEmojiButton(emoji: Emoji) {
        commentTextField.text = "\(commentTextField.text ?? "")\(emoji.rawValue)"
    }
}

extension CommentsViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = commentTextField.text else { return false }
        let newText = (oldText as NSString).replacingCharacters(in: range, with: string)
        if textField.text != newText {
            commentTextField.text = newText
        }
        return false
    }
}
