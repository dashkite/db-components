import * as K from "@dashkite/katana/async"
# TODO where does this belong?
import _Credentials from "@dashkite/sierra"

Credentials = 

  build: K.push ->
    _Credentials.build {
      domain: configuration.db.domain
      name: "db"
      method: "get"
    }, "rune", includeBound: false

export default Credentials