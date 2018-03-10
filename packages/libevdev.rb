require 'package'

class Libevdev < Package
  description 'libevdev is a wrapper library for evdev devices.'
  homepage 'https://www.freedesktop.org/wiki/Software/libevdev'
  version '1.5.9'
  source_url 'https://www.freedesktop.org/software/libevdev/libevdev-1.5.9.tar.xz'
  source_sha256 'e1663751443bed9d3e76a4fe2caf6fa866a79705d91cacad815c04e706198a75'

  depends_on 'doxygen'
  depends_on 'python27'
  
  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
