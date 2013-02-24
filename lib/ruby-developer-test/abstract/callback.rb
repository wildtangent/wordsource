# Module to add callback functionality to a class  
# http://coderrr.wordpress.com/2008/11/22/super-simple-callbacks-in-ruby/  
# Usage: 
#   Class MyEventedClass 
#     extend Callbacks
#   end
module Callbacks
  # Set up a callback of _name_ on the class.
  #
  # Define:
  #   callback :on_error
  #
  # Set up:
  #   on_error do |error|
  #     @errors << error
  #   end
  #
  # Call:
  #   on_error(error)
  def callback(*names)
    names.each do |name|
      class_eval <<-EOF
        def #{name}(*args, &block)
          @#{name} ||= []
          if block
            @#{name} << block
          elsif @#{name}
            @#{name}.each do |callback|
              callback.call(*args)
            end
          end
        end
      EOF
    end
  end
end
