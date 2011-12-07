job :company do
  triggered_by :file
  runs         :daily
  tasks        [:ingest, :index, :district_map]
  on_success   :placepoint

  trigger :file do
    path ["/data/companies.csv", "/data/company_leaders.csv"]
  end

  task :ingest do
    constraints :before => 10.am
    on_error    :ingestion_failed
  end

  task :index
  task :district_map
end
