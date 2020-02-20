require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.65.1'

  case ARCH
  when 'aarch64','armv7l'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.65.1/hugo_0.65.1_Linux-ARM.tar.gz'
    source_sha256 'dc16bffc9f14cc7752447ab2d4193582f85f103958ed623cf051ed83158fcd23'
  when 'i686'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.65.1/hugo_0.65.1_Linux-32bit.tar.gz'
    source_sha256 '5a5050949900743281bd03c3e01bed62abc78a7245564391eb0606389e3bb4fb'
  when 'x86_64'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.65.1/hugo_0.65.1_Linux-64bit.tar.gz'
    source_sha256 '85db7ab38b326eecb899082622cdd785b0fa5ecca3edd91390c5dcffd055fc4b'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 hugo #{CREW_DEST_PREFIX}/bin/hugo"
  end
end
