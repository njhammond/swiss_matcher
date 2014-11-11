# Standalone test for Swiss matcher
#
# Run this from the directory above,
# ruby standalone_tests/1.rb
#
#
# Need to add: 
# Flags that will determine how to match
# Fields that are relevant to the algorithm
require './lib/swiss_matcher.rb'

# Any variable with a _100 at the end of it is an int * 100
# May seem a little strange, but it's part of some legacy code.

########
# Make new helper methods
########
def make_new_event
  event = Hash.new
  event[:event_game_type] = 2  # 1=Pairs, 2=Teams.
  event[:event_scoring_method] = 0  # Nicolas will define later.
  event[:event_team_round_one_pairing_option] = 0 # 2BD
  event[:event_team_vp_scale] = 0 # Nicolas 2BD. There are lots out there.
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
  section[:section_nrounds] = 4 # Max number of rounds in section.
  section[:section_maximum_vps_per_match] = 20 #
  section
end

def get_match_score()
	rand(20)
end

def make_new_team(team_number)
  team = Hash.new
  team[:team_number] = team_number
  # Note that score may be a float.
  #team[:team_score] = 20 + rand(20)
  team[:team_score] = 0

  # We may choose to break tie breaks based on number of matches won so far.
  # So pass in the field.
  team[:team_wins_100] = 0
  team[:team_is_stationary] = 0
  team[:team_withdrew_or_done_round_number] = 0
  # Can in theory have a result from a 1/2 match for Swiss Teams, the value would
  # be 50. The _100 allows for this field to be an int.
  team[:team_nmatches_played_100] = 0

  # Not sure all of these will be needed. Can discuss as we get to implementation.
  # If a team is on 'hold', you are not allowed to match them
  team[:team_hold] = 0

  # We may have better fields elsewhere, let's discuss
  team[:team_nmatches_reported] = 0
  team[:team_nmatches_assigned] = 0
  #      t.integer :team_allow_in_rr
  # Needed?
  team[:team_max_matches_to_play] = 0

  # It is possible, in some cases, for teams to be added to a Swiss. Highly unlikely.
  # Perhaps we ignore the possibility. But in theory, might be possible.
  # To be discussed. May affect requirements.
  team[:team_starting_round_number] = 0
  team
end

def make_new_round(round_number)
  round = Hash.new
  round[:round_number] = round_number
  round
end

# The matching options are really an attribute of a round.
# Complicated explanation of why separate. For now just assume so.
def make_new_matching_option(round_number)
  matching_option = Hash.new
  matching_option[:matching_option_round_number] = round_number
  matching_option
end

########
# Init code
########
event = make_new_event
# session_number
session = make_new_session(1)
# section_number
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

matching_options = Array.new
(1..4).each do |count|
  matching_option = make_new_matching_option(count)
  matching_options << matching_option
end

# Test the code
(1..4).each do |count|
	puts "Round #{count}"
	new_matches = SwissMatcher.get_matches(event, session, section, teams, rounds[count], matching_options[count])
	SwissMatcher.debug_matches(new_matches)
	new_matches.each { |match|
      if (match[:match_round_robin] == 0) then
		score = get_match_score();
		teams.each { |team|
			if ( team == match[:match_opp_1] ) then
				team[:team_score] += score
			end
			if ( team == match[:match_opp_2] ) then
				team[:team_score] += (20 - score)
			end
		}
	  end
      if (match[:match_round_robin] == 1) then
		if ( count % 2 == 0 )
			score = get_match_score();
			teams.each { |team|
				if ( team == match[:match_opp_1] ) then
					team[:team_score] += score
				end
				if ( team == match[:match_opp_2] ) then
					team[:team_score] += (20 - score)
				end
			}
			score = get_match_score();
			teams.each { |team|
				if ( team == match[:match_opp_2] ) then
					team[:team_score] += score
				end
				if ( team == match[:match_opp_3] ) then
					team[:team_score] += (20 - score)
				end
			}
			score = get_match_score();
			teams.each { |team|
				if ( team == match[:match_opp_3] ) then
					team[:team_score] += score
				end
				if ( team == match[:match_opp_1] ) then
					team[:team_score] += (20 - score)
				end
			}
		end
	  end
	}
end

## Add a team to make it a RR
#team = make_new_team(teams.count + 1)
#teams << team

#puts "Added a RR. Number of teams=#{teams.count}"
#new_matches = SwissMatcher.get_matches(event, session, section, teams, rounds[2], matching_options[2])
#SwissMatcher.debug_matches(new_matches)


