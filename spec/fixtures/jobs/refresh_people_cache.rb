job :refresh_people_cache do
  task :transform_file do
    triggered_by :type => :file, :path => "/path/to/people_updates.csv"
  end
  task :refresh_cache do
    triggered_by :type => :task, :name => :transform_file
  end
end
