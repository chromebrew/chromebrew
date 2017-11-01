require 'package'

class Libxkbfile < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.0.9'
  source_url 'https://www.x.org/archive/individual/lib/libxkbfile-1.0.9.tar.gz'
  source_sha256 '95df50570f38e720fb79976f603761ae6eff761613eb56f258c3cb6bab4fd5e3'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbfile-1.0.9-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbfile-1.0.9-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbfile-1.0.9-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxkbfile-1.0.9-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'd222e905fd312dc413722efc44f18cbc1168896f08023cb04a90b7b6e065d67f',
     armv7l: 'd222e905fd312dc413722efc44f18cbc1168896f08023cb04a90b7b6e065d67f',
       i686: '046be4d7969829495ada6d9d3f830e97ca2b65cfb3783b7cbf41675988c020f2',
     x86_64: '955ab05956064921cbc8add816de59af73493562a42d2853c8426852ac5eae04',
  })

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
