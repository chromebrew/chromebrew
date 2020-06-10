require 'package'

class Mpv < Package
  description 'Video player based on MPlayer/mplayer2'
  homepage 'https://mpv.io/'
  version '0.30.0'
  compatibility 'all'
  source_url 'https://github.com/mpv-player/mpv/archive/v0.30.0.tar.gz'
  source_sha256 '33a1bcb7e74ff17f070e754c15c52228cf44f2cefbfd8f34886ae81df214ca35'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mpv-0.30.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mpv-0.30.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mpv-0.30.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mpv-0.30.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '515681c255067b81a55142e891e8b7b58b384d6e9e863c66c1eada4388e084c7',
     armv7l: '515681c255067b81a55142e891e8b7b58b384d6e9e863c66c1eada4388e084c7',
       i686: '2ecc57ce3651769af37225a3d4c3df8aeca1324396a20a6964132a97a64e2e86',
     x86_64: '71230e0f9639a87275611765305d8d07ab0a86eb84b128fc0b7f52d07fe201d5',
  })

  depends_on 'ld_default' => :build
  depends_on 'docutils'
  depends_on 'ffmpeg'
  depends_on 'gdbm'
  depends_on 'lcms'
  depends_on 'libarchive'
  depends_on 'libcaca'
  depends_on 'libcdio'
  depends_on 'libxv'
  depends_on 'luajit'
  depends_on 'pulseaudio'
  depends_on 'uchardet'
  depends_on 'xdg_base'
  depends_on 'sommelier'

  def self.build
    # Use the gold linker.
    old_ld = `ld_default g`.chomp
    system 'pip3 install docutils'
    system './bootstrap.py'
    system './waf',
           'configure',
           '--enable-libmpv-shared',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}"
    system './waf'
    # Restore the original linker.
    system 'ld_default', "#{old_ld}"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_HOME}/.config"
    system "touch #{CREW_DEST_HOME}/.config/mpv"
    FileUtils.mkdir_p "#{CREW_DEST_LIB_PREFIX}"
    system './waf', "--destdir=#{CREW_DEST_DIR}", 'install'
    # Fix for mpv: error while loading shared libraries: libgdbm.so.4: cannot open shared object file: No such file or directory
    system "ln -sf #{CREW_LIB_PREFIX}/libgdbm.so.6 #{CREW_DEST_LIB_PREFIX}/libgdbm.so.4"
    system 'pip3 uninstall -y docutils'
  end
end
