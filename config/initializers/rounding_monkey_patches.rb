module RoundingHelper

  def round_to_quarter
    (self * 4).round / 4.0
  end

end

class BigDecimal
  include RoundingHelper
end

class Float
  include RoundingHelper
end

class Integer
  include RoundingHelper
end
