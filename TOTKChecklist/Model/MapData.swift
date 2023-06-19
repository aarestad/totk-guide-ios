import Foundation

struct MapData {
  var groups: [Group] = []
  var categories: [Category] = []
  var regions: [Region] = []
  var locations: [Location] = []
}

private struct MapDataSource: Decodable {
  var groups: [Group]
  var categories: [String:CategoryJSON]
  var regions: [RegionJSON]
  var locations: [LocationJSON]
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

extension Region {
  fileprivate static func convert(from source: RegionJSON, regions: [Int:RegionJSON]) throws -> Region {
    let region = try Region.empty()
    region.id = source.id
    region.title = source.title
    
    if let regionJSON = regions[source.parent_region_id ?? -1] {
      region.parentRegion = try convert(from: regionJSON, regions: regions)
    }
    
    return region
  }
}

extension Category {
  fileprivate init(from source: CategoryJSON, groups: [Int:Group]) {
    id = source.id
    group = groups[source.group_id]!
    title = source.title
    icon = source.icon
    info = source.info ?? ""
    template = source.template ?? ""
  }
}

extension Location {
  fileprivate init(from source: LocationJSON, regions: [Region], categories: [Category]) {
    id = source.id
    region = regions.first { $0.id == source.region_id }!
    category = categories.first { $0.id == source.category_id }!
    title = source.title
    description = AttributedString(source.description ?? "")
    latitude = Double(source.latitude) ?? 0
    longitude = Double(source.longitude) ?? 0
    media = source.media
  }
}

extension MapData {
  fileprivate init(from source: MapDataSource) throws {
    let groupsDict = Dictionary(uniqueKeysWithValues: source.groups.map { (Int(exactly: $0.id)!, $0) })
    let regionsDict = Dictionary(uniqueKeysWithValues: source.regions.map { (Int(exactly: $0.id)!, $0) })
    
    groups = source.groups
    categories = source.categories.values.map { Category.init(from: $0, groups: groupsDict) }
    regions = try source.regions.map { try Region.convert(from:$0, regions: regionsDict) }
    locations = source.locations.map { Location.init(from: $0, regions: regions, categories: categories) }
  }
}

func initMapData() -> MapData {
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
    return try MapData.init(from:decoded)
  } catch {
    fatalError("Couldn't parse \(filename) as \(MapData.self):\n\(error)")
  }
}
