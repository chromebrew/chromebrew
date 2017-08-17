require 'package'

class Filecmd < Package
  description 'file command determines the file type.'
  homepage 'ftp://ftp.astron.com/pub/file'
  version '5.31'
  source_url 'ftp://ftp.astron.com/pub/file/file-5.31.tar.gz'
  source_sha256 '09c588dac9cff4baa054f51a36141793bcf64926edc909594111ceae60fce4ee'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.31-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.31-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.31-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/filecmd-5.31-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f1c113f744602e5c86183a33257d14fe03f29369ee616c3e187ddbf3882ff1ee',
     armv7l: 'f1c113f744602e5c86183a33257d14fe03f29369ee616c3e187ddbf3882ff1ee',
       i686: '0a59ad47288c5272ac7f7e908a2a786512363937b9e4513c57e7f233cfd549f8',
     x86_64: '8af06683fb55abb471c43e7d847dc1bf4bd45bde15abefdaece7c7e3926c532f',
  })

  def self.build
    system "./configure --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
