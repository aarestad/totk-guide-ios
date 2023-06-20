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
  fileprivate convenience init(from source: GroupJSON) {
    self.init(id: source.id, title: source.title, color: Color(hex:source.color))
  }
}

extension Region {
  fileprivate static func convert(from source: RegionJSON, regions: [RegionJSON]) -> Region {
    let region = Region(id: source.id, title: source.title)
    
    if let parentRegionID = source.parent_region_id {
      let regionJSON = regions.first { $0.id == parentRegionID }!
      region.parentRegion =  convert(from: regionJSON, regions: regions)
    }
    
    return region
  }
}

extension Category {
  fileprivate convenience init(from source: CategoryJSON, groups: [Group]) {
    self.init(
      id: source.id,
      group: groups.first{$0.id == source.group_id},
      title: source.title,
      icon: source.icon,
      info: source.info ?? "",
      template: source.template ?? ""
    )
  }
}

extension Location {
  fileprivate convenience init(from source: LocationJSON, regions: [Region], categories: [Category]) {
    self.init(
      id: source.id,
      region: regions.first { $0.id == source.region_id }!,
      category: categories.first { $0.id == source.category_id }!,
      title: source.title,
      description: source.description ?? "",
      latitude: Double(source.latitude) ?? 0,
      longitude: Double(source.longitude) ?? 0,
      media: source.media
    )
  }
}

extension MapData {
  fileprivate init(from source: MapDataSource) throws {
    let parsedGroups = source.groups.map { Group(from: $0 ) }
    var parsedRegions = source.regions.map { Region.convert(from:$0, regions: source.regions) }
    var parsedCategories = source.categories.values.map { Category(from: $0, groups: parsedGroups) }
    
    parsedRegions.sort { $0.title.description < $1.title.description }
    parsedCategories.sort { $0.title.description < $1.title.description }
    
    parsedRegions.insert(Region.all, at:0)
    parsedCategories.insert(Category.all, at:0)
    
    groups = parsedGroups
    categories = parsedCategories
    regions = parsedRegions
    locations = source.locations.map { Location(from: $0, regions: parsedRegions, categories: parsedCategories) }
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
