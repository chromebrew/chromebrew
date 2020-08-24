require 'package'

class Gtkmm3 < Package
  description 'The Gtkmm3 package provides a C++ interface to GTK+ 3.'
  homepage 'https://www.gtkmm.org/'
  version '3.24.1'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/gnome/sources/gtkmm/3.24/gtkmm-3.24.1.tar.xz'
  source_sha256 'ddfe42ed2458a20a34de252854bcf4b52d3f0c671c045f56b42aa27c7542d2fd'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gtkmm3-3.24.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gtkmm3-3.24.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gtkmm3-3.24.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gtkmm3-3.24.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '86060a13fc77c19a96824ec0dfa5d2aca1efbf5f49f1c413dac08689709c7756',
     armv7l: '86060a13fc77c19a96824ec0dfa5d2aca1efbf5f49f1c413dac08689709c7756',
       i686: '9f3e44da54fc92ca271d659c089da52d7dadb30fbd8449f7cf9efacd847dafee',
     x86_64: 'a725c0b8d92256ba6a598de8f3bf7be4494b81be248013206d78e353dcba2c14',
  })

  depends_on 'atkmm'
  depends_on 'gtk3'
  depends_on 'pangomm'

  def self.build
    system "./configure #{CREW_OPTIONS}"
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
