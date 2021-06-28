const main = (event) => {
  for(const record of event.Records) {
    if(record.eventName !== "INSERT") {
      console.warn({
        status: "EVENT_NOT_IS_INSERT",
        message: "Stoped because eventName not is INSERT"
      })
      return;
    }

    console.info({
      message: "EVENTO PROCESSADO COM SUCESSO",
      event: JSON.stringify(record)
    })
  }
}

export default main;
