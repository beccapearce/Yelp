def sign_up
  visit'/'
  click_link 'Sign up'
  fill_in "Email", with: "becca@test.com"
  fill_in "Password", with: "password"
  fill_in "Password confirmation", with: "password"
  click_button 'Sign up'
end

def create_restaurant(restaurant_name)
  visit '/restaurants'
  click_link 'Add a restaurant'
  fill_in 'Name', with: restaurant_name
  click_button 'Create Restaurant'
end

def leave_review
  visit '/restaurants'
  click_link 'Review KFC'
  fill_in "Thoughts", with: "so so"
  select '3', from: 'Rating'
  click_button 'Leave Review'
end
