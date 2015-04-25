module RubyMotionQuery
  class AlertAction

    VALID_STYLES = [:default, :destructive, :cancel]

    attr_reader :title
    attr_reader :tag
    attr_reader :style
    attr_reader :handler

    def initialize(opts = {}, &block)
      opts     = {title: opts} if opts.is_a? String
      @title   = opts[:title] || NSLocalizedString("OK", nil)
      @tag     = opts[:tag] || @title.gsub(/\s+/,"_").downcase.to_sym
      @style   = VALID_STYLES.include?(opts[:style]) ? opts[:style] : VALID_STYLES.first
      @handler = block if block_given?
    end

    def default?
      @style == :default
    end

    def destructive?
      @style == :destructive
    end

    def cancel?
      @style == :cancel
    end

  end
end
