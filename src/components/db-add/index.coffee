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
import waiting from "#templates/waiting"

class extends R.Handle

  Meta.mixin @, [
    R.tag "dashkite-db-add"
    R.diff
    R.initialize [

      R.shadow

      R.describe [
        HTTP.resource ({ workspace }) ->
          origin: origin
          name: "db create"
      ]

      R.activate [
        R.render html
        R.focus "input"        
      ]

      R.click "button", [
        R.validate
      ]

      R.valid [
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
