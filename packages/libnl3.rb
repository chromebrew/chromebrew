require 'package'

class Libnl3 < Package
  description 'libnl is a library for applications dealing with netlink sockets.'
  homepage 'http://www.infradead.org/~tgr/libnl/'
  @_ver = '3.5.0'
  version @_ver
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://github.com/thom311/libnl.git'
  git_hashtag 'libnl' + @_ver.gsub('.','_')

  def self.build
    system 'autoupdate'
    system './autogen.sh'
	  system "#{CREW_ENV_OPTIONS} ./configure #{CREW_OPTIONS} \
              --enable-cli \
              --enable-pthreads \
              --disable-debug"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end

  def self.check
    system "make", "check"
  end
end
