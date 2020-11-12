Warning.module_eval do
  class RaisedWarning < StandardError ; end

  def self.with_raised_warnings(&block)
    alias warn_original warn
    alias warn raise_warning
    block.call if block_given?
  ensure
    alias warn warn_original
  end

  def raise_warning(msg)
    raise RaisedWarning, msg
  end
end
