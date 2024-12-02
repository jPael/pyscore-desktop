class PostErrors {
  static String error(PostErrorCode codes) {
    switch (codes) {
      case PostErrorCode.postCreationError:
        return "There was an unexpected problem when creating your post. Please try again later";
      default:
        return "There was something wrong in the server. Please try again later";
    }
  }
}

enum PostErrorCode { postCreationError, serverError }
