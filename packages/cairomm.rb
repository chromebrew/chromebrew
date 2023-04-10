require 'package'
require_relative 'cairomm_1_0'
require_relative 'cairomm_1_16'

class Cairomm < Package
  description Cairomm_1_0.description.to_s
  homepage Cairomm_1_0.homepage.to_s
  version "#{Cairomm_1_0.version}+#{Cairomm_1_16.version}"
  license Cairomm_1_0.license.to_s
  compatibility Cairomm_1_0.compatibility.to_s

  is_fake

  depends_on 'cairomm_1_0'
  depends_on 'cairomm_1_16'
end
