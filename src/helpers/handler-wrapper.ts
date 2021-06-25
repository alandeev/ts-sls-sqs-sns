import responses from "./responses";

const handlerWrapper = (fn) => {
  return async (event) => {
    try{
      if(event.body) {
        event.body = JSON.parse(event.body)
      }

      const response = await fn(event);
      return responses._success(response)
    } catch(error) {
      if(error.isTreated) {
        return responses._error(error.message, error.details)
      }

      console.log(error);
      return responses._internal(error.message)
    }
  }
}

export default handlerWrapper;
