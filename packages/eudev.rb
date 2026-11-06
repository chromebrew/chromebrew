require 'buildsystems/autotools'

class Eudev < Autotools
  description 'Gentoo standalone udev'
  homepage 'https://wiki.gentoo.org/wiki/Project:Eudev'
  version '3.3.0'
  license 'LGPL-2.1, MIT and GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/gentoo/eudev.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'bc5e02fc6d2ca0683d051ffeb10a43f8b6526ca21e9545284d0addcaa1adba17',
     armv7l: 'bc5e02fc6d2ca0683d051ffeb10a43f8b6526ca21e9545284d0addcaa1adba17',
     x86_64: '2d9b7cece81d0f605006e776274c0b69d10ae16bd57885226a401904892cc495'
  })

  depends_on 'acl' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gperf' => :build
  depends_on 'libxslt' => :build
  depends_on 'util_linux' => :library

  def self.patch
    system 'sed -i s,/usr/bin/xsltproc,xsltproc,g man/make.sh'
  end

  autotools_configure_options '--enable-hwdb \
              --enable-rule-generator'
end
