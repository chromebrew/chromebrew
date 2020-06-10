require 'package'

class Irssi < Package
  description 'Modular text mode IRC client with Perl scripting'
  homepage 'https://irssi.org/'
  version '1.2.2'
  compatibility 'all'
  source_url 'https://github.com/irssi/irssi/releases/download/1.2.2/irssi-1.2.2.tar.xz'
  source_sha256 '6727060c918568ba2ff4295ad736128dba0b995d7b20491bca11f593bd857578'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/irssi-1.2.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/irssi-1.2.2-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/irssi-1.2.2-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/irssi-1.2.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'cef7c8a7eae8b5c8b3436808ba40d7ee47b6bee964accc6869ccc31d0bbd0c48',
     armv7l: 'cef7c8a7eae8b5c8b3436808ba40d7ee47b6bee964accc6869ccc31d0bbd0c48',
       i686: '2b55ec2d8ee5db531e350efc6e64e2e64c5b3a980bc1cf491d79d76cb873bf80',
     x86_64: 'a507ca4d76b27659d03e421831da77ed161126ed7d8321cdd753fd4b45bd7536',
  })

  depends_on 'glib' => :build

  def self.build
    system './configure',
	     "--prefix=#{CREW_PREFIX}",
	     "--libdir=#{CREW_LIB_PREFIX}",
	     "--sysconfdir=#{CREW_PREFIX}/etc"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
