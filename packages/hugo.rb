require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version '0.62.0'

  case ARCH
  when 'aarch64','armv7l'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.62.0/hugo_0.62.0_Linux-ARM.tar.gz'
    source_sha256 'fac4116c82ed7e4bc385fa03c33de074a02acde29b1a0817e87561fa62e8f951'
  when 'i686'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.62.0/hugo_0.62.0_Linux-32bit.tar.gz'
    source_sha256 'd3091184ebb3ce449c421f2aae49f5a0b29e66599d103a23ead13e3cab90d7f2'
  when 'x86_64'
    source_url 'https://github.com/gohugoio/hugo/releases/download/v0.62.0/hugo_0.62.0_Linux-64bit.tar.gz'
    source_sha256 '1c3f999320ae30f9b648f6f72305b126be7fd4bab9cb7edf74253c0cbe892c87'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 hugo #{CREW_DEST_PREFIX}/bin/hugo"
  end
end
