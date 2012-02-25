job :email_people_csv do
  task :email_when_present do
    triggered_by_file "/tmp/people.csv",:create
    triggered_by_file "/tmp/other.csv", :create
  end

  task :say_something do
    triggered_by_task :email_when_present
  end
end

