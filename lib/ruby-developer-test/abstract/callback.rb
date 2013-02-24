# module Callback
#   
#   def self.included(base)
#     base.send(:include, InstanceMethods)
#   end
#   
#   module InstanceMethods
#     
#     def callbacks
#       @callbacks ||= []
#     end
#     
#     # Basic callback pattern
#     def callback(*args, &block)
#       if block
#         callbacks << block
#       elsif callbacks
#         callbacks.each do |callback|
#           callback.call(*args)
#         end
#       end
#     end
#   end
#   
#   
#   
# end

module Callbacks
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
