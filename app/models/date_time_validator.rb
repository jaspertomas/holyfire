class DateTimeValidator < ActiveModel::Validator
DATETIME_FORMAT = "%m/%d/%Y %I:%M %P"
def validate(record)
options[:fields].each do |field|
begin
# gotta use the actual string and not the rails fucked time that it 'conveniently' converts to UTC
record[field] = Time.strptime(record.send("#{field}_before_type_cast"), DATETIME_FORMAT)
rescue ArgumentError
record.errors.add(field, "is either invalid or blank")
end
end
end
end