module ExpireDataRemovable
  extend ActiveSupport::Concern

  class_methods do
    def run
      target.delete_all
    end

    private

    def target
      where('updated_at < ?' , target_date)
    end

    def target_date
      expire_day.days.ago.strftime("%Y-%m-%d 00:00:00")
    end

    def expire_day
      ENV['EXPIRE_DATA_REMOVE_DAY'].present? ? ENV['EXPIRE_DATA_REMOVE_DAY'].to_i : 30
    end
  end
end
