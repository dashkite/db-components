import * as F from "@dashkite/joy/function"
import * as K from "@dashkite/katana/async"
import * as Meta from "@dashkite/joy/metaclass"
import * as R from "@dashkite/rio"
import * as Posh from "@dashkite/posh"
import Registry from "@dashkite/helium"

import { Resource } from "@dashkite/vega-client"

import configuration from "#configuration"

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
      R.activate [
        R.render waiting
        R.description
        K.poke ({ workspace, db, collection }) ->
          try
            { status } = await Resource.get
              origin: configuration.db.origin
              name: "collection status"
              bindings: { db, collection }
            collection_object = await Resource.get
              origin: configuration.db.origin
              name: "collection"
              bindings: { db, collection }
            if status == "ready"
              keys = await Resource.get
                origin: configuration.db.origin
                name: "metadata keys"
                bindings: { db, collection }
              indices = await Resource.get
                origin: configuration.db.origin
                name: "collection indices"
                bindings: { db, collection }
            { keys, collection: collection_object, db, workspace, indices, status }
          catch
            router = await Registry.get "router"
            router.browse
              name: "db"
              parameters: { workspace }
        R.render html
      ]
    ]
  ]
