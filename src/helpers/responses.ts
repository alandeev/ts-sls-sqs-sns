const responses = {
  _construct: (statusCode: number, data?: any) => {
    return {
      statusCode,
      body: JSON.stringify(data)
    }
  },

  _error: (message: string, details=[]) => {
    return responses._construct(400, {
      error: {
        message,
        details
      }
    })
  },

  _success: (data?: any) => {
    return responses._construct(200, data);
  },

  _internal: (message) => {
    return responses._construct(500, {
      error: message || "Server internal error"
    })
  }
}

export default responses;

