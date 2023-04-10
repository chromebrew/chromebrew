require 'package'
require_relative 'glibmm_2_4'
require_relative 'glibmm_2_68'

class Glibmm < Package
  description Glibmm_2_4.description.to_s
  homepage Glibmm_2_4.homepage.to_s
  version "#{Glibmm_2_4.version}+#{Glibmm_2_68.version}"
  license Glibmm_2_4.license.to_s
  compatibility Glibmm_2_4.compatibility.to_s

  is_fake

  depends_on 'glibmm_2_4'
  depends_on 'glibmm_2_68'
end
