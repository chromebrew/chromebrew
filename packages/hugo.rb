require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.89.4'
  license 'Apache-2.0, Unlicense, BSD, BSD-2 and MPL-2.0'
  compatibility 'all'
  source_url ({
    aarch64: 'https://github.com/gohugoio/hugo/releases/download/v0.89.4/hugo_0.89.4_Linux-ARM.tar.gz',
     armv7l: 'https://github.com/gohugoio/hugo/releases/download/v0.89.4/hugo_0.89.4_Linux-ARM.tar.gz',
       i686: 'https://github.com/gohugoio/hugo/releases/download/v0.89.4/hugo_0.89.4_Linux-32bit.tar.gz',
     x86_64: 'https://github.com/gohugoio/hugo/releases/download/v0.89.4/hugo_extended_0.89.4_Linux-64bit.tar.gz',
  })
  source_sha256 ({
    aarch64: 'a8781ab0e61aa71c9084a23b908644296bb3390eda9cf5be78d2d225b5f0cc56',
     armv7l: 'a8781ab0e61aa71c9084a23b908644296bb3390eda9cf5be78d2d225b5f0cc56',
       i686: '1731fe5e9e7375d7c2d4f275d763957952734c4b52ed886d989b1112c3ff3a45',
     x86_64: '97743ff4026eb1f0f6ceeea91c5f8236b4833ecbe36370e91dfea247da56072e',
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin/hugo"
    FileUtils.install 'hugo', "#{CREW_DEST_PREFIX}/bin/hugo", mode: 0o755
  end
end
