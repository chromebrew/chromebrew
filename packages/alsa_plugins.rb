require 'package'

class Alsa_plugins < Package
  description 'alsa-plugins contains plugins for various ALSA needs (e.g. Jack).'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.1.5'
  source_url 'ftp://ftp.alsa-project.org/pub/plugins/alsa-plugins-1.1.5.tar.bz2'
  source_sha256 '797da5f8f53379fbea28817bc466de16affd2c07849e84f1af8d5e22f7bb7f1c'

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
