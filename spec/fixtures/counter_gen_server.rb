# frozen_string_literal: true

class Counter
  attr_reader :state

  def self.start(state, name:)
    RubyEx::GenServer.start(self, state, name: name)
  end

  def self.add(ractor, inc = 1)
    RubyEx::GenServer.async(ractor, [:add, inc])
  end

  def self.subtract(ractor, dec = 1)
    RubyEx::GenServer.async(ractor, [:subtract, dec])
  end

  def self.get_state(ractor)
    RubyEx::GenServer.get_state(ractor)
  end

  def initialize(state) = @state = state
  def add(inc = 1) = @state += inc
  def subtract(dec = 1) = @state -= dec
end
