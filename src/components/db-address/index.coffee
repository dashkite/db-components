import * as K from "@dashkite/katana/async"
import * as Meta from "@dashkite/joy/metaclass"

import * as R from "@dashkite/rio"
import HTTP from "@dashkite/rio-vega"
import Router from "@dashkite/rio-oxygen"
import Message from "#helpers/message"

import * as Posh from "@dashkite/posh"

import  configuration from "#configuration"
{ origin } = configuration

import html from "./html"
import css from "./css"

class extends R.Handle

  Meta.mixin @, [
    R.tag "dashkite-db-address"
    R.diff
    R.initialize [
      R.shadow
      R.sheets [ css, Posh.component ]
      R.describe [
        R.render html
      ]
      R.click "button", [
        R.description
        R.get "address"
        R.copy
        Message.show type: "success", code: "copy-address"
      ]
    ]
  ]
