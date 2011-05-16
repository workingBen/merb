class FullTestSlice::Application < Merb::Controller
  controller_for_slice

  include Merb::FullTestSlice::ApplicationHelper
end
