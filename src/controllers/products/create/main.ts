import validate from './validate'

const main = async (event) => {
  const data = validate(event.body)

  return data;
}

export default main;
