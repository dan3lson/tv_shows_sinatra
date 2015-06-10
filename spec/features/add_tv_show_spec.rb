require "spec_helper"

feature "user adds a new TV show" do
  # As a TV fanatic
  # I want to add one of my favorite shows
  # So that I can encourage others to binge watch it
  #
  # Acceptance Criteria:
  # * I must provide the title, network, and starting year.
  # * I can optionally provide the final year, genre, and synopsis.
  # * The synopsis can be no longer than 5000 characters.
  # * The starting year and ending year (if provided) must be
  #   greater than 1900.
  # * The genre must be one of the following: Action, Mystery,
  #   Drama, Comedy, Fantasy
  # * If any of the above validations fail, the form should be
  #   re-displayed with the failing validation message.

  scenario "successfully add a new show" do
    visit "/"
    click_on "Add New Show"
    fill_in "Title:", with: "Fresh Prince"
    fill_in "Network:", with: "DAR"
    fill_in "Starting Year:", with: "1988"
    click_on "Add TV Show"

    expect(page).to have_content("Fresh Prince")
    expect(page).to have_content("DAR")
    expect(page).to have_link("Add New Show")
  end

  scenario "fail to add a show with invalid information" do
    visit "/"
    click_on "Add New Show"
    fill_in "Title:", with: "Family Matters"
    fill_in "Network:", with: "ABC"
    fill_in "Starting Year:", with: "1987"
    select "Comedy", from: "Genre:"
    fill_in "Ending Year:", with: "3"
    click_on "Add TV Show"

    expect(page).to have_link("Back to all shows")
    expect(page).to have_button("Add TV Show")
    expect(page).to have_content("[\"Ending year must be greater than 1900\"]")
  end
end
