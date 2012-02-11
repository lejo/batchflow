job "email people csv" do
	task "email when present" do
    triggered_by :type => :file, :path => "/path/to/people.csv", :events => [:create]
  end
end

