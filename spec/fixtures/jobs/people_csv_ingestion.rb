job :ingest_people_csv do
  task :wait_for_file do
    triggered_by :type => :file, :path => "/path/to/people.csv", :events => [:create]
  end
  task :ingest_file do
    triggered_by :type => :task, :name => :wait_for_file
  end
end
