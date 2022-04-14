class Review {
  String? cirLogo;
  String? title;
  String? subTile;
  String? date;

  Review(
      {this.cirLogo, this.title, this.subTile, this.date});
}

List<Review> getReviewList() {
  List<Review> listA = [];

  listA.add(Review(
      cirLogo: "J",
      title: "Jesson Yo",
      date: "11/11/21",
      subTile:
          "Incredible feature provided, good job!"));
  listA.add(Review(
      cirLogo: "C",
      title: "Christian",
      date: "01/02/21",
      subTile:
          "Nice! keep up with the improvements!"));
  listA.add(Review(
      cirLogo: "H",
      title: "Hizkia",
      date: "11/27/20",
      subTile:
          "Average for me but overall experience is great"));
  listA.add(Review(
      cirLogo: "R",
      title: "Ryo",
      date: "09/24/21",
      subTile:
          "Crashed if you use it too long on my phone."));

  return listA;
}
