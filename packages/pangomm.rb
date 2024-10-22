require 'package'
Package.load_package("#{__dir__}/pangomm_1_4.rb")
Package.load_package("#{__dir__}/pangomm_2_48.rb")

class Pangomm < Package
  description Pangomm_1_4.description
  homepage Pangomm_1_4.homepage
  version "#{Pangomm_1_4.version}+#{Pangomm_2_48.version}"
  license Pangomm_1_4.license
  compatibility Pangomm_1_4.compatibility

  is_fake

  depends_on 'pangomm_1_4'
  depends_on 'pangomm_2_48'
end
