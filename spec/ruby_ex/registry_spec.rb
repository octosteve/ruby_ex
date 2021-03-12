# frozen_string_literal: true

RSpec.describe RubyEx::Registry do
  it "registers a ractor" do
    registry = RubyEx::Registry.start
    RubyEx::Registry.add(registry, :the_test, Ractor.current)
    ractor = RubyEx::Registry.get(registry, :the_test)
    expect(ractor).to eq(Ractor.current)
  end

  it "removes a ractor" do
    registry = RubyEx::Registry.start
    RubyEx::Registry.add(registry, :the_test, Ractor.current)
    RubyEx::Registry.remove(registry, :the_test)
    ractor = RubyEx::Registry.get(registry, :the_test)
    expect(ractor).to be_nil
  end
end
