require 'package'
require_relative 'pangomm_1_4'
require_relative 'pangomm_2_48'

class Pangomm < Package
  description Pangomm_1_4.description.to_s
  homepage Pangomm_1_4.homepage.to_s
  version "#{Pangomm_1_4.version}+#{Pangomm_2_48.version}"
  license Pangomm_1_4.license.to_s
  compatibility Pangomm_1_4.compatibility.to_s

  is_fake

  depends_on 'pangomm_1_4'
  depends_on 'pangomm_2_48'
end
