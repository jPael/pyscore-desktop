class HostConnectErrors {
  static String error(HostConnectErrorCodes code) {
    switch (code) {
      case HostConnectErrorCodes.noIPAddressEntered:
        {
          return "Please enter the host's IP address and try again";
        }
      case HostConnectErrorCodes.noPortEntered:
        {
          return "Please enter the host's port and try again";
        }
      case HostConnectErrorCodes.hostNotFound:
        {
          return "Unable to find the host. Please check your ip and port make sure it matches the host's ip and port and try again";
        }
    }
  }
}

enum HostConnectErrorCodes { hostNotFound, noIPAddressEntered, noPortEntered }
