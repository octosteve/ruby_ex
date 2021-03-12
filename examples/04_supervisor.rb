# frozen_string_literal: true

require_relative "../spec/fixtures/cranky_process.rb"
supervisor = RubyEx::Supervisor.start(
  [
    RubyEx::Supervisor::ChildSpec.new("cranky", CrankyProcess, :start, [5])
  ]
)

child = RubyEx::Supervisor.children(supervisor).first
CrankyProcess.double(child)
CrankyProcess.double(child)
p "Getting state"
p CrankyProcess.get_state(child)
p "Crashing Process"
CrankyProcess.crash(child)
sleep(0.5)
child = RubyEx::Supervisor.children(supervisor).first
p "Getting new state"
p CrankyProcess.get_state(child)
