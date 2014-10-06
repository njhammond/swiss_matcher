# Standalone test for Swiss matcher
#
# Run this from the directory above,
# ruby standalone_tests/1.rb
#
require './lib/swiss_matcher.rb'

########
# Make new helper methods
########
def make_new_event
  event = Hash.new
  event[:event_game_type] = 2  # 1=Pairs, 2=Teams.
  event
end

def make_new_session(session_number)
  session = Hash.new
  session[:session_number] = session_number
  session
end

def make_new_section(section_number)
  section = Hash.new
  section[:section_number] = section_number
  section
end

def make_new_team(team_number)
  team = Hash.new
  team[:team_number] = team_number
  # Note that score may be a float.
  team[:team_score] = 20 + rand(20)
  team[:team_is_stationary] = 0
  team[:team_withdrew_or_done_round_number] = 0
  team
end

def make_new_round(round_number)
  round = Hash.new
  round[:round_number] = round_number
  round
end

########
# Init code
########
event = make_new_event
session = make_new_session(1)
section = make_new_section(1)

teams = Array.new
(1..10).each do |count|
  team = make_new_team(count)
  teams << team
end

rounds = Array.new
(1..4).each do |count|
  round = make_new_round(count)
  rounds << round
end

new_matches = SwissMatcher.get_matches(event, session, section, teams, rounds[2])
SwissMatcher.debug_matches(new_matches)

## Add a team to make it a RR
team = make_new_team(teams.count + 1)
teams << team

puts "Added a RR. Number of teams=#{teams.count}"
new_matches = SwissMatcher.get_matches(event, session, section, teams, rounds[2])
SwissMatcher.debug_matches(new_matches)


