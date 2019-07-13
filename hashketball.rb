def game_hash
  game_hash = {home: {
    team_name: "Brooklyn Nets",
    colors: ["Black", "White"],
    players: [{"Alan Anderson" => {
      number: 0,
      shoe: 16,
      points: 22,
      rebounds: 12,
      assists: 12,
      steals: 3,
      blocks: 1,
      slam_dunks: 1}
      },
      {"Reggie Evans" => {
        number: 30,
        shoe: 14,
        points: 12,
        rebounds: 12,
        assists: 12,
        steals: 12,
        blocks: 12,
        slam_dunks: 7}
        },
        {"Brook Lopez" => {
          number: 11,
          shoe: 17,
          points: 17,
          rebounds: 19,
          assists: 10,
          steals: 3,
          blocks: 1,
          slam_dunks: 15}
          },
          {"Mason Plumlee" => {
            number: 1,
            shoe: 19,
            points: 26,
            rebounds: 11,
            assists: 6,
            steals: 3,
            blocks: 8,
            slam_dunks: 5}
            },
          {"Jason Terry" => {
              number: 31,
              shoe: 15,
              points: 19,
              rebounds: 2,
              assists: 2,
              steals: 4,
              blocks: 11,
              slam_dunks: 1}
              }
    ]
    },
    away: {
      team_name: "Charlotte Hornets",
      colors: ["Turquoise", "Purple"],
      players: [{"Jeff Adrien" => {
        number: 4,
        shoe: 18,
        points: 10,
        rebounds: 1,
        assists: 1,
        steals: 2,
        blocks: 7,
        slam_dunks: 2}
        },
        {"Bismack Biyombo" => {
          number: 0,
          shoe: 16,
          points: 12,
          rebounds: 4,
          assists: 7,
          steals: 22,
          blocks: 15,
          slam_dunks: 10}
          },
        {"DeSagna Diop" => {
            number: 2,
            shoe: 14,
            points: 24,
            rebounds: 12,
            assists: 12,
            steals: 4,
            blocks: 5,
            slam_dunks: 5}
            },
        {"Ben Gordon" => {
              number: 8,
              shoe: 15,
              points: 33,
              rebounds: 3,
              assists: 2,
              steals: 1,
              blocks: 1,
              slam_dunks: 0}
              },
        {"Kemba Walker" => {
                number: 33,
                shoe: 15,
                points: 6,
                rebounds: 12,
                assists: 12,
                steals: 7,
                blocks: 5,
                slam_dunks: 12}
                }]
      }
    }
end

def num_points_scored(player_name)
  game_hash.collect do |location, info|
    game_hash[location][:players].collect do |person|
      person.collect do |name, values|
        if name == player_name 
          values.collect do |statistics,val|
            if statistics == :points
              return val
            end
          end
        end
      end
    end
  end
end

def shoe_size(player_name)
  game_hash.collect do |location, info|
    game_hash[location][:players].collect do |person|
      person.collect do |name, values|
        if name == player_name 
          values.collect do |statistics,val|
           if statistics == :shoe
            return val
           end
          end
        end
      end
    end
  end
end

def team_colors(team)
  game_hash.collect do |location, info|
    if info[:team_name]== team
      return game_hash[location][:colors]
    end
  end
end

def team_names
arr = []
  game_hash.each do |location, info|
    info.each do |stats, value|
      if stats == :team_name
        arr << value
      end
    end
  end
  arr
end

def player_numbers(team_name)
arr = []
  game_hash.collect do |location, info|
    info.collect do |stats, value|
      if value == team_name
        game_hash[location][:players].collect do |person|
          person.collect do |name, values|
            values.collect do |statistics, val|
              if statistics == :number
                arr << val
              end
            end
          end
        end
      end
    end
  end 
  arr
end 

def player_stats(player_name)
  game_hash.collect do |location, info|
    info.collect do |stats, value|
      if stats == :players
        value.collect do |person|
          person.collect do |name, values|
            if name == player_name
              return values
            end
          end
        end
      end
    end
  end
end

def big_shoe_rebounds
arr = []
  game_hash.collect do |location, info|
    info.collect do |stats, value|
      if stats == :players
        value.collect do |person|
          person.collect do |name, val|
            val.collect do |statistics, x|
              if statistics == :shoe
                arr << x
              end
            end
          end
        end
      end
    end
  end
  game_hash.collect do |location, info|
    info.collect do |stats, value|
      if stats == :players
        value.collect do |person|
          person.collect do |name, val|
            val.collect do |statistics, x|
              if statistics == :shoe && x ==    arr.sort[-1]
                return val[:rebounds]
              end
            end
          end
        end
      end
    end
  end
end   

def most_points_scored
arr = []
  game_hash.collect do |location, info|
    info.collect do |stats, value|
      if stats == :players
        value.collect do |person|
          person.collect do |name, val|
            val.collect do |statistics, x|
              if statistics == :points
                arr << x
              end
            end
          end
        end
      end
    end
  end
  game_hash.collect do |location, info|
    info.collect do |stats, value|
      if stats == :players
        value.collect do |person|
          person.collect do |name, val|
            val.collect do |statistics, x|
              if statistics == :points && x ==    arr.sort[-1]
                return name
              end
            end
          end
        end
      end
    end
  end
end 

def winning_team
arr1 = []
arr2 = []
  game_hash.collect do |location, info|
    if location == :home
      info.collect do |stats, value|
        if stats == :players
          value.collect do |person|
            person.collect do |name, val|
              val.collect do |statistics, x|
                if statistics == :points
                  arr1 << x
                end
              end
            end
          end
        end
      end
    end
  end
  game_hash.collect do |location, info|
    if location == :away
      info.collect do |stats, value|
        if stats == :players
          value.collect do |person|
           person.collect do |name, val|
              val.collect do |statistics, x|
                if statistics == :points
                  arr2 << x
                end 
              end
            end
          end
        end
      end
    end
  end 
  if arr1.inject(:+) > arr2.inject(:+) 
    return game_hash[:home][:team_name]
  else 
    return game_hash[:away][:team_name]
  end
end 
