job "email people csv" do |j|
	j.task "email when present" do |t|
    t.triggered_by :type => :file, :path => "/path/to/people.csv", :events => [:create]
  end
end

