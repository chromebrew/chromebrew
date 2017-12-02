require 'package'

class Alsa_plugins < Package
  description 'alsa-plugins contains plugins for various ALSA needs (e.g. Jack).'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.1.4'
  source_url 'ftp://ftp.alsa-project.org/pub/plugins/alsa-plugins-1.1.4.tar.bz2'
  source_sha256 '530d1c3bdaeb058f2a03607a33b9e16ee5369bfd30a96bc09bd2c69b4ddd1a8a'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.4-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.4-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: 'f43dcb37de0a0e1cb3723b190cef40a2467f283e0a7d08c85e039df7e9fd644f',
     armv7l: 'f43dcb37de0a0e1cb3723b190cef40a2467f283e0a7d08c85e039df7e9fd644f',
       i686: 'f8271a09eecb18f6894b72f0a7aec7e299fa3e64d91063ec722c2bf4ba614896',
     x86_64: '2f5b076bfede05cdc4596016e888f0fc63e197bd52e35ea1352b6619b7cb1e3d',
  })

  depends_on 'alsa_lib'

  def self.build
    system "./configure --prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX}"
    system "make"
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
