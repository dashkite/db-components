import * as K from "@dashkite/katana/async"
import * as Meta from "@dashkite/joy/metaclass"

import * as R from "@dashkite/rio"
import HTTP from "@dashkite/rio-vega"
import Router from "@dashkite/rio-oxygen"
import Subscription from "#helpers/subscription"

import * as Posh from "@dashkite/posh"

import  configuration from "#configuration"
{ origin } = configuration

import html from "./html"
import waiting from "./waiting"
import css from "./css"

class extends R.Handle

  Meta.mixin @, [
    R.tag "dashkite-db-delete"
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
        R.description
        R.render html
      ]

      R.click "button", [
        R.render waiting
        HTTP.delete
        Subscription.remove
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
