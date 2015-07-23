module RubyMotionQuery
  class AlertField

    attr_accessor :keyboard_type
    attr_accessor :placeholder
    attr_accessor :secure_text_entry
    attr_accessor :name

    def initialize(name, opts = {})
      raise ArgumentError.new "A name parameter must be provided" unless name && name.length > 0
      opts                = {placeholder: opts, keyboard_type: :default} if opts.is_a? String
      @name               = name.is_a?(Symbol) ? name : name.strip.gsub(/\s+/,'_').to_sym
      @keyboard_type      = RubyMotionQuery::Stylers::KEYBOARD_TYPES.has_key?(opts[:keyboard_type]) ? opts[:keyboard_type] : :default
      @placeholder        = opts[:placeholder] || ''
      @secure_text_entry  = opts[:secure_text_entry] || false
    end
  end
end
