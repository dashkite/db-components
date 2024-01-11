import * as F from "@dashkite/joy/function"
import * as K from "@dashkite/katana/async"
import * as Meta from "@dashkite/joy/metaclass"
import * as R from "@dashkite/rio"
import * as Posh from "@dashkite/posh"
import Router from "@dashkite/rio-oxygen"

import { Resource } from "@dashkite/vega-client"

import configuration from "#configuration"

import html from "./html"

class extends R.Handle

  Meta.mixin @, [
    R.tag "dashkite-db-add"
    R.diff
    R.initialize [
      R.shadow
      R.describe [
        R.render html
        R.focus "input"
        R.description
        K.poke ({ workspace }) ->
          Resource.create 
            origin: configuration.db.origin
            name: "db create"
        R.set "db_resource"
        R.description
        K.poke ({ workspace }) ->
          Resource.create 
            origin: configuration.workspaces.origin
            name: "subscription-metadata"
            bindings:
              workspace: workspace
              product: "db"
        R.set "metadata_resource"
      ]
      R.click "button", [
        R.validate
      ]
      R.click "a[name='cancel']", [
        -> history.back()
      ]
      R.valid [
        R.form
        R.set "form"
        R.call ->
          { @form..., loading: true }
        R.render html
        R.call ->
          { db } = await @db_resource.post @form
          metadata = await @metadata_resource.get()
          metadata.addresses ?= []
          metadata.addresses.push db
          @metadata_resource.put metadata
        R.description
        Router.browse ({ workspace }) -> 
          name: "db"
          parameters: { workspace }
      ]
    ]
  ]
