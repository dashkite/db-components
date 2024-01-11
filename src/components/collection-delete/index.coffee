import * as F from "@dashkite/joy/function"
import * as K from "@dashkite/katana/async"
import * as Meta from "@dashkite/joy/metaclass"

import * as R from "@dashkite/rio"
import HTTP from "@dashkite/rio-vega"
import Router from "@dashkite/rio-oxygen"

import * as Posh from "@dashkite/posh"

import { origin } from "#configuration"

import html from "./html"
import css from "./css"

class extends R.Handle

  Meta.mixin @, [

    R.tag "dashkite-collection-delete"
    R.diff

    R.initialize [

      R.shadow

      R.sheets [ css, Posh.component ]

      R.describe [
        HTTP.resource ({ db, collection }) ->
          origin: origin
          name: "collection"
          bindings: { db, collection }
      ]

      R.activate [
        R.description
        R.render html
      ]

      R.click "button", [
        HTTP.delete
        R.description
        Router.browse ({ workspace }) ->
          name: "db"
          parameters: { workspace }
      ]

      R.click "a[name='cancel']", [
        Router.back
      ]
    ]
  ]
