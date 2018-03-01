require 'package'

class Libxcb < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.12'
  source_url 'https://www.x.org/archive/individual/xcb/libxcb-1.12.tar.gz'
  source_sha256 '092f147149d8a6410647a848378aaae749304d5b73e028ccb8306aa8a9e26f06'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxcb-1.12-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxcb-1.12-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxcb-1.12-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxcb-1.12-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '326bfe6776e7dd680d3f86e67276177d1fd0b3c5c8fab806e9eb5022d0e03544',
     armv7l: '326bfe6776e7dd680d3f86e67276177d1fd0b3c5c8fab806e9eb5022d0e03544',
       i686: 'fedc718aa92c142d05ede4b5b1059e51e589ffc547cd5dd02bcccc43cc3ecce2',
     x86_64: 'e68026a9ce6d39647790fa2f8f93c129070977c6d39c939d47ee5ec976a3da8a',
  })

  depends_on 'python27' => :build
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
