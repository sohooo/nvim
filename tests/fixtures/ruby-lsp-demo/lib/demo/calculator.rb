# frozen_string_literal: true

module Demo
  class Calculator
    def initialize(offset = 0)
      @offset = offset
    end

    def add(left, right)
      left + right + @offset
    end

    def multiply(left, right)
      left * right
    end
  end
end
