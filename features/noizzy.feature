Feature: Instant, distraction-free focus
  Background:
    Given the curated sounds exist: "Rain", "Ocean", "Fan"
    And I am a first-time visitor

  @instant_start
  Scenario: One-click play from the homepage
    Given I visit the homepage
    When I click the "Instant Start" button
    Then I should see "Rain" as the current playing sound
    And I should see the timer counting up

  @play_pause
  Scenario: Pause and resume
    Given I visit the homepage
    And I start playing "Ocean"
    When I press the "Pause" control
    Then playback should be paused
    When I press the "Play" control
    Then playback should resume

  @switch_sound
  Scenario: Switch to another curated sound in one tap
    Given I visit the homepage
    And I start playing "Rain"
    When I choose the "Fan" sound
    Then I should see "Fan" as the current playing sound
    And the timer should not reset

  @volume_minimal
  Scenario: Adjust volume without extra UI noise
    Given I visit the homepage
    And I start playing "Rain"
    When I move the volume slider to 30 percent
    Then the current volume should be near "0.3"

  @favorite_local
  Scenario: Star a favorite sound (local only for Iteration 1)
    Given I visit the homepage
    And I start playing "Ocean"
    When I favorite "Ocean"
    Then "Ocean" should be in my favorites locally
