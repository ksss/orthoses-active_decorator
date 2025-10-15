require 'test_helper'

module ActiveDecoratorTest
  def test_active_decorator(t)
    store = Orthoses::ActiveDecorator.new(
      Orthoses::Store.new(->{})
    ).call
    actual = store["BookDecorator"].to_rbs
    expected = <<~RBS
      module BookDecorator : Book
      end
    RBS
    unless actual == expected
      t.error("\nexpected:\n```\n#{expected}```\n\nactual:\n```\n#{actual}```")
    end
  end
end
