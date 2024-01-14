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
    R.tag "dashkite-db-home"
    R.diff

    R.initialize [
      R.shadow
      R.sheets [ css, Posh.component ]

      R.describe [
        HTTP.resource ({ workspace }) ->
          origin: origin
          name: "subscription"
          bindings:
            workspace: workspace
            product: "db"
      ]

      R.activate [
        R.render waiting
        R.description
        HTTP.get
        R.assign
        R.render html
      ]
    ]
  ]
