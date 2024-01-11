import * as F from "@dashkite/joy/function"
import * as K from "@dashkite/katana/async"
import * as Meta from "@dashkite/joy/metaclass"
import * as R from "@dashkite/rio"
import * as Posh from "@dashkite/posh"
import Registry from "@dashkite/helium"

import { Resource, buildCredentials } from "@dashkite/vega-client"
import configuration from "#configuration"
import html from "./html"
import css from "./css"
import waiting from "#templates/waiting"

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
        R.call ->
          try
            credentials = buildCredentials {
              domain: configuration.db.domain
              name: "db"
              method: "get"
            }, "rune", includeBound: false
            await navigator.clipboard.writeText credentials
            queue = await Registry.get "messages"
            queue.enqueue type: "success", code: "copy-api-key"
          catch
            queue = await Registry.get "messages"
            queue.enqueue type: "failure"
      ]
    ]
  ]
