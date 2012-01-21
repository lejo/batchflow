job :refresh_people_cache do |j|
  j.task :transform_file do |t|
    t.triggered_by :type => :file, :path => "/path/to/people_updates.csv"
  end
  j.task :refresh_cache do |t|
    t.triggered_by :type => :task, :name => :transform_file
  end
end
