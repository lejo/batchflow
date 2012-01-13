job :place_point do
  triggered_by ':ticker_values || (:company_ingested && :company_district_mapped)'
  trigger :ticker_values
end
