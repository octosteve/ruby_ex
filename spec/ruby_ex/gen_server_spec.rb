# frozen_string_literal: true

RSpec.describe RubyEx::GenServer do
  it "returns the current state" do
    counter = RubyEx::GenServer.start(Counter, 1, name: "Counter")
    expect(Counter.get_state(counter)).to eq(1)
  end

  it "holds state" do
    counter = RubyEx::GenServer.start(Counter, 1, name: "Counter")
    Counter.add(counter)
    Counter.add(counter)
    Counter.add(counter)
    expect(Counter.get_state(counter)).to eq(4)
  end
end
