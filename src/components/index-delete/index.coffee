import * as Meta from "@dashkite/joy/metaclass"

import * as R from "@dashkite/rio"
import HTTP from "@dashkite/rio-vega"
import Router from "@dashkite/rio-oxygen"

import * as Posh from "@dashkite/posh"

import  configuration from "#configuration"
{ origin } = configuration

import html from "./html"
import css from "./css"

class extends R.Handle

  Meta.mixin @, [

    R.tag "dashkite-index-delete"
    R.diff

    R.initialize [

      R.shadow

      R.sheets [ css, Posh.component ]

      R.describe [
        HTTP.resource ({ db, collection, key, sort }) ->
          origin: origin
          name: "collection index"
          bindings: { db, collection, key, sort }
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
