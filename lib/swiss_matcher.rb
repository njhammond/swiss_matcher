module SwissMatcher

  # Return a possible empty array of matches.
  # Need to decide if passed in like this, or as @event, @session etc.
  def self.get_matches(event, session, section, teams, round)

    # Debug teams
    puts "Teams have NOT been sorted."
    debug_teams(teams)

    new_matches = Array.new

    nteams = teams.count

    return new_matches if (nteams <= 1)

    # Do we have a RR?
    has_rr = ((nteams % 2) > 0) ? 1 : 0

    # Sort based on score.
    teams.sort! { |x,y|
      y[:team_score] <=> x[:team_score]
    }

    puts "Teams have been sorted."
    debug_teams(teams)

    nhh = nteams / 2
    if (has_rr == 1) then
      nhh = nhh - 1
    end

    # Assign HH matches
    if (nhh > 1) then
      (1..nhh).each do |hh|
        t1 = (hh * 2) - 2
        t2 = (hh * 2) - 1
        match = {
          :match_opp_1 => teams[t1],
          :match_opp_2 => teams[t2],
          :match_opp_3 => 0,   # Nil
          :match_round_robin => 0,
          :match_nrounds => 1  # Should always be 1 for HH.
        }
        new_matches << match
      end
    end
    
    if (has_rr == 1) then
      # Sample RR match. RR over 2 rounds.
      t1 = nteams - 3
      t2 = nteams - 2
      t3 = nteams - 1
      match = {
        :match_opp_1 => teams[t1],
        :match_opp_2 => teams[t2],
        :match_opp_3 => teams[t3],
        :match_round_robin => 1,  # Use 0/1 not false/true. Long story.
        :match_nrounds => 2
      }
      new_matches << match
    end

    # Return the new matches
    new_matches
  end

	##########
	# Debug code
	##########
  # Debug utility to print values of the teams array
  def self.debug_teams(teams)
    teams.each do |team|
      puts "Team #{team[:team_number]} has score #{team[:team_score]}"
    end
  end

  # Debug utility to print values of the matches array
  def self.debug_matches(matches)
    count = 0
    matches.each do |match|
      count = count + 1
      if (match[:match_round_robin] == 0) then
        tm_1 = match[:match_opp_1]
        tm_2 = match[:match_opp_2]
        puts "Match #{count}. HH: #{tm_1[:team_number]} v. #{tm_2[:team_number]}."
      end
      if (match[:match_round_robin] == 1) then
        tm_1 = match[:match_opp_1]
        tm_2 = match[:match_opp_2]
        tm_3 = match[:match_opp_3]
        puts "Match #{count}. RR: #{tm_1[:team_number]} v. #{tm_2[:team_number]} v. #{tm_3[:team_number]}. Rounds: #{match[:match_nrounds]} "
      end
    end
  end

end
