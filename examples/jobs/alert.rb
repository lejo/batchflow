job :alert do

  task :send do
    triggered_by :fbo_index_succeeded,
                 :news_alert_ping,
                 :legislation_index_succeeded
    runs         :anytime
    execure      Alert::Send
    on_error     Notify::Failure
  end

end
