require 'package'
require_relative 'youtube_dl'

class Youtubedl < Package
  description Youtube_dl.description.to_s
  homepage Youtube_dl.homepage.to_s
  version Youtube_dl.version.to_s
  license Youtube_dl.license.to_s
  compatibility Youtube_dl.compatibility.to_s

  is_fake

  depends_on 'youtube_dl'
end
