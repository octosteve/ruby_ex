# frozen_string_literal: true

module RubyEx
  class Supervisor
    ChildSpec = Struct.new(:id, :object, :action, :args) do
      def start
        object.public_send(action, *args, name: id)
      end
    end

    def self.start(child_specs = [])
      GenServer.start(self, child_specs, name: "Supervisor")
    end

    def self.children(supervisor)
      GenServer.sync(supervisor, [:children])
    end

    def initialize(child_specs)
      @child_specs = child_specs
      @children_map = {}
      start_children
    end

    def children
      children_map.values
    end

    def crash(ractor_name)
      restart_child(ractor_name)
    end

    private

    attr_reader :child_specs, :children_map

    def start_children
      child_specs.each do |child|
        children_map[child.id] = start_child(child)
      end
    end

    def start_child(child)
      ractor = child.start
      track(ractor)
      ractor
    end

    def restart_child(ractor_name)
      child = child_specs.find {_1.id == ractor_name}
      children_map[child.id] = start_child(child)
    end

    def track(ractor)
      Ractor.new(ractor, Ractor.current) do |ractor, supervisor|
        Ractor.select(ractor)
      rescue Ractor:: RemoteError => e
        RubyEx::GenServer.async(supervisor, [:crash, e.ractor.name])
      end
    end
  end
end
