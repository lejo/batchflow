job :email_people_csv do |j|
  j.task :email_when_present do |t|
    t.triggered_by :type => :file, :path => "/tmp/people.csv", :events => [:create]
    t.triggered_by :type => :file, :path => "/tmp/other.csv", :events => [:create]
  end

  j.task :say_something do |t|
    t.triggered_by :type => :task, :name => :email_when_present
  end
end

