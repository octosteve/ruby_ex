# frozen_string_literal: true

class CrankyProcess
  attr_reader :state

  def self.start(initial_state = 10, name:)
    RubyEx::GenServer.start(self, initial_state, name: name)
  end

  def self.double(ractor)
    RubyEx::GenServer.async(ractor, [:double])
  end

  def self.get_state(ractor)
    RubyEx::GenServer.get_state(ractor)
  end

  def self.crash(ractor)
    RubyEx::GenServer.async(ractor, [:crash])
  end

  def initialize(state)
    @state = state
  end

  def double
    @state *= 2
  end

  def crash
    raise :hell
  end
end
