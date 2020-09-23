
class ImageModel {
  int id;
  String title;
  String url;

  ImageModel({ this.id, this.title, this.url });

  ImageModel.fromJSON(Map<String, dynamic> encodedJSON) {
    id = encodedJSON['id'];
    title = encodedJSON['title'];
    url = encodedJSON['url'];
  }
}