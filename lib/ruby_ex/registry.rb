# frozen_string_literal: true

module RubyEx
  class Registry
    def self.start
      GenServer.start(self, {}, name: "Registry")
    end

    def self.add(agent, name, ractor)
      GenServer.async(agent, [:add, name, ractor])
    end

    def self.get(agent, name)
      GenServer.sync(agent, [:get, name])
    end

    def self.remove(agent, name)
      GenServer.sync(agent, [:remove, name])
    end

    def initialize(state = {})
      @state = state
    end

    def add(name, ractor)
      state[name] = ractor
    end

    def get(name)
      state[name]
    end

    def remove(name)
      state.delete(name)
    end

    private

    attr_reader :state
  end
end
