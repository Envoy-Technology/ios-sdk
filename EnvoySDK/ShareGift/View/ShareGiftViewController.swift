import UIKit

final class ShareGiftViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var activity: UIActivityIndicatorView!
    @IBOutlet private weak var shareButton: UIButton!

    var presenter: ShareGiftViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.viewDidLoad()
    }
}

private extension ShareGiftViewController {
    private func setupUI() {
        setupNavigationBar()
        setupButtons()
    }

    func setupNavigationBar() {
        let closeItem = UIBarButtonItem(
            image: UIImage(named: "ic_arrow_right", in: Bundle.envoyBundle, with: nil),
            style: .plain,
            target: self,
            action: #selector(onBack)
        )
        closeItem.tintColor = .white
        navigationItem.leftBarButtonItem = closeItem
    }

    func setupButtons() {
        shareButton.layer.cornerRadius = 6
    }

    @objc private func onBack() {
        if navigationController?.viewControllers.count ?? 0 > 1 {
            navigationController?.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }

    @IBAction func shareAction(_ sender: Any?) {
        presenter?.shareAction()
    }
}

extension ShareGiftViewController: ShareGiftViewProtocol {
    func updateWith(viewState: ShareGiftViewState) {
        titleLabel.text = viewState.title
        subtitleLabel.text = viewState.subtitle
        statusLabel.text = viewState.message
        shareButton.isHidden = !viewState.isSharePossible
    }

    func updateWith(isLoading: Bool) {
        if isLoading {
            activity.startAnimating()
        } else {
            activity.stopAnimating()
        }
    }

    func presentShare(for url: String) {
        let textToShare = [url]
        let activityViewController = UIActivityViewController(
            activityItems: textToShare,
            applicationActivities: nil
        )
        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true)
    }
}
