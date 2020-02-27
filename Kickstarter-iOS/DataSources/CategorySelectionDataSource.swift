import Foundation
import KsApi
import Library
import UIKit

internal final class CategorySelectionDataSource: ValueCellDataSource {
  private var categorySectionTitles: [String] = []
  func load(_ categories: [(String, [KsApi.Category])]) {
    for (index, category) in categories.enumerated() {
      let subcategories = category.1.map { ($0.name, PillCellStyle.grey) }

      self.set(values: subcategories, cellClass: PillCell.self, inSection: index)
    }

    self.categorySectionTitles = categories.map { $0.0 }
  }

  override func configureCell(collectionCell cell: UICollectionViewCell, withValue value: Any) {
    switch (cell, value) {
    case let (cell as PillCell, value as (String, PillCellStyle)):
      cell.configureWith(value: value)
    default:
      assertionFailure("Unrecognized (cell, value) combo.")
    }
  }

  public func collectionView(_ collectionView: UICollectionView,
                                   viewForSupplementaryElementOfKind kind: String,
                                   at indexPath: IndexPath) -> UICollectionReusableView {
  guard let view = collectionView
    .dequeueReusableSupplementaryView(ofKind: kind,
                                      withReuseIdentifier: CategoryCollectionViewSectionHeaderView.defaultReusableId,
                                      for: indexPath) as? CategoryCollectionViewSectionHeaderView else {
      assertionFailure("Unknown supplementary view type")
                                        return UICollectionReusableView(frame: .zero)
    }

    view.configure(with: categorySectionTitles[indexPath.section])

    return view
  }
}
