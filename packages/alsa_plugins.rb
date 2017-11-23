require 'package'

class Alsa_plugins < Package
  description 'alsa-plugins contains plugins for various ALSA needs (e.g. Jack).'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.1.4'
  source_url 'ftp://ftp.alsa-project.org/pub/plugins/alsa-plugins-1.1.4.tar.bz2'
  source_sha256 '530d1c3bdaeb058f2a03607a33b9e16ee5369bfd30a96bc09bd2c69b4ddd1a8a'

  binary_url ({
  })
  binary_sha256 ({
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
