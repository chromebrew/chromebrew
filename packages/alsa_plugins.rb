require 'package'

class Alsa_plugins < Package
  description 'alsa-plugins contains plugins for various ALSA needs (e.g. Jack).'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.1.8'
  source_url 'ftp://ftp.alsa-project.org/pub/plugins/alsa-plugins-1.1.8.tar.bz2'
  source_sha256 '7f77df171685ccec918268477623a39db4d9f32d5dc5e76874ef2467a2405994'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.8-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.8-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.8-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/alsa_plugins-1.1.8-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '223803ef01f3365babc184abad7f257ac664db4599294e1538d01a8af8794907',
     armv7l: '223803ef01f3365babc184abad7f257ac664db4599294e1538d01a8af8794907',
       i686: '8e9c4a2a69727f1e7872022fb24f97f6f6ec41f83eaa81b3298104dbaab477da',
     x86_64: '590df0d75d5680b5da817feedb7f163ce5e7a4c60809adab298168dda09697b9',
  })

  depends_on 'dbus'
  depends_on 'ffmpeg'
  depends_on 'speexdsp'
  depends_on 'alsa_lib'
  depends_on 'pulseaudio'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           "--with-alsalconfdir=#{CREW_PREFIX}/etc/alsa/conf.d"
    system 'make'
  end

  def self.install
    system "make", "DESTDIR=#{CREW_DEST_DIR}", "install"
  end
end
