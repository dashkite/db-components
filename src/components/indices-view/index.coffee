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
import waiting from "#templates/waiting"

class extends R.Handle

  Meta.mixin @, [

    R.tag "dashkite-collection-view"
    R.diff

    R.initialize [

      R.shadow
      R.sheets [ css, Posh.component ]

      R.describe [
        HTTP.resource ({ db, collection }) ->
          origin: origin
          name: "collection indices"
          bindings: { db, collection }
      ]

      R.activate [
        R.render waiting
        HTTP.get
        R.render html
      ]

    ]
  ]
