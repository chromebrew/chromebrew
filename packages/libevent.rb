require 'package'

class Libevent < Package
  description 'Event notification library'
  homepage 'http://libevent.org/'
  version '2.1.11'
  source_url 'https://github.com/libevent/libevent/archive/release-2.1.11-stable.tar.gz'
  source_sha256 '229393ab2bf0dc94694f21836846b424f3532585bac3468738b7bf752c03901e'

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.build
    system './autogen.sh'
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
