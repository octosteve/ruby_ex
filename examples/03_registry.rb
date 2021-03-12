# frozen_string_literal: true

registry = RubyEx::Registry.start
p "Registering #{Ractor.current}"
RubyEx::Registry.add(registry, :a_ractor, Ractor.current)
ractor = RubyEx::Registry.get(registry, :a_ractor)
p "You registered #{ractor}"

p "Removing From Registry"
RubyEx::Registry.remove(registry, :a_ractor)

ractor = RubyEx::Registry.get(registry, :a_ractor)
p "found ractor is #{ractor}"
