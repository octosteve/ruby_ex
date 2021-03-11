# frozen_string_literal: true

RSpec.describe RubyEx::GenServer do
  it "properlynames the process" do
  end

  it "returns the current state" do
    counter = RubyEx::GenServer.start(Counter, 1, name: "Counter")
    expect(Counter.get_state(counter)).to eq(1)
  end
#counter = GenServer.start(Counter, 1, name: "Counter")
#Counter.add(counter)
#Counter.add(counter)
#Counter.add(counter)
#Counter.get_state(counter)


end
