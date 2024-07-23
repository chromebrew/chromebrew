require 'package'
require_relative 'pangomm_1_4'
require_relative 'pangomm_2_48'

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
