require 'package'

class Erlang < Package
  description 'Erlang is a programming language used to build massively scalable soft real-time systems with requirements on high availability.'
  homepage 'http://www.erlang.org/'
  version '20.2'
  source_url 'http://erlang.org/download/otp_src_20.2.tar.gz'
  source_sha256 '24d9895e84b800bf0145d6b3042c2f2087eb31780a4a45565206844b41eb8f23'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/erlang-20.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/erlang-20.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/erlang-20.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/erlang-20.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '0a5d1b8e760bfc31ff1d41c23fc0b1678ab7b7dc661f8878177e4edff5383f23',
     armv7l: '0a5d1b8e760bfc31ff1d41c23fc0b1678ab7b7dc661f8878177e4edff5383f23',
       i686: '2088da5bc178d3bb9073d2f97e423af9c13f46103063018c20c22fe634376ae7',
     x86_64: '76207b1c87789aee5ee033debadaf0a7824c59f93ebd95695ad335e63e25cf27',
  })

  depends_on 'flex' => :build

  def self.build
    system 'export ERL_OTP=`pwd`'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end


  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
