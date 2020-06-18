require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.72.0'
  compatibility 'all'

  case ARCH
  when 'aarch64','armv7l'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.72.0/hugo_0.72.0_Linux-ARM.tar.gz'
    source_sha256 'f5a969bab17a04ed0d08d5fcffa46275260977c7834f1268a7d1c938835c6f70'
  when 'i686'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.72.0/hugo_0.72.0_Linux-32bit.tar.gz'
    source_sha256 '573e41bf48b678ed909d4cf5b053fb4f259d672c0df7118ec980dcba000349fd'
  when 'x86_64'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.72.0/hugo_0.72.0_Linux-64bit.tar.gz'
    source_sha256 '28353611210d48c681f1f83a64ce36972d010e751f2794122db80f5060fe933d'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 hugo #{CREW_DEST_PREFIX}/bin/hugo"
  end
end
