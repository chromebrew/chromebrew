require 'package'

class Audacious_plugins < Package
  description 'Audacious is an open source audio player.'
  homepage 'https://audacious-media-player.org/'
  version '3.10.1'
  compatibility 'all'
  source_url 'https://distfiles.audacious-media-player.org/audacious-plugins-3.10.1.tar.bz2'
  source_sha256 'eec3177631f99729bf0e94223b627406cc648c70e6646e35613c7b55040a2642'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/audacious_plugins-3.10.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/audacious_plugins-3.10.1-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/audacious_plugins-3.10.1-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/audacious_plugins-3.10.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '200f784576d153da7d23ee308f32587957faf8e9108b197991c841d3cac46f18',
     armv7l: '200f784576d153da7d23ee308f32587957faf8e9108b197991c841d3cac46f18',
       i686: '271778d167bccc497751f7bbcb34cacbf2ab600f3acafe04b7290e9fdf64c08b',
     x86_64: '5a9c46fceaa2c6307fd4791b4bb68133d412a27ba013105345ab64f0964f6e0b',
  })

  depends_on 'audacious'
  depends_on 'flac'
  depends_on 'mpg123'
  depends_on 'neon'
  depends_on 'wavpack'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
