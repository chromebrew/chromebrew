require 'package'

class Hugo < Package
  description 'Hugo is one of the most popular open-source static site generators.'
  homepage 'https://gohugo.io'
  version ARCH.eql?('i686') ? '0.101.0' : '0.132.1'
  license 'Apache-2.0, Unlicense, BSD, BSD-2 and MPL-2.0'
  compatibility 'all'
  source_url({
    aarch64: 'https://github.com/gohugoio/hugo/releases/download/v0.132.1/hugo_0.132.1_linux-arm.tar.gz',
     armv7l: 'https://github.com/gohugoio/hugo/releases/download/v0.132.1/hugo_0.132.1_linux-arm.tar.gz',
       i686: 'https://github.com/gohugoio/hugo/releases/download/v0.101.0/hugo_0.101.0_Linux-32bit.tar.gz', # 0.101.0 is the latest version available
     x86_64: 'https://github.com/gohugoio/hugo/releases/download/v0.132.1/hugo_extended_0.132.1_linux-amd64.tar.gz'
  })
  source_sha256({
    aarch64: 'b96d769b94477b75d50cab0e6b548c3b896a991692d000d9481b636e6fe6fdba',
     armv7l: 'b96d769b94477b75d50cab0e6b548c3b896a991692d000d9481b636e6fe6fdba',
       i686: '9ae794edd86415a611cae15fc72382ee6f2b729754e15319c144057a5457eaed',
     x86_64: '4280ee4823e8035ef83d1e1948184b3e1fa44f2280ea7bb64be60818e2b6ff14'
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'hugo', "#{CREW_DEST_PREFIX}/bin/hugo", mode: 0o755
  end
end
