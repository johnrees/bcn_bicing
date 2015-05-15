class Recording < ActiveRecord::Base
  belongs_to :station

  default_scope { order('polled_at desc') }
end
