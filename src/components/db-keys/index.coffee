import * as Meta from "@dashkite/joy/metaclass"

import * as R from "@dashkite/rio"

import * as Posh from "@dashkite/posh"

import html from "./html"
import css from "./css"

class extends R.Handle

  Meta.mixin @, [

    R.tag "dashkite-db-keys"
    R.diff

    R.initialize [

      R.shadow
      R.sheets [ css, Posh.component ]

      R.describe [
        R.render html
      ]

      R.click "button", [
        Credentials.build
        R.copy
        Message.show type: "success", code: "copy-api-key"
      ]
    ]
  ]
