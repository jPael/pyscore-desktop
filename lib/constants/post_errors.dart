class PostErrors {
  static String error(PostErrorCode error) {
    switch (error) {
      case PostErrorCode.postCreationError:
        return "There was an unexpected problem when creating your post. Please try again later";
      case PostErrorCode.postDeletionFailed:
        return "Unable to delete post";
      case PostErrorCode.postUpdateError:
        return "There was an unexpected problem when updating your post. Please try again later";
      default:
        return "There was something wrong in the server. Please try again later";
    }
  }
}

enum PostErrorCode {
  postCreationError,
  postDeletionFailed,
  serverError,
  postUpdateError
}
