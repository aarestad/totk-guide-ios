import Foundation
import SwiftUI

struct MapData {
  let groups: [Group]
  let categories: [Category]
  let regions: [Region]
  let locations: [Location]
  
  fileprivate static var mapData: MapData?
}

private struct MapDataSource: Decodable {
  var groups: [GroupJSON]
  var categories: [String:CategoryJSON]
  var regions: [RegionJSON]
  var locations: [LocationJSON]
}

private struct GroupJSON: Decodable {
  var id: Int
  var title: String
  var color: String
}

private struct RegionJSON: Decodable {
  var id: Int
  var parent_region_id: Int?
  var title: String
}

private struct CategoryJSON: Decodable {
  var id: Int
  var group_id: Int
  var title: String
  var icon: String
  var info: String?
  var template: String?
}

private struct LocationJSON: Decodable {
  var id: Int
  var region_id: Int
  var category_id: Int
  var title: String
  var description: String?
  var latitude: String
  var longitude: String
  var media: [Media]
}

extension Group {
  fileprivate static func convert(from source: GroupJSON) -> Group {
    let group = Group.empty()

    group.id = source.id
    group.title = source.title
    group.color = Color(hex:source.color)

    return group
  }
}

extension Region {
  fileprivate static func convert(from source: RegionJSON, regions: [RegionJSON]) throws -> Region {
    let region = Region.empty()
    region.id = source.id
    region.title = source.title
    
    if let parentRegionID = source.parent_region_id {
      let regionJSON = regions.first { $0.id == parentRegionID }!
      region.parentRegion = try convert(from: regionJSON, regions: regions)
    }
    
    return region
  }
}

extension Category {
  fileprivate static func convert(from source: CategoryJSON, groups: [Group]) -> Category {
    let category = Category.empty()
    
    category.id = source.id
    category.group = groups.first{$0.id == source.group_id}!
    category.title = source.title
    category.icon = source.icon
    category.info = source.info ?? ""
    category.template = source.template ?? ""
    
    return category
  }
}

extension Location {
  fileprivate static func convert(from source: LocationJSON, regions: [Region], categories: [Category]) -> Location {
    let location = Location.empty()
    location.id = source.id
    location.region = regions.first { $0.id == source.region_id }!
    location.category = categories.first { $0.id == source.category_id }!
    location.title = source.title
    location.description = try! AttributedString(
      markdown: source.description ?? "",
      options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)
    )
    location.latitude = Double(source.latitude) ?? 0
    location.longitude = Double(source.longitude) ?? 0
    location.media = source.media
    
    return location
  }
}

extension MapData {
  fileprivate init(from source: MapDataSource) throws {
    let parsedGroups = source.groups.map { Group.convert(from: $0 ) }
    var parsedRegions = try source.regions.map { try Region.convert(from:$0, regions: source.regions) }
    var parsedCategories = source.categories.values.map { Category.convert(from: $0, groups: parsedGroups) }
    
    parsedRegions.sort { $0.title < $1.title }
    parsedCategories.sort { $0.title < $1.title }
    
    parsedRegions.insert(Region.all, at:0)
    parsedCategories.insert(Category.all, at:0)
    
    groups = parsedGroups
    categories = parsedCategories
    regions = parsedRegions
    locations = source.locations.map { Location.convert(from: $0, regions: parsedRegions, categories: parsedCategories) }
  }
}

func initMapData() -> MapData {
  if MapData.mapData == nil {
    let filename = "map_data.json"
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
      fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
      data = try Data(contentsOf: file)
    } catch {
      fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    do {
      let decoder = JSONDecoder()
      let decoded = try decoder.decode(MapDataSource.self, from: data)
      MapData.mapData = try MapData.init(from:decoded)
    } catch {
      fatalError("Couldn't parse \(filename) as \(MapData.self):\n\(error)")
    }
  }
  
  return MapData.mapData!
}
