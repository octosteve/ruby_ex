# frozen_string_literal: true

module RubyEx
  class GenServer
    def self.start(template_object, state, name:)
      Ractor.new(template_object, state, name: name) do |template_object, state|
        instance = template_object.new(state)
        loop do
          case msg = Ractor.receive
            in [:sync, :get_state, from]
            from.send(instance.state)
            in [:sync, [message, *args], from]
            from.send(instance.public_send(message, *args))
            in [:async, [message, *args]]
            instance.public_send(message, *args)
            in msg
            puts "What?"
            p msg
          end
        end
      end
    end

    def self.async(ractor, msg)
      ractor.send([:async, msg])
    end

    def self.sync(ractor, msg)
      ractor.send([:sync, msg, Ractor.current])
      Ractor.receive_with_timeout(5)
    end

    def self.get_state(ractor)
      ractor.send([:sync, :get_state, Ractor.current])
      Ractor.receive_with_timeout(5)
    end
  end
end
