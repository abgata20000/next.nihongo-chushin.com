module SupportActiveHash
  extend ActiveSupport::Concern

  included do
    # 短縮名
    field :short_name

    def short_name
      attributes.has_key?(:short_name) ? attributes[:short_name] : attributes[:name]
    end


  end


  class_methods do
    # 未選択を除く
    def enable
      all.select { |data| 0 < data.id }
    end

    def collection
      all.map { |data| [data.name, data.id.to_s] }
    end

    def ids
      all.map(&:id)
    end

    def to_array
      all.map(&:name)
    end

    def to_hash(options = {})
      Hash[
        all.map do |data|
          if options.key?(:except)
            options[:except].include?(data.id) ? nil : [data.id, data.name]
          else
            [data.id, data.name]
          end
        end.compact
      ]
    end

    def find_name(id)
      find_by(id: id).try(:name)
    end

    def enable_list
      except(0)
    end

    # 表示可能か?
    # (古い互換性のないジャンルは表示しない)
    def viewable?(id)
      enable_list.map { |item| item.id }.include?(id.to_i)
    end

    def except(*ids)
      all.select { |item| ids.include?(item.id) == false }
    end

  end

end
