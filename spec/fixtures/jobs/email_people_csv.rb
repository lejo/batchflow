job "email people csv" do
	task "email when present" do
    triggered_by_file "/path/to/people.csv", :create
  end
end

