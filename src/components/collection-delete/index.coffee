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
    R.tag "dashkite-collection-delete"
    R.diff
    R.initialize [
      R.shadow
      R.sheets [ css, Posh.component ]
      R.describe [
        K.poke ({ db, collection }) ->
          Resource.create 
            origin: configuration.db.origin
            name: "collection"
            bindings: { db, collection }
        R.set "resource"
        R.render html
      ]
      R.click "button", [
        R.call ->
          @resource.delete()
          undefined
        R.description
        Router.browse ({ workspace }) ->
          name: "db"
          parameters: { workspace }
      ]
      R.click "a[name='cancel']", [
        -> history.back()
      ]
    ]
  ]
