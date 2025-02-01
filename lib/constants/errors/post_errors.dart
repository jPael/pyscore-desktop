class PostErrors {
  static String error(PostErrorCode error) {
    switch (error) {
      case PostErrorCode.postCreationError:
        return "There was an unexpected problem when creating your post. Please try again later";
      case PostErrorCode.postDeletionFailed:
        return "Unable to delete post";
      case PostErrorCode.postUpdateError:
        return "There was an unexpected problem when updating your post. Please try again later";
      case PostErrorCode.postNotFound:
        return "Post not found";
      case PostErrorCode.error:
        return "There is something wrong. Please contact your IT";
      case PostErrorCode.noId:
        return "Please provide the user's ID to continue";
      case PostErrorCode.notConnected:
        return "Please connect to your server first.";
      default:
        return "There was something wrong in the server. Please try again later";
    }
  }
}

enum PostErrorCode {
  postNotFound,
  postCreationError,
  postDeletionFailed,
  serverError,
  postUpdateError,
  notConnected,
  noId,
  error
}
