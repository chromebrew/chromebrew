require 'package'
Package.load_package("#{__dir__}/gcr_3.rb")
Package.load_package("#{__dir__}/gcr_4.rb")

class Gcr < Package
  description Gcr_3.description
  homepage Gcr_3.homepage
  version "#{Gcr_3.version}+#{Gcr_4.version}"
  license Gcr_3.license
  compatibility Gcr_3.compatibility

  is_fake

  depends_on 'gcr_3'
  depends_on 'gcr_4'
end
