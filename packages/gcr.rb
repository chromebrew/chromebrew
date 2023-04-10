require 'package'
require_relative 'gcr_3'
require_relative 'gcr_4'

class Gcr < Package
  description Gcr_3.description.to_s
  homepage Gcr_3.homepage.to_s
  version "#{Gcr_3.version}+#{Gcr_4.version}"
  license Gcr_3.license.to_s
  compatibility Gcr_3.compatibility.to_s

  is_fake

  depends_on 'gcr_3'
  depends_on 'gcr_4'
end

