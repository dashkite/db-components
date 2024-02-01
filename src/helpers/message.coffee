import * as K from "@dashkite/katana/async"
import Registry from "@dashkite/helium"

Message =

  # TODO handle case where specifier is a fn
  show: ( specifier ) ->
    K.peek ->
      queue = await Registry.get "messages"
      queue.enqueue specifier

export default Message
export { Message }