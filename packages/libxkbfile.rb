require 'package'

class Libxkbfile < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.0.9-0'
  source_url 'https://www.x.org/archive/individual/lib/libxkbfile-1.0.9.tar.gz'
  source_sha256 '95df50570f38e720fb79976f603761ae6eff761613eb56f258c3cb6bab4fd5e3'

  binary_url ({

  })
  binary_sha256 ({

  })

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
