require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version %w[aarch64 armv7l x86_64].include?(ARCH) ? '0.169.0' : '0.101.0'
  license 'Apache-2.0, Unlicense, BSD, BSD-2 and MPL-2.0'
  compatibility 'all'
  min_glibc '2.29' if ARCH.eql?('x86_64')
  source_url({
    aarch64: "https://github.com/gohugoio/hugo/releases/download/v#{version}/hugo_#{version}_linux-arm.tar.gz",
     armv7l: "https://github.com/gohugoio/hugo/releases/download/v#{version}/hugo_#{version}_linux-arm.tar.gz",
       i686: 'https://github.com/gohugoio/hugo/releases/download/v0.101.0/hugo_0.101.0_Linux-32bit.tar.gz', # 0.101.0 is the latest version available
     x86_64: "https://github.com/gohugoio/hugo/releases/download/v#{version}/hugo_extended_#{version}_linux-amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'bbe6583bc0db6ce9150b9752d28b2ee2e1818d64f8fe0c7ec38c3d5cfd35c9ee',
     armv7l: 'bbe6583bc0db6ce9150b9752d28b2ee2e1818d64f8fe0c7ec38c3d5cfd35c9ee',
       i686: '9ae794edd86415a611cae15fc72382ee6f2b729754e15319c144057a5457eaed',
     x86_64: 'c41672a0725d307758a132bc94a962e59760eb33f9ba08c991b81f9881d6fa7d'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'hugo', "#{CREW_DEST_PREFIX}/bin/hugo", mode: 0o755
  end
end
