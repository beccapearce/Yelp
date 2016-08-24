require 'rails_helper'

feature 'reviewing' do
  before { Restaurant.create name: 'KFC' }

  scenario 'allows users to leave a review using a form' do
    sign_up
    leave_review
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end
  scenario 'prevents users from leaving multiple reveiws' do
    sign_up
    leave_review
    leave_review
    expect(page).to have_content('One review per restaurant')
  end
  scenario 'allows users to delete their own reviews' do
    sign_up
    leave_review
    click_link 'delete review'
    expect(page).not_to have_content('so so')
  end
end
