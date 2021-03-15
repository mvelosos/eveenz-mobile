class NewRequestCategoryVM {
  String name;

  Map<String, dynamic> getData() {
    return {
      'requestCategory': {
        'name': name,
      }
    };
  }
}
