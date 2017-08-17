require 'package'

class Github_release < Package
  description 'Commandline app to create and edit releases on Github (and upload artifacts)'
  homepage 'https://github.com/aktau/github-release'
  version '0.7.2'
  source_url 'https://github.com/aktau/github-release/archive/v0.7.2.tar.gz'
  source_sha256 '057d57b01cd45d0316e2d32b7593ff0f4bb493d4767b5701b21b54301d74ff48'

  depends_on 'go'

  def self.build
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "cp github-release #{CREW_DEST_DIR}/usr/local/bin"
  end
end
