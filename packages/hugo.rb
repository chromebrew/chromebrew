require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.60.1'

  case ARCH
  when 'aarch64','armv7l'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.60.1/hugo_0.60.1_Linux-ARM.tar.gz'
    source_sha256 '84ff6846cd39c6650e70528d4f318a664572e65f1dbbc8f42b779ed2f352b798'
  when 'i686'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.60.1/hugo_0.60.1_Linux-32bit.tar.gz'
    source_sha256 '610c39e6dd4b7bb25ad5b3e175cc36f62f2674cac4c768ae865be3e47083caa7'
  when 'x86_64'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.60.1/hugo_0.60.1_Linux-64bit.tar.gz'
    source_sha256 '54efec73f8aca18a3fa90e539dbe3b3b53e5d0c802ee724b2cbc63dae2fc17d3'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 hugo #{CREW_DEST_PREFIX}/bin/hugo"
  end
end
