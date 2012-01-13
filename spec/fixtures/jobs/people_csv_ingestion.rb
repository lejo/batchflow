job "ingest people csv" do |j|
  j.task "wait for file" do |t|
    t.triggered_by :type => :file, :path => "/path/to/people.csv", :events => [:create]
    t.runs         :anytime
    t.on_error     :notify
  end
  j.task "ingest file" do |t|
    t.triggered_by :type => :task, :name => "wait for file"
    t.execute :ingest
  end
end
