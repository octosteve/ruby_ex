# frozen_string_literal: true

RSpec.describe RubyEx::PubSub do
  it "allows processes to subscribe to an event" do
    pub_sub = RubyEx::PubSub.start
    RubyEx::PubSub.subscribe(pub_sub, :party_time)
    RubyEx::PubSub.publish(pub_sub, :party_time, { time: "Party Time!" })
    message = Ractor.receive_with_timeout(1)
    expect(message).to eq([:event, :party_time, { time: "Party Time!" }])
  end

  it "allows processes to unsubscribe to no longer receive messages" do
    pub_sub = RubyEx::PubSub.start
    ref = RubyEx::PubSub.subscribe(pub_sub, :party_time)
    RubyEx::PubSub.unsubscribe(pub_sub, ref)
    RubyEx::PubSub.publish(pub_sub, :party_time, { time: "Party Time!" })
    message = Ractor.receive_with_timeout(1)
    expect(message).to eq(:timeout)
  end
end
