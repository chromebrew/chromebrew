require 'package'

class Libevdev < Package
  description 'libevdev is a wrapper library for evdev devices.'
  homepage 'https://www.freedesktop.org/wiki/Software/libevdev'
  version '1.5.9-0'
  compatibility 'all'
  source_url 'https://www.freedesktop.org/software/libevdev/libevdev-1.5.9.tar.xz'
  source_sha256 'e1663751443bed9d3e76a4fe2caf6fa866a79705d91cacad815c04e706198a75'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libevdev-1.5.9-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libevdev-1.5.9-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libevdev-1.5.9-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libevdev-1.5.9-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'ee50da24a54da6574d50571871052104ed46256280f4bc7c5698e76d7ecf4fd3',
     armv7l: 'ee50da24a54da6574d50571871052104ed46256280f4bc7c5698e76d7ecf4fd3',
       i686: 'af2583a717277459bd65c27b994a36ef2fc1e018278773c831153abc871e567d',
     x86_64: '6f113678d99a5f4fc52db49702bb209e845de505c1bb456b4f2d1c862e9ff7ed',
  })

  depends_on 'doxygen' => :build
  depends_on 'python27' => :build

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
