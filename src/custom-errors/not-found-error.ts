class NotFoundError extends Error {
  isTreated = true;
  statusCode: 404;
  constructor(message: string) {
    super(message)
    this.message = message;
  }
}

export default NotFoundError;
