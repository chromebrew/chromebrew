require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.65.2'

  case ARCH
  when 'aarch64','armv7l'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.65.2/hugo_0.65.2_Linux-ARM.tar.gz'
    source_sha256 'f39c7b77af5eac01d35b8b787ce88f51043f727ae1f970cd764401979a3d55b2'
  when 'i686'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.65.2/hugo_0.65.2_Linux-32bit.tar.gz'
    source_sha256 'a29016bd2e4ee612cb96476219f0da3acad4792ba68f3a94c442f7fa22064585'
  when 'x86_64'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.65.2/hugo_0.65.2_Linux-64bit.tar.gz'
    source_sha256 'e436760787a997136979edccb4779f2497792d6ada43036d5ec5b2320b266302'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 hugo #{CREW_DEST_PREFIX}/bin/hugo"
  end
end
