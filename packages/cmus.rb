require 'package'

class Cmus < Package
  description 'cmus is a small, fast and powerful console music player for Unix-like operating systems.'
  homepage 'https://cmus.github.io/'
  version '2.13.0'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/cmus/cmus.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '18bba575f917863af31a8dd423343a4416f698670d0b3c4f5136400b61dcca6d',
     armv7l: '18bba575f917863af31a8dd423343a4416f698670d0b3c4f5136400b61dcca6d',
     x86_64: '7af3dd08a7bc76b68480ae7bf78753810e24d6c38666057f9953267bc2f2afd4'
  })

  depends_on 'alsa_lib' => :library
  depends_on 'audiofile' => :library
  depends_on 'elogind' => :executable
  depends_on 'faad2' => :library
  depends_on 'ffmpeg' => :library
  depends_on 'flac' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'jack' => :library
  depends_on 'libao' => :library
  depends_on 'libiconv' => :executable
  depends_on 'libmodplug' => :library
  depends_on 'libsamplerate' => :library
  depends_on 'libvorbis' => :library
  depends_on 'ncurses' => :executable
  depends_on 'opusfile' => :library
  depends_on 'pipewire' => :executable
  depends_on 'pulseaudio' => :library
  depends_on 'wavpack' => :library

  def self.patch
    system "sed -i 's,/usr/include,#{CREW_PREFIX}/include,g' configure"
  end

  def self.build
    system "./configure prefix=#{CREW_PREFIX} libdir=#{CREW_LIB_PREFIX}"
    system 'CONFIG_OPUS=y make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
