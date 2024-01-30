import * as Meta from "@dashkite/joy/metaclass"

import * as R from "@dashkite/rio"
import HTTP from "@dashkite/rio-vega"
import Router from "@dashkite/rio-oxygen"
import Subscription from "#helpers/subscription"

import  configuration from "#configuration"
{ origin } = configuration

import html from "./html"
import waiting from "#templates/waiting"

class extends R.Handle

  Meta.mixin @, [
    R.tag "dashkite-db-add"
    R.diff
    R.initialize [

      R.shadow

      R.describe [
        HTTP.resource
          origin: origin
          name: "db create"
      ]

      R.activate [
        R.render html
        R.focus "input"        
      ]

      R.submit [
        R.render waiting
        R.form
        HTTP.post
        Subscription.update
        Router.browse ({ workspace }) ->
          name: "db"
          parameters: { workspace }
      ]

    ]
  ]
