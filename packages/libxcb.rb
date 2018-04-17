require 'package'

class Libxcb < Package
  description 'library for the X window system'
  homepage 'https://x.org'
  version '1.12-0'
  source_url 'https://www.x.org/archive/individual/xcb/libxcb-1.12.tar.gz'
  source_sha256 '092f147149d8a6410647a848378aaae749304d5b73e028ccb8306aa8a9e26f06'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/libxcb-1.12-0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/libxcb-1.12-0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/libxcb-1.12-0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/libxcb-1.12-0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '2efffcb6d5442087cd196c813756491617097f4749f7ff0ce71f71d6b70ccbf0',
     armv7l: '2efffcb6d5442087cd196c813756491617097f4749f7ff0ce71f71d6b70ccbf0',
       i686: 'dc4c741c4b94c0cebe7568e561bd7a739038689dcbbfa558194e5cf365f6674b',
     x86_64: 'ec938fc5753e9d7d5d67e38c4cf561be13a873d7b4343d4a9ca60d658dc35a70',
  })

  depends_on 'python27' => :build
  depends_on 'xcb_proto'
  depends_on 'libxau'
  depends_on 'pthread_stubs'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
