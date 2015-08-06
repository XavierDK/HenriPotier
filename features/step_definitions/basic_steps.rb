Given /^Collection Books appeared$/ do
  check_element_exists("UICollectionView")
end

Then /^I touch collection item number (\d+)$/ do |row|
  touch("UICollectionViewCell indexPath:#{row},0")
end

Then /^I touch the "(.*?)" navbar button$/ do |name|
  touch("UINavigationButton marked:'#{name}'")
end