def mail
  ActionMailer::Base.deliveries.last
end
