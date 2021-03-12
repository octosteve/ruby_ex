# frozen_string_literal: true

require_relative "../spec/fixtures/counter_gen_server.rb"
counter = Counter.start(1, name: "Counter")
Counter.add(counter)
Counter.add(counter)
Counter.add(counter)
p Counter.get_state(counter)
