# frozen_string_literal: true

require "timeout"
module WithTimeout
  def receive_with_timeout(timeout)
    Timeout.timeout(timeout) do
      receive
    end
  rescue Timeout::Error
    :timeout
  end
end
Ractor.extend(WithTimeout)
