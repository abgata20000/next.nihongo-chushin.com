module Confirmable
  extend ActiveSupport::Concern

  included do
    validates :confirming, acceptance: { accept: '1' }

    before_validation :check_confirming_back
    after_validation :check_confirming
  end

  def confirming?
    confirming == '1'
  end

  def confirming_back?
    confirming == 'back' || @is_confirming_back == true
  end

  private

  def check_confirming_back
    @is_confirming_back = confirming_back?
    self.confirming = '' if @is_confirming_back
    true
  end

  def check_confirming
    errors.delete(:confirming)
    self.confirming = errors.empty? ? '1' : nil unless @is_confirming_back
    true
  end
end
