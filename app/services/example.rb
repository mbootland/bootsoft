# frozen_string_literal: true

class Example
  def initialize(example)
    @example = example
  end

  def self.example_method
    puts @example
  end
end
