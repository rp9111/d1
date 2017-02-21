module Impressive
  extend ActiveSupport::Concern

  included do
    has_many :impressions, as: :impressionable, counter_cache: :impressions_count, dependent: :destroy
  end

  def impress(request, user)
    Impression.impress(self, request, user)
  end
end