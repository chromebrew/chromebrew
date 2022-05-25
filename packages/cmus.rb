require 'package'

class Cmus < Package
  description 'cmus is a small, fast and powerful console music player for Unix-like operating systems.'
  homepage 'https://cmus.github.io/'
  version '2.10.0'
  license 'GPL-2'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/cmus/cmus/archive/v2.10.0.tar.gz'
  source_sha256 'ff40068574810a7de3990f4f69c9c47ef49e37bd31d298d372e8bcdafb973fff'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmus/2.10.0_armv7l/cmus-2.10.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmus/2.10.0_armv7l/cmus-2.10.0-chromeos-armv7l.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/cmus/2.10.0_x86_64/cmus-2.10.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '44d2cc05f52b7558ab1140af0d626b8a260e88f1a5be327c4ac83da679b0e02e',
     armv7l: '44d2cc05f52b7558ab1140af0d626b8a260e88f1a5be327c4ac83da679b0e02e',
     x86_64: '2849c3c96b2e76bbce4f4339e9baedf724c5be01374ef301727cf815f6a3d19a'
  })

  depends_on 'alsa_lib' # R
  depends_on 'elogind' # R
  depends_on 'faad2' # R
  depends_on 'ffmpeg' => :build
  depends_on 'flac' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'jack1' # R
  depends_on 'jack' # R
  depends_on 'libmodplug' # R
  depends_on 'libsamplerate' # R
  depends_on 'libvorbis' # R
  depends_on 'ncurses' # R
  depends_on 'opusfile' # R
  depends_on 'pipewire' # R
  depends_on 'pulseaudio' # R
  depends_on 'wavpack' # R

  def self.build
    system "sed -i 's,/usr/include,#{CREW_PREFIX}/include,g' configure"
    system "mold -run ./configure prefix=#{CREW_PREFIX} libdir=#{CREW_LIB_PREFIX}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
