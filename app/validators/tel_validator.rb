class TelValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.blank?
    if (/\A[0-9][-0-9]*[0-9]\Z/ =~ value).nil?
      record.errors.add(attribute, "正しい番号形式ではありません")
    end
  end
end
