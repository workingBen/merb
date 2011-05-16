class <%= module_name %>::Application < Merb::Controller
  controller_for_slice

  include Merb::<%= module_name %>::ApplicationHelper
end
