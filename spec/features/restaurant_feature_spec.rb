require 'rails_helper'

feature 'restaurants' do
  context 'no restaurant have been added' do
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link "Add a restaurant"
    end
  end
  context 'creating restaurants' do
    scenario 'signed in' do
      sign_up
      create_restaurant('KFC')
      expect(page).to have_content 'KFC'
      expect(current_path).to eq '/restaurants'
    end
    context 'user is not signed in and adds a restaurant' do
      scenario 'not signed in' do
        visit '/restaurants'
        click_link 'Add a restaurant'
        expect(page).to have_content 'You need to sign in or sign up before continuing.'
      end
    end
    context 'an invalid restaurant' do
      it 'does not let you submit a name that is too short' do
        sign_up
        create_restaurant('kf')
        expect(page).not_to have_css 'h2', text: 'kf'
        expect(page).to have_content 'error'
      end
    end
  end

  context 'viewing restaurants' do

    let!(:pizza_hut){ Restaurant.create(name:'Pizza Hut') }

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'Pizza Hut'
      expect(page).to have_content 'Pizza Hut'
      expect(current_path).to eq "/restaurants/#{pizza_hut.id}"
    end
  end
  context 'editing restaurants' do
    before do
      create_restaurant('KFC')
    end

    scenario 'let a user edit their restaurant' do
      sign_up
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Deep fried goodness'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content'Deep fried goodness'
      expect(current_path).to eq '/restaurants'
    end
    scenario 'forbid a user from editing someone else\s restaurant' do
      visit '/restaurants'
      click_link 'Edit KFC'
      expect(page).to have_content'You cannot edit someone else\s place'
    end
  end
  context 'deleting restaurants' do
    before do
      create_restaurant('KFC')
    end

    scenario 'signed in' do
      sign_up
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
    scenario 'not signed in' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
  end
end
