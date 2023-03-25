/-  delta
/+  test
/=  agent  /app/delta

|%
:: Manually create a new bowl.
:: Copied from: https://github.com/sigilante/curriculum/blob/master/asl-2023.1/asl6.md#testing
++  bowl
  |=  run=@ud
  ^-  bowl:gall
  :*  [~dev ~dev %hark-store]
    [~ ~]
    [run `@uvJ`(shax run) (add (mul run ~s1) *time) [~zod %garden ud+run]]
  ==

:: Helper functions to create pokes
++  push
  |=  [test-value=@]
  ^-  (quip card:agent:gall agent:gall)
  =/  action  `action:delta`[%push target=~dev value=test-value]
  (~(on-poke agent (bowl 0)) %delta-action !>(action))
++  pop
  |=  [test-value=@]
  ^-  (quip card:agent:gall agent:gall)
  =/  action  `action:delta`[%pop target=~dev]
  (~(on-poke agent (bowl 0)) %delta-action !>(action))

:: Helper function to assert the current values list is as expected
++  assert-values
  |=  [expected-values=(list @)]
  :: Scry the remote state
  =/  values-cage  (need (need (on-peek:agent [%x /values])))
  =/  values  !<((list @) +.values-cage)

  %+  expect-eq:test
    !>(expected-values)
    !>(values)


::  Test pushing some values into the agent
++  test-push
  =|  run=@ud  :: I don't know what this does

  :: Poke the agent with a %push action
  =^  nothing1  agent
    (push 3)
  =^  nothing2  agent
    (push 3)
  =^  nothing3  agent
    (push 5)
  (assert-values ~[5 3 3])


::  Test popping some values off of the agent
++  test-pop
  =|  run=@ud  :: I don't know what this does

  :: Poke the agent with a %push action
  =^  nothing1  agent
    (push 1)
  =^  nothing2  agent
    (push 2)
  =^  nothing3  agent
    (push 3)
  =^  nothing3  agent
    (pop 3)

  (assert-values ~[2 1])
--
