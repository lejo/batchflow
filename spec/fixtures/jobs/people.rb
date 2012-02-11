job :people do
  task :ingest do
    triggered_by_file "/tmp/people.csv", :modify
    triggered_by_file "/tmp/people_friends.csv", :modify
  end
  task :ingestion_overun_notifier do
    triggered_at "10.am"
  end
  task :index do
    triggered_by_task :ingest
  end
  task :people_location_mappings do
    triggered_by_task :ingest
  end
  task :generate_timeline do
    triggered_by_task :ingest
    triggered_by_task :index
    triggered_by_task :people_location_mappings
  end
end
