job :email_people_csv do
  task :email_when_present do
    triggered_by :type => :file, :path => "/tmp/people.csv", :events => [:create]
    triggered_by :type => :file, :path => "/tmp/other.csv", :events => [:create]
  end

  task :say_something do
    triggered_by :type => :task, :name => :email_when_present
  end
end

