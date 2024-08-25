require "application_system_test_case"

class DetectionsTest < ApplicationSystemTestCase
  setup do
    @detection = detections(:one)
  end

  test "visiting the index" do
    visit detections_url
    assert_selector "h1", text: "Detections"
  end

  test "should create detection" do
    visit detections_url
    click_on "New detection"

    fill_in "Plague", with: @detection.plague
    fill_in "Severity", with: @detection.severity
    click_on "Create Detection"

    assert_text "Detection was successfully created"
    click_on "Back"
  end

  test "should update Detection" do
    visit detection_url(@detection)
    click_on "Edit this detection", match: :first

    fill_in "Plague", with: @detection.plague
    fill_in "Severity", with: @detection.severity
    click_on "Update Detection"

    assert_text "Detection was successfully updated"
    click_on "Back"
  end

  test "should destroy Detection" do
    visit detection_url(@detection)
    click_on "Destroy this detection", match: :first

    assert_text "Detection was successfully destroyed"
  end
end
