job :email_people_csv do |j|
  j.task :email_when_present do |t|
    t.triggered_by :type => :file, :path => "/tmp/people.csv", :events => [:create]
    t.triggered_by :type => :file, :path => "/tmp/other.csv", :events => [:create]
  end
end

