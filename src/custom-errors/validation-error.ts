class ValidationError extends Error {
  statusCode = 400;
  details = [];
  isTreated = true;

  constructor(message: string, details?: any) {
    super(message);
    this.message = message
    this.details = details
  }
}

export default ValidationError;
