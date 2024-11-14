require 'package'
Package.load_package("#{__dir__}/youtube_dl.rb")

class Youtubedl < Package
  description Youtube_dl.description
  homepage Youtube_dl.homepage
  version Youtube_dl.version
  license Youtube_dl.license
  compatibility Youtube_dl.compatibility

  is_fake

  depends_on 'youtube_dl'
end
