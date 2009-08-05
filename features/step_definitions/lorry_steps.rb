Given /I have gone to the new lorry page/ do
  visit "/lorries/new"
  true.should be_true
end

Given /^the following lorries:$/ do |lorries|
  Lorry.create!(lorries.hashes)
  Lorry.should have(lorries.hashes.length).records
end

When /^I delete the (\d+)(?:st|nd|rd|th) lorry$/ do |pos|
  visit lorries_url
  within("table > tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following lorries:$/ do |lorries|
  lorries.raw[1..-1].each_with_index do |row, i|
    row.each_with_index do |cell, j|
      response.should have_selector("table > tr:nth-child(#{i+2}) > td:nth-child(#{j+1})") { |td|
        td.inner_text.should == cell
      }
    end
  end
end

Given /^I have not created any lorries in this scenario$/ do
  # no-op
end

Given /^the previous scenarios have$/ do
  # no-op
end

Given /I have 45 pink lorries/ do
  raise "This is failing"
end

Then /^there should be 0 lorries$/ do
  Lorry.count.should == 0
end
