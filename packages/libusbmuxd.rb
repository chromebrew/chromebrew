require 'package'

class Libusbmuxd < Package
  description 'USB Multiplex Daemon'
  homepage 'http://www.libimobiledevice.org/'
  version '2.0.1'
  source_url 'https://github.com/libimobiledevice/libusbmuxd/archive/2.0.1.tar.gz'
  source_sha256 'f93faf3b3a73e283646f4d62b3421aeccf58142266b0eb22b2b13dd4b2362eb8'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'glib'
  depends_on 'libplist'

  def self.build
    system './autogen.sh'
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      "--libdir=#{CREW_LIB_PREFIX}",
      '--disable-dependency-tracking'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end

  def self.check
    system 'make', 'check'
  end
end
