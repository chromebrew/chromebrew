require 'package'

class Github_release < Package
  description 'Commandline app to create and edit releases on Github (and upload artifacts)'
  homepage 'https://github.com/aktau/github-release'
  version '0.7.2'
  compatibility 'all'
  source_url 'https://github.com/aktau/github-release/archive/v0.7.2.tar.gz'
  source_sha256 '057d57b01cd45d0316e2d32b7593ff0f4bb493d4767b5701b21b54301d74ff48'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/github_release-0.7.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/github_release-0.7.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/github_release-0.7.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/github_release-0.7.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '5877bb08e32cc5f7c53bddf4049a530d4ae277c991b3f38dec1def084c2ab212',
     armv7l: '5877bb08e32cc5f7c53bddf4049a530d4ae277c991b3f38dec1def084c2ab212',
       i686: 'd455a96fce6edcf315d89e53495f9b1704d1e4f9dfdeaa00c58e6e28facdb874',
     x86_64: 'f67e4d789cc86cf88c1aeb9dba109a935e07ad12f58ca3a5ab74d2e8bbb981e1',
  })

  depends_on 'go'

  def self.build
    system 'make'
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "cp github-release #{CREW_DEST_PREFIX}/bin"
  end
end
