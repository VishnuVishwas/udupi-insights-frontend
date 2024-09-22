// explore_more_items.dart
class ExploreMoreItem {
  final int id;
  final String title;
  final String description;
  final String imageUrl;

  ExploreMoreItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

final List<ExploreMoreItem> exploreMoreItems = [
  ExploreMoreItem(
    id: 1,
    title: "Beach Activities",
    description:
        "Malpe Beach: One of the most popular beaches in Udupi, perfect for beach sports, swimming, and a relaxed vibe.\n"
        "\nSt. Mary's Island: Take a boat ride to this nearby island known for its unique rock formations and pristine beaches. It’s a great spot for photography and exploration.\n"
        "\nWater Sports at Malpe: Activities like Jet Skiing, Banana Boat Rides, and Parasailing are available here.",
    imageUrl: "assets/exploremore_images/beach.jpeg",
  ),
  ExploreMoreItem(
    id: 2,
    title: "Kayaking",
    description:
        "Kaup Beach (Kapu Beach): You can indulge in kayaking, boating, and paddle boating at some of the coastal stretches and backwaters near Udupi.\n"
        "\nSuvarna River Kayaking: Try river kayaking for a peaceful adventure along the Suvarna River.",
    imageUrl: "assets/exploremore_images/Kayaking.jpg",
  ),
  ExploreMoreItem(
    id: 3,
    title: "Snorkeling",
    description:
        "Udupi doesn't have extensive coral reefs for snorkeling or scuba diving like Goa, but you can head to nearby destinations like Murudeshwar (about 100 km away), which is famous for its diving sites.",
    imageUrl: "assets/exploremore_images/Snorkeling.jpg",
  ),
  ExploreMoreItem(
    id: 4,
    title: "Ballooning",
    description:
        "Ballooning and paragliding are not very common in Udupi, but you might find opportunities in nearby coastal cities like Mangalore, where such adventure activities are starting to gain popularity.",
    imageUrl: "assets/exploremore_images/Ballooning.jpg",
  ),
  ExploreMoreItem(
    id: 5,
    title: "Hiking and Trekking",
    description:
    "Kudlu Theertha Falls Trek: A beautiful trek through the Western Ghats leading to a majestic waterfall.\n"
        "\nAgumbe Rainforest: Known as the \"Cherrapunji of South India,\" Agumbe is located near Udupi. The rainforest offers numerous trekking options, wildlife, and beautiful views.\n"
        "\nKudremukh National Park: For those willing to travel a bit further, Kudremukh offers some of the best trekking trails in Karnataka.",
    imageUrl: "assets/exploremore_images/Hiking.jpg",
  ),
];
