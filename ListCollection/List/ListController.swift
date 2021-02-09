//  Created by Keith Harrison https://useyourloaf.com
//  Copyright © 2020 Keith Harrison. All rights reserved.
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

final class ListController: UICollectionViewController {
    var countries = [Country]() {
        didSet {
            applySnapshot()
        }
    }

    private enum Section: CaseIterable {
        case main
    }

    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Country> = {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Country> { cell, _, country in
            var content = cell.defaultContentConfiguration()
            content.text = country.name

            content.secondaryText = country.capital
            content.secondaryTextProperties.color = .secondaryLabel
            content.secondaryTextProperties.font = UIFont.preferredFont(forTextStyle: .subheadline)

            content.image = UIImage(systemName: "globe")
            content.imageProperties.preferredSymbolConfiguration = .init(font: content.textProperties.font, scale: .large)

            cell.contentConfiguration = content

              // Example of setting a background configuration
//            var background = UIBackgroundConfiguration.listPlainCell()
//            background.backgroundColor = .systemYellow
//            cell.backgroundConfiguration = background

            cell.accessories = [.disclosureIndicator()]
            cell.tintColor = .systemPurple
        }

        return UICollectionViewDiffableDataSource<Section, Country>(collectionView: collectionView) { (collectionView, indexPath, country) -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: country)
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        createLayout()
        applySnapshot(animatingDifferences: false)
    }

    private func applySnapshot(animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Country>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(countries)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }

    private func createLayout() {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.backgroundColor = UIColor(named: "BackgroundColor")
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: config)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let country = dataSource.itemIdentifier(for: indexPath) {
            print("didSelect \(country.name)")
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
}
