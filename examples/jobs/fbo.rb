job :fbo do

  trigger :directory do
    path   "/data/fbo"
    events [:new_file, :file_updated]
  end

  task :ingest do
    triggered_by :directory
    runs         :anytime
    execute      Fbo::Ingest
    on_error     Notify::Failure
    timeout      20.minutes
    on_timeout   :run => Notify::OverTime, :then => :continue
  end

  task :index do
    triggered_by :ingest_succeeded
    runs         :anytime
    execute      Fbo::Index
    timeout      1.hour
    on_timeout   :run => Notify::OverTime, :then => :continue
  end

  trigger :timer do
    time 5.am
    constraints :unless => :index_succeeded
  end
  
  task :raise_alarm do
    triggered_by :timer
    runs         :weekdays
    execute      Notify::Failure
  end

end
