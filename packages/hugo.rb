require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.92.2'
  license 'Apache-2.0, Unlicense, BSD, BSD-2 and MPL-2.0'
  compatibility 'all'
  source_url ({
    aarch64: 'https://github.com/gohugoio/hugo/releases/download/v0.92.2/hugo_0.92.2_Linux-ARM.tar.gz',
     armv7l: 'https://github.com/gohugoio/hugo/releases/download/v0.92.2/hugo_0.92.2_Linux-ARM.tar.gz',
       i686: 'https://github.com/gohugoio/hugo/releases/download/v0.92.2/hugo_0.92.2_Linux-32bit.tar.gz',
     x86_64: 'https://github.com/gohugoio/hugo/releases/download/v0.92.2/hugo_extended_0.92.2_Linux-64bit.tar.gz',
  })
  source_sha256 ({
    aarch64: '8a5b176768fb27d13bf665cf51ffd2d8fb71f2f382a887ab130c7ef927707fd5',
     armv7l: '8a5b176768fb27d13bf665cf51ffd2d8fb71f2f382a887ab130c7ef927707fd5',
       i686: '2f65f968b3288e0119035b49688bac52fd46707c95e635dcfc5a442e8b907f36',
     x86_64: 'e493b819c77b4f3af6b5ac4635c49311adc24a4ada109bd87452fb8bf5bef9ca',
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'hugo', "#{CREW_DEST_PREFIX}/bin/hugo", mode: 0o755
  end
end
