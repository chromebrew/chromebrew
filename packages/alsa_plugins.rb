require 'package'

class Alsa_plugins < Package
  description 'alsa-plugins contains plugins for various ALSA needs (e.g. Jack).'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.1.5'
  source_url 'ftp://ftp.alsa-project.org/pub/plugins/alsa-plugins-1.1.5.tar.bz2'
  source_sha256 '797da5f8f53379fbea28817bc466de16affd2c07849e84f1af8d5e22f7bb7f1c'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.5-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.5-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.5-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.5-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '68e9c4e6a6a98a34f716dd95a0297ba074d4313ea9a5daedb09c47b4b4baaf5c',
     armv7l: '68e9c4e6a6a98a34f716dd95a0297ba074d4313ea9a5daedb09c47b4b4baaf5c',
       i686: 'a768db04382ffd8850095e2c5667402002a38d30901dd1a5d4a3aa379ab4e9dd',
     x86_64: 'a5c465a12e4bedc10d7f9989d20c81aeac3834635cd12d1d1205f9438658b7e0',
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
