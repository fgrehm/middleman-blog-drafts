Then /^I should see the current date/ do
  step %Q{I should see "Date: #{Time.now.in_time_zone.iso8601}"}
end

Then /^the build directory should be empty/ do
  in_current_dir { Dir['build/**/*'].should be_empty }
end
