import * as F from "@dashkite/joy/function"
import * as K from "@dashkite/katana/async"
import * as Meta from "@dashkite/joy/metaclass"
import * as R from "@dashkite/rio"
import * as Posh from "@dashkite/posh"
import Router from "@dashkite/rio-oxygen"

import { Resource } from "@dashkite/vega-client"

import configuration from "#configuration"

import html from "./html"
import css from "./css"
import waiting from "#templates/waiting"

class extends R.Handle

  Meta.mixin @, [
    R.tag "dashkite-db-editor"
    R.diff
    R.initialize [
      R.shadow
      R.sheets [ css, Posh.component ]
      R.activate [
        R.description
        K.poke ({ db }) ->
          Resource.create 
            origin: configuration.db.origin
            name: "db"
            bindings: { db }
        R.set "resource"
        R.description
        R.call ({ workspace, db }) -> 
          db_object = await @resource.get()
          { workspace, db: db_object }
        R.set "data"
        R.render html
        R.focus "input"
      ]
      R.click "button", [
        R.validate
      ]
      R.valid [
        R.form
        R.call ( form ) ->
          @resource.put { @data.db..., form... }
          undefined
        R.description
        Router.browse ({ workspace, db }) -> 
          name: "db-overview"
          parameters: { workspace, db }
      ]
      R.click "a[name='cancel']", [
        -> history.back()
      ]
    ]
  ]
