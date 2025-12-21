require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version ARCH.eql?('i686') ? '0.101.0' : '0.153.1'
  license 'Apache-2.0, Unlicense, BSD, BSD-2 and MPL-2.0'
  compatibility 'all'
  min_glibc '2.29' if ARCH.eql?('x86_64')
  source_url({
    aarch64: "https://github.com/gohugoio/hugo/releases/download/v#{version}/hugo_#{version}_linux-arm.tar.gz",
     armv7l: "https://github.com/gohugoio/hugo/releases/download/v#{version}/hugo_#{version}_linux-arm.tar.gz",
       i686: "https://github.com/gohugoio/hugo/releases/download/v#{version}/hugo_#{version}_Linux-32bit.tar.gz", # 0.101.0 is the latest version available
     x86_64: "https://github.com/gohugoio/hugo/releases/download/v#{version}/hugo_extended_#{version}_linux-amd64.tar.gz"
  })
  source_sha256({
    aarch64: 'a26f56c368dd7077560d7e9ba57e6d95e5f143e1d0347a3a346c2715920fb658',
     armv7l: 'a26f56c368dd7077560d7e9ba57e6d95e5f143e1d0347a3a346c2715920fb658',
       i686: '9ae794edd86415a611cae15fc72382ee6f2b729754e15319c144057a5457eaed',
     x86_64: 'e5806957b8696d10a713199503b21b577abf92e1bcb85730124269479e7f5fc6'
  })

  no_compile_needed

  def self.install
    FileUtils.install 'hugo', "#{CREW_DEST_PREFIX}/bin/hugo", mode: 0o755
  end
end
