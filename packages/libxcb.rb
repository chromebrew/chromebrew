require 'package'

class Libxcb < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.12'
  source_url 'https://www.x.org/archive/individual/xcb/libxcb-1.12.tar.gz'
  source_sha256 '092f147149d8a6410647a848378aaae749304d5b73e028ccb8306aa8a9e26f06'

  depends_on 'python27'
  depends_on 'xcb_proto'
  depends_on 'libxau'
  depends_on 'pthread_stubs'

  def self.build
    system "python=/usr/local/bin/python2.7 ./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
