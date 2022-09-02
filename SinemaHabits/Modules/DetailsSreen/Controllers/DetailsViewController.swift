import UIKit

class DetailsViewController: UIViewController {
    
    private let delailsView = DetailsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = delailsView
    }
    
}
