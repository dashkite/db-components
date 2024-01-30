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

    R.tag "dashkite-collection-editor"
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
        HTTP.get
        R.render html
        R.focus "input"
      ]
    
      R.submit [
        R.form
        HTTP.get
        R.assign
        HTTP.put
        Router.browse ({ workspace, db, collection }) -> 
          name: "collection"
          parameters: { workspace, db, collection }
      ]

      R.click "a[name='cancel']", [
        Router.back
      ]

    ]
  ]
