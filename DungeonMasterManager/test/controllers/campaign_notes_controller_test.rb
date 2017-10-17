require 'test_helper'

class CampaignNotesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @campaign_note = campaign_notes(:one)
  end

  test "should get index" do
    get campaign_notes_url
    assert_response :success
  end

  test "should get new" do
    get new_campaign_note_url
    assert_response :success
  end

  test "should create campaign_note" do
    assert_difference('CampaignNote.count') do
      post campaign_notes_url, params: { campaign_note: { content: @campaign_note.content, dm_annotation: @campaign_note.dm_annotation, text: @campaign_note.text, title: @campaign_note.title, visible_by_players: @campaign_note.visible_by_players } }
    end

    assert_redirected_to campaign_note_url(CampaignNote.last)
  end

  test "should show campaign_note" do
    get campaign_note_url(@campaign_note)
    assert_response :success
  end

  test "should get edit" do
    get edit_campaign_note_url(@campaign_note)
    assert_response :success
  end

  test "should update campaign_note" do
    patch campaign_note_url(@campaign_note), params: { campaign_note: { content: @campaign_note.content, dm_annotation: @campaign_note.dm_annotation, text: @campaign_note.text, title: @campaign_note.title, visible_by_players: @campaign_note.visible_by_players } }
    assert_redirected_to campaign_note_url(@campaign_note)
  end

  test "should destroy campaign_note" do
    assert_difference('CampaignNote.count', -1) do
      delete campaign_note_url(@campaign_note)
    end

    assert_redirected_to campaign_notes_url
  end
end
