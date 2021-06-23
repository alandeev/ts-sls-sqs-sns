class ValidationError extends Error {
  details = null;
  isTreated = true;

  constructor(message: string, details?: any) {
    super(message);
    this.message = message
    this.details = details
  }
}

export default ValidationError;
