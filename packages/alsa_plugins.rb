require 'package'

class Alsa_plugins < Package
  description 'alsa-plugins contains plugins for various ALSA needs (e.g. Jack).'
  homepage 'https://www.alsa-project.org/main/index.php/Main_Page'
  version '1.2.7.1'
  license 'GPL-2 and LGPL-2.1'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://www.alsa-project.org/files/pub/plugins/alsa-plugins-1.2.7.1.tar.bz2'
  source_sha256 '8c337814954bb7c167456733a6046142a2931f12eccba3ec2a4ae618a3432511'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'b6f8c1e388cb9e33a9579448b918e8ec702ae418d5063584b456aba5571dad74',
     armv7l: 'b6f8c1e388cb9e33a9579448b918e8ec702ae418d5063584b456aba5571dad74',
     x86_64: '227861025571f52113dac1be4dad0e924466d3e0f2f4439973e074a007355c5d'
  })

  depends_on 'alsa_lib' # R
  depends_on 'dbus' => :build
  depends_on 'ffmpeg' # R
  depends_on 'glibc' # R
  depends_on 'jack' # R
  depends_on 'libsamplerate' # R
  depends_on 'pipewire' # R
  depends_on 'pulseaudio' # R
  depends_on 'speexdsp' # R
  depends_on 'gcc_lib' # R

  def self.build
    system "mold -run ./configure #{CREW_OPTIONS} \
           --with-alsalconfdir=#{CREW_PREFIX}/etc/alsa/conf.d"
    system 'make'
  end

  def self.check
    system 'make', 'check'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
