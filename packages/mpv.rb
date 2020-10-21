require 'package'

class Mpv < Package
  description 'Video player based on MPlayer/mplayer2'
  homepage 'https://mpv.io/'
  version '0.32.0'
  compatibility 'all'
  source_url 'https://github.com/mpv-player/mpv/archive/v0.32.0.tar.gz'
  source_sha256 '9163f64832226d22e24bbc4874ebd6ac02372cd717bef15c28a0aa858c5fe592'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/mpv-0.32.0-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/mpv-0.32.0-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/mpv-0.32.0-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/mpv-0.32.0-chromeos-x86_64.tar.xz',
    
  })
  binary_sha256 ({
    aarch64: 'ae9f812ccb3239ca85d25a6e919e1ded6e459867ba00d2027ea832782a38f9f1',
     armv7l: 'ae9f812ccb3239ca85d25a6e919e1ded6e459867ba00d2027ea832782a38f9f1',
       i686: '41f96ce28132e2d60978c3e7450594b58b03fda67edbb8fa2e56ce6442d3d1ee',
     x86_64: 'e9623b3fdd06ab5bb762a15a3d7ef9b7875a10d4f0a5baaed5f83b9250b9fbe4',
    
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
