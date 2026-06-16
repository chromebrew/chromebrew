require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version %w[aarch64 armv7l x86_64].include?(ARCH) ? '0.163.2' : '0.101.0'
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
    aarch64: 'da7b8e6470eea7a53f6bd4d358e57bf9bd0642807d2a4b01090f52389d5a741c',
     armv7l: 'da7b8e6470eea7a53f6bd4d358e57bf9bd0642807d2a4b01090f52389d5a741c',
       i686: '9ae794edd86415a611cae15fc72382ee6f2b729754e15319c144057a5457eaed',
     x86_64: 'a5de14c2accbde27bb9e73d110704e0c816b69f8a081704b4406281c5bf897c2'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'hugo', "#{CREW_DEST_PREFIX}/bin/hugo", mode: 0o755
  end
end
