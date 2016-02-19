module ParkingsHelper
  def kinds
    Parking::KINDS.map{ |k| [t(k), k] }
  end
end
