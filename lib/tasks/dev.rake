desc "Fill the database tables with some sample data"
task sample_data: :environment do
  starting = Time.now

  if Rails.env.development?
    Matchup.delete_all
    Entry.delete_all
    Bracket.delete_all
  end

  b = Bracket.create(number_of_entries: 8)
  b.create_entries
  b.create_matchups
  b.assign_matchups

  ending = Time.now
  p "It took #{(ending - starting).to_i} seconds to create sample data."
  p "#{Bracket.count} bracket(s) created."
  p "#{Entry.count} entries created."
  p "#{Matchup.count} matchups created."
  
end