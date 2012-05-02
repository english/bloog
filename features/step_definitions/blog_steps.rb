When /^I go|return to the home page$/ do
  visit root_path
end

When /^I start a new post$/ do
  click_on 'New post...'
end

When /^I fill in the (\w+) "(.*)"$/ do |name, value|
  fill_in "post[#{name}]", with: value
end

When /^I submit the entry$/ do
  find('input[type=submit]').click
end

When /^I post an entry with these values:$/ do |table|
  step(%q{I go to the home page})
  step(%q{I start a new post})
  table.hashes.each do |property|
    step(%Q(I fill in the #{property['name']} "#{property['value']}"))
  end
  step('I submit the entry')
  step('I return to the home page')
end

When /^I post the following entries in order:$/ do |entries|
  entries.hashes.each do |attributes|
    values = table([['name', 'value']] + attributes.to_a)
    step('I post an entry with these values:', values)
    time_travel(60)
  end
end

When /^I look at posts tagged "(.*)"$/ do |tag|
  within('nav .tags') do
    click_on tag
  end
end


Then /^I should see the blog title$/ do
  page.text.must_include('Watching Paint Dry')
end

Then /^I should see a post with title "(.*)"$/ do |expected_title|
  posts = all(:css, 'article')
  on_not_found = ->{ flunk "No article found with title '#{expected_title}'" }
  @post = posts.detect(on_not_found){|p|
    p.has_css?('header h3', text: /#{expected_title}/)
  }
end

Then /^the post body should be:$/ do |expected_body|
  assert @post.has_css?('p', text: /#{expected_body}/)
end

Then /^the post should show image with URL "(.*)"$/ do |url|
  assert @post.has_css?("img[src='#{url}']")
end

Then /^I should see the following entries in order:$/ do |expected_entries|
  actual = all('article').map { |entry|
    [entry.find('h3').text, entry.all('header + p').map(&:text).join("\n")]
  }
  expected = expected_entries.hashes.map{|entry|
    [ entry['title'], entry['body'] ]
  }
  actual.must_equal(expected)
end

Then /^I should see tags: (.*)$/ do |expected_tags|
  expected = expected_tags.split(/\W+/)
  actual = all('nav .tags li').map(&:text).map(&:strip)
  actual.must_equal(expected)
end
