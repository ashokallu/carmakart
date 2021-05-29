module Carmakart
  module Constants
    module ProductTypes
      Shirt = "Shirt"
      T_Shirt = "T-Shirt"
      Jeans = "Jeans"
      Sports_Shoes = "Sports Shoes"
      Running_Shoes = "Running Shoes"
    end

    module TopWearSizesMappings
      XS = "XS"
      S = "S"
      M = "M"
      L = "L"
      XL = "XL"
      XXL = "XXL"
      XXXL = "XXXL"
    end

    TopWearSizes = TopWearSizesMappings.constants.map {|const| TopWearSizesMappings.const_get(const)}

    WaistSizes = [*28..44]

    ShoeSizes = [*6..12]

    module TopWear
      ["Full Sleeve", "Half Sleeve", "Short Sleeve", "Sleeveless"]
    end
  end
end