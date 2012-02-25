job :refresh_people_cache do
  task :transform_file do
    triggered_by_file "/path/to/people_updates.csv", :create
  end
  task :refresh_cache do
    triggered_by_task :transform_file
  end
end
