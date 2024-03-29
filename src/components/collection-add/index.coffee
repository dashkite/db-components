import * as F from "@dashkite/joy/function"
import * as K from "@dashkite/katana/async"
import * as Meta from "@dashkite/joy/metaclass"

import * as R from "@dashkite/rio"
import HTTP from "@dashkite/rio-vega"
import Router from "@dashkite/rio-oxygen"

import * as Posh from "@dashkite/posh"

import configurations from "#configuration"

import html from "./html"
import waiting from "./waiting"
import css from "./css"

class extends R.Handle

  Meta.mixin @, [
    R.tag "dashkite-collection-add"
    R.diff
    R.initialize [
      R.shadow
      R.sheets [ css, Posh.component ]

      R.describe [
        HTTP.resource ({ db }) ->
          origin: configuration.origin
          name: "account"
          bindings: { db }
      ]

      R.activate [
        R.render html
        R.focus "input"
      ]

      R.click "button", [
        R.validate
      ]

      R.valid [
        R.form
        R.render waiting
        HTTP.post
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
