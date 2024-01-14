# TODO where does this belong?
import { buildCredentials } from "@dashkite/vega-client"


Credentials = 

  build: K.push ->
    buildCredentials {
      domain: configuration.db.domain
      name: "db"
      method: "get"
    }, "rune", includeBound: false

export default Credentials