# Add a declarative step here for populating the DB with movies.

rows = 0

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.new(movie).save
    
    rows+=1
  end
  # fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end


# Make sure that one string (regexp) occurs before or after another one
#   on the same page

When /^I press '(.*)'/ do |button|
  click_button button
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(/[\s\S]*#{e1}[\s\S]*#{e1}/).to match(page.body)
  # fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  # part 2.2
  rating_array = rating_list.split(', ')
  rating_array.each do |rating|
    if !uncheck.nil?
      uncheck("ratings[#{rating}]")
    else
      check("ratings[#{rating}]")
    end
  end
  # fail "Unimplemented"
end

Then /I should (not )?see: (.*)$/ do |should_not, movies_list|
  
  movies = movies_list.split(", ")
  movies.each do |movie|
    if should_not.nil?
      expect(page).to have_content(movie)
    else
      expect(page).not_to have_content(movie)
    end
  end
  rows = 0
end

Then /I should see all of the movies/ do
  # Make sure that all the movies in the app are visible in the table
  expect(rows).to eq 10
  # fail "Unimplemented"
end