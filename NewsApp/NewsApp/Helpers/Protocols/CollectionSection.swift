//
//  CollectionSection.swift
//  NewsApp
//
//  Created by Rodolfo Alamer on 28/07/2021.
//  Copyright © 2021 Richard John Alamer. All rights reserved.
//

import Foundation

public protocol CollectionSection {
  
  associatedtype ItemType
  
  var items: [ItemType] { get set }
  
  var headerTitle: String? { get set }
  var footerTitle: String? { get set }
  
}

open class GenericCollectionSection<T>: CollectionSection {
  
  public typealias ItemType = T
  open var items: [T] = []
  
  open var headerTitle: String?
  open var footerTitle: String?
  
  public init() {}
  
}

