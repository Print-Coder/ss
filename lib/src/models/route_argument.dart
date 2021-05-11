class RouteArgument {
  String id;
  String heroTag;
  dynamic imageUrl;
  bool isLogin;
  RouteArgument({this.id, this.heroTag, this.imageUrl, this.isLogin});

  @override
  String toString() {
    return '{id: $id, heroTag:${heroTag.toString()}}';
  }
}
