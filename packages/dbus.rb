require 'package'

class Dbus < Package
  description 'D-Bus is a message bus system, a simple way for applications to talk to one another.'
  homepage 'https://www.freedesktop.org/wiki/Software/dbus/'
  version '1.11.14'
  source_url 'https://dbus.freedesktop.org/releases/dbus/dbus-1.11.14.tar.gz'
  source_sha256 '55cfc7fdd2cccb2fce1f75d2132ad4801b5ed6699fc2ce79ed993574adf90c80'

  binary_url ({
    aarch64: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/dbus-1.11.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://github.com/jam7/chromebrew/releases/download/bin-armv7l/dbus-1.11.14-chromeos-armv7l.tar.xz',
       i686: 'https://github.com/jam7/chromebrew/releases/download/bin-i686/dbus-1.11.14-chromeos-i686.tar.xz',
     x86_64: 'https://github.com/jam7/chromebrew/releases/download/bin-x86_64/dbus-1.11.14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '608054e9cd999d4c42f740aede76058869050fd1897636187b3f56dc3a2f13dc',
     armv7l: '608054e9cd999d4c42f740aede76058869050fd1897636187b3f56dc3a2f13dc',
       i686: '58128f69a4f6e90f472b02bae8cbfddff953f82b526ebd569a398b14188c815b',
     x86_64: '8b1c0db41420f8880694ef97f6fb333e8f4a0e4fc0323c6953c1d03df2d20c4d',
  })

  depends_on 'expat'

  def self.build
    system "./configure"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
