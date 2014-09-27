class UuidConstraint

  def matches?(request)
    UUID.validate request.params[:id]
  end

end
