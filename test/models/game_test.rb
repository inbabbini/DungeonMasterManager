require 'test_helper'

class GameTest < ActiveSupport::TestCase

  test "Does not save without presence-required properties" do
    new_game = Game.new
    assert_not new_game.save

    new_game.name = "TestGame"
    assert_not new_game.save

    new_game.secret_key = "testkeytestkey"
    assert_not new_game.save

    new_game.dungeon_master = users(:iron)
    assert new_game.save
  end

  test "Non related user can join game" do
    new_user = User.new(name: "Test User", email: "test@dmm.com", password: "testtest")
    game = games(:ponchoServer)
    assert_difference 'Game.first.players.count' do
      game.add_player(new_user)
    end
  end

  test "Related user (player/DM) cannot join game" do
    game = games(:ponchoServer)
    related_player = game.players.first
    related_dm = game.dungeon_master
    assert_no_difference 'Game.first.players.count' do
      game.add_player(related_player)
    end
    assert_no_difference 'Game.first.players.count' do
      game.add_player(related_dm)
    end
  end

  test "is_related_to? returns true on user player or DM" do
    game = games(:ponchoServer)
    assert game.is_related_to? game.players.first
    assert game.is_related_to? game.dungeon_master
  end

  test "is_related_to? validates existing association with user" do
    game = games(:ponchoServer)
    assert_not game.is_related_to? users(:freshUser)
  end

  test "is_owned_by? validates ownership" do
    game = games(:ponchoServer)
    assert_not game.is_owned_by? game.players.first
    assert game.is_owned_by? game.dungeon_master
  end

end
