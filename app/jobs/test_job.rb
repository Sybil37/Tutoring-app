class TestJob < ApplicationJob
  queue_as :default

  def perform(user)
    # Do something later
    sleep(10)
    user.update(email: user.email.gsub(".com", ".my")
  end
end
