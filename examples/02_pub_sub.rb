# frozen_string_literal: true

pub_sub = RubyEx::PubSub.start
ref = RubyEx::PubSub.subscribe(pub_sub, :party_time)
RubyEx::PubSub.publish(pub_sub, :party_time, { time: "Party Time!" })
p Ractor.receive_with_timeout(1)
# unsubscribe
puts "Unsubscribing"

RubyEx::PubSub.unsubscribe(pub_sub, ref)
RubyEx::PubSub.publish(pub_sub, :party_time, { time: "Party Time!" })
p Ractor.receive_with_timeout(1)
