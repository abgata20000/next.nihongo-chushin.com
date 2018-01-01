# https://radicode.slack.com/archives/valuepress/p1483406200000062e
# application/controllers/api/pr_press.php[23]
class EmailValidator < ActiveModel::EachValidator
  def validate_each(object, attribute, value)
    return if value.blank?
    if value =~ /\A\S+@\S+\.\S+\z/
      if options[:not_duplication]
        scope = options[:scope] || object.class
        if scope.where("#{attribute}": value).first
          object.errors.add(attribute, :duplication_email)
          return false
        end
      elsif options[:exist]
        scope = options[:scope] || object.class
        unless scope.where("#{attribute}": value).first
          object.errors.add(attribute, :not_exist_email)
          return false
        end
      end
    else
      object.errors.add(attribute, :not_email)
      return false
    end
    true
  end
end
