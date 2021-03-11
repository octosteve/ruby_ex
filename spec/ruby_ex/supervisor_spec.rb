# frozen_string_literal: true

RSpec.describe RubyEx::Supervisor do
  it "starts ractors" do
    supervisor = RubyEx::Supervisor.start(
      [
        RubyEx::Supervisor::ChildSpec.new("cranky", CrankyProcess, :start, [5])
      ]
    )

    children = RubyEx::Supervisor.children(supervisor)
    expect(children.count).to eq(1)
    expect(children.first).to be_a(Ractor)
  end

  it "has correct starting state" do
    supervisor = RubyEx::Supervisor.start(
      [
        RubyEx::Supervisor::ChildSpec.new("cranky", CrankyProcess, :start, [5])
      ]
    )

    child = RubyEx::Supervisor.children(supervisor).first
    CrankyProcess.double(child)
    expect(CrankyProcess.get_state(child)).to eq(10)
  end

  it "restarts a crashed process" do
    supervisor = RubyEx::Supervisor.start(
      [
        RubyEx::Supervisor::ChildSpec.new("cranky", CrankyProcess, :start, [5])
      ]
    )

    child = RubyEx::Supervisor.children(supervisor).first
    CrankyProcess.double(child)
    CrankyProcess.crash(child)
    sleep(0.5)
    child = RubyEx::Supervisor.children(supervisor).first
    expect(CrankyProcess.get_state(child)).to eq(5)
  end
end
