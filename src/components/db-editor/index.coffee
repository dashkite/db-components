import * as Meta from "@dashkite/joy/metaclass"

import * as R from "@dashkite/rio"
import HTTP from "@dashkite/rio-vega"
import Router from "@dashkite/rio-oxygen"

import * as Posh from "@dashkite/posh"

import  configuration from "#configuration"
{ origin } = configuration

import html from "./html"
import waiting from "./waiting"
import css from "./css"

class extends R.Handle

  Meta.mixin @, [

    R.tag "dashkite-db-editor"
    R.diff

    R.initialize [

      R.shadow
      R.sheets [ css, Posh.component ]

      R.describe [
        HTTP.resource ({ db }) ->
          origin: origin
          name: "db"
          bindings: { db }
      ]

      R.activate [
        HTTP.get
        R.description
        R.assign
        R.render html
        R.focus "input"
      ]

      R.submit [
        R.render waiting
        HTTP.get
        R.form
        R.assign
        HTTP.put
        Router.browse ({ workspace, db }) -> 
          name: "db-overview"
          parameters: { workspace, db }
      ]

      R.click "a[name='cancel']", [
        Router.back
      ]

    ]
  ]
