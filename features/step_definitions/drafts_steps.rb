Then /^I should see the current date/ do
  step %Q{I should see "Date: #{Time.now.in_time_zone.iso8601}"}
end
