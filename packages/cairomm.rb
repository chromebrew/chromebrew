require 'package'
Package.load_package("#{__dir__}/cairomm_1_0.rb")
Package.load_package("#{__dir__}/cairomm_1_16.rb")

class Cairomm < Package
  description Cairomm_1_0.description
  homepage Cairomm_1_0.homepage
  version "#{Cairomm_1_0.version}+#{Cairomm_1_16.version}"
  license Cairomm_1_0.license
  compatibility Cairomm_1_0.compatibility

  is_fake

  depends_on 'cairomm_1_0'
  depends_on 'cairomm_1_16'
end
