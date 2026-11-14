require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version %w[aarch64 armv7l x86_64].include?(ARCH) ? '0.170.0' : '0.101.0'
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
    aarch64: 'e03e0d0928cd4a8db7b6e6e7327cd8f033c8344803bd34a8297364706962544a',
     armv7l: 'e03e0d0928cd4a8db7b6e6e7327cd8f033c8344803bd34a8297364706962544a',
       i686: '9ae794edd86415a611cae15fc72382ee6f2b729754e15319c144057a5457eaed',
     x86_64: '0930754ec22ad2dd1a252f8c31a5e57faccc9d15f1c3d381ddafcb96eeb8aef0'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'hugo', "#{CREW_DEST_PREFIX}/bin/hugo", mode: 0o755
  end
end
