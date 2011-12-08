job :fbo do

  trigger :new_fbo_file do
    path   "/data/fbo", :recursive => true
    events :new_file
  end

  task :ingest do
    triggered_by :new_fbo_file
    runs         :anytime
    execute      Fbo::Ingest
    on_error     Notify::Failure
    timeout      20.minutes
    on_timeout   :run => Notify::OverTime, :then => :continue
  end

  trigger :fbo_file_updated do
    path   "/data/fbo", :recursive => true
    events :file_updated
  end

  task :reingest do
    triggered_by :fbo_file_updated
    runs         :anytime
    execute      Fbo::Reingest
    on_error     Notify::Failure
    timeout      5.minutes
    on_timeout   :run => Notify::OverTime, :then => :abort
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
