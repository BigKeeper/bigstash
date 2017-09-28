require 'big_stash/version'
require "big_stash/stash_operator"

module BigStash
  # Your code goes here...
end

ActionView::Base.send :include, BigStash::StashOperator
