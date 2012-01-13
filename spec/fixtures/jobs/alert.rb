job "simple job" do
  task "wait for file" do
#     triggered_by :another_job_succeeded, :a_service_is_up
#     # runs         :anytime
#     # execute      Alert::Send
#     # on_error     Notify::Failure
  end
  task "read file" do

  end
end
