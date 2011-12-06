action :company_ingestion do
    triggered_by => [:company_file_modified, :company_file_created]
      runs :daily, :before => 10.am, :fail => true
        on_failure :company_ingestion_failed
end

action :company_indexing do
    triggered_by => :company_ingestion_completed
end

action :company_district_mapping do
    triggered_by => :company_ingestion
end

trigger :company_file do
    runs :daily, :before => 4.am, :warn => true
      file => "/bb/gov/data/company.csv"
        on_failure => :company_file_failed
end

action :place_point_ingestion do
    triggered_by => [:company_ingestion_completed, :company_district_mapping_completed] || :ticker_values_changed,
end

class Action
    :triggers, :conditions
end

end
