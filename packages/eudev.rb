require 'buildsystems/autotools'

class Eudev < Autotools
  description 'Gentoo standalone udev'
  homepage 'https://wiki.gentoo.org/wiki/Project:Eudev'
  version '3.2.14'
  license 'LGPL-2.1, MIT and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/gentoo/eudev.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'f533cfaf65406ef7e16ddbdef10a0cb60068da3fb875874d1957811b706c9a86',
     armv7l: 'f533cfaf65406ef7e16ddbdef10a0cb60068da3fb875874d1957811b706c9a86',
       i686: '5667ea76c8eb854037e62d8cb06f59e1e0e318c88777849e2ec1ec2ce4c92526',
     x86_64: 'eaba1d39e5bf6fa886ef72e5d1aacf3236a76476c647da0e6587162bf0fe41f6'
  })

  depends_on 'acl' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gperf' => :build
  depends_on 'libxslt' => :build
  depends_on 'util_linux' # R

  def self.patch
    system 'sed -i s,/usr/bin/xsltproc,xsltproc,g man/make.sh'
  end

  configure_options '--enable-hwdb \
              --enable-rule-generator'
end
