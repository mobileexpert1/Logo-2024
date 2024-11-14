//
//  Collection FlowLayout Class.swift
//  Logo
//
//  Created by MAC SOLUTIONSS on 25/03/22.
//

import UIKit

class CollectionLayoutSubclass: UICollectionViewFlowLayout  {
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var point = super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity)
        guard let collectionView = collectionView else {
            return point
        }
        let cells = collectionView.visibleCells
        let centerPoint = collectionView.center
        var cellFrame: CGRect = CGRect.zero
        for cell in cells {
            cellFrame = collectionView.convert(cell.frame, to: collectionView.superview)
            var newCenterPoint: CGPoint = centerPoint
            if velocity.x > 0 {
                newCenterPoint = CGPoint(x: centerPoint.x * 1.5, y: centerPoint.y)
            } else if velocity.x < 0 {
                newCenterPoint = CGPoint(x: centerPoint.x * 0.5, y: centerPoint.y)
            }
            guard cellFrame.contains(newCenterPoint) else {
                continue
            }
            let x = collectionView.frame.width / 2 - cell.frame.width / 2
            point.x = cell.frame.origin.x - x
            break
        }
        return point
    }
}

//func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        var visibleRect = CGRect()
//        visibleRect.origin = collectionV.contentOffset
//        visibleRect.size = collectionV.bounds.size
//
//        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
//        guard let indexPath = collectionV.indexPathForItem(at: visiblePoint) else { return }
