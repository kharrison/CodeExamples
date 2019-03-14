//  Copyright © 2019 Keith Harrison. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  1. Redistributions of source code must retain the above copyright
//  notice, this list of conditions and the following disclaimer.
//
//  2. Redistributions in binary form must reproduce the above copyright
//  notice, this list of conditions and the following disclaimer in the
//  documentation and/or other materials provided with the distribution.
//
//  3. Neither the name of the copyright holder nor the names of its
//  contributors may be used to endorse or promote products derived from
//  this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.

import UIKit

final class LibraryContainerViewController: UIViewController {

    private let library = [
        Book(title: "Alice's Adventures in Wonderland", author: "Lewis Caroll", firstLine: "Alice was beginning to get very tired of sitting by her sister on the bank, and of having nothing to do: once or twice she had peeped into the book her sister was reading, but it had no pictures or conversations in it, ‘and what is the use of a book,’ thought Alice ‘without pictures or conversations?’"),
        Book(title: "Emma", author: "Jane Austen", firstLine: "Emma Woodhouse, handsome, clever, and rich, with a comfortable home and happy disposition, seemed to unite some of the best blessings of existence; and had lived nearly twenty-one years in the world with very little to distress or vex her."),
        Book(title: "Great Expectations", author: "Charles Dickens", firstLine: "My father's family name being Pirrip, and my Christian name Philip, my infant tongue could make of both names nothing longer or more explicit than Pip."),
        Book(title: "Metamorphosis", author: "Franz Kafka", firstLine: "One morning, when Gregor Samsa woke from troubled dreams, he found himself transformed in his bed into a horrible vermin."),
        Book(title: "Peter Pan", author: "James M. Barrie", firstLine: "All children, except one, grow up.")
    ]

    @IBOutlet private var messageHeightConstraint: NSLayoutConstraint?

    private var previewController: MessageViewController?
    private var listTableViewController: BookListTableViewController?

    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
        super.preferredContentSizeDidChange(forChildContentContainer: container)
        if (container as? MessageViewController) != nil {
            messageHeightConstraint?.constant = container.preferredContentSize.height
        }
    }
}

extension LibraryContainerViewController: SegueHandler {

    enum SegueIdentifier: String {
        case embedList
        case embedPreview
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .embedList:
            guard let childController = segue.destination as? BookListTableViewController else {
                fatalError("Missing ListTableViewController")
            }
            listTableViewController = childController
            listTableViewController?.list = library
            listTableViewController?.delegate = self
        case .embedPreview:
            guard let childController = segue.destination as? MessageViewController else {
                fatalError("Missing MessageViewController")
            }
            previewController = childController
            previewController?.message = "Choose a book..."
        }
    }
}

extension LibraryContainerViewController: BookListDelegate {
    func didSelect(index: Int) {
        previewController?.message = library[index].firstLine
    }
}
