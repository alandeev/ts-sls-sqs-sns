class ServerInternalError extends Error {
  isTreated = true;
  constructor(message?: string) {
    super("Server internal error");
    this.message = message ?? "Server internal error";
  }
}

export default ServerInternalError;
