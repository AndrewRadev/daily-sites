module Authentication
  def log_in_as(user)
    controller.stub(:current_user => user)
    @current_user = user
  end

  def log_out
    controller.stub(:current_user => nil)
    @current_user = nil
  end

  def current_user
    @current_user
  end
end
