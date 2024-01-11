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
    R.tag "dashkite-collection-editor"
    R.diff
    R.initialize [
      R.shadow
      R.sheets [ css, Posh.component ]
      R.activate [
        R.description
        K.poke ({ workspace, db, collection }) ->
          Resource.create 
            origin: configuration.db.origin
            name: "collection"
            bindings: { db, collection }
        R.set "resource"
        R.description
        R.call ({ workspace, db }) -> 
          collection = await @resource.get()
          { workspace, db, collection }
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
          @resource.put { @data.collection..., form... }
          undefined
        R.description
        Router.browse ({ workspace, db, collection }) -> 
          name: "collection"
          parameters: { workspace, db, collection }
      ]
      R.click "a[name='cancel']", [
        -> history.back()
      ]
    ]
  ]
