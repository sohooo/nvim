# frozen_string_literal: true

require_relative "calculator"

calculator = Demo::Calculator.new(1)

sum = calculator.add(2, 3)
product = calculator.multiply(sum, 4)

puts product
