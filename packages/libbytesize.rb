require 'package'

class Libbytesize < Package
  description 'A tiny library providing a C "class" for working with arbitrary big sizes in bytes'
  homepage 'https://github.com/storaged-project/libbytesize'
  version '2.6'
  license 'LGPL-2.1+'
  compatibility 'all'
  source_url 'https://github.com/storaged-project/libbytesize/releases/download/2.6/libbytesize-2.6.tar.gz'
  source_sha256 'efaa2b35b2bb3b52bf7b4ff5d0ed2c5c61360a5196053808d615dd0aa2cf0741'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libbytesize/2.6_armv7l/libbytesize-2.6-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libbytesize/2.6_armv7l/libbytesize-2.6-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libbytesize/2.6_i686/libbytesize-2.6-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libbytesize/2.6_x86_64/libbytesize-2.6-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '9746d6b1aeac798fb7ccf61f966a8b5caa9e27784a50d6ec1705fa8f08ceccc4',
     armv7l: '9746d6b1aeac798fb7ccf61f966a8b5caa9e27784a50d6ec1705fa8f08ceccc4',
       i686: '66660b4944b4bbf126f48a5417fae85d5e92548b7ccecc115b564305873132f7',
     x86_64: 'c586018630fefbd83711b0818a718c3d72cc92b3db4d12372b5b88d19b8756aa'
  })

  depends_on 'gawk' => :build

  def self.build
    system "./configure #{CREW_OPTIONS} --with-gtk-doc=no"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
