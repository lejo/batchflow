job "simple job" do |j|
  j.task "wait for file" do |t|
    t.triggered_by :type => :file, :path => "/path/to/file", :events => [:create]
#     # runs         :anytime
#     # execute      Alert::Send
#     # on_error     Notify::Failure
  end
  j.task "read file" do |t|
    t.triggered_by :type => :task, :name => "wait for file"
  end
end
