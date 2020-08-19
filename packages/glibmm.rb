require 'package'

class Glibmm < Package
  description 'C++ bindings for GLib'
  homepage 'https://www.gtkmm.org'
  version '2.64.2'
  compatibility 'all'
  source_url 'https://ftp.gnome.org/pub/GNOME/sources/glibmm/2.64/glibmm-2.64.2.tar.xz'
  source_sha256 'a75282e58d556d9b2bb44262b6f5fb76c824ac46a25a06f527108bec86b8d4ec'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.64.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.64.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.64.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/glibmm-2.64.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '72bb27894e3eb810f9cb188a4b80c286213900f01b310ab39b6a68370e9dda3a',
     armv7l: '72bb27894e3eb810f9cb188a4b80c286213900f01b310ab39b6a68370e9dda3a',
       i686: '96cfa5d2030370e2dd75ac11dd6389eef53751dab7a66f20abd5f53eaa7ffa48',
     x86_64: '97c66ad7fb93bf2715de8cfda6ce6afeb0f83d5235602cd7ba3d4cc42f02c6eb',
  })

  depends_on 'libsigcplusplus'
  depends_on 'mm_common' => :build

  def self.build
    system "./configure #{CREW_OPTIONS} "
    system "make -j#{CREW_NPROC}"
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
