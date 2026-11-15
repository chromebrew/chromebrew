require 'buildsystems/autotools'

class Dosbox_x < Autotools
  description 'An x86 emulator with DOS.'
  homepage 'https://dosbox-x.com/'
  version '2026.10.01'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/joncampbell123/dosbox-x.git'
  git_hashtag "dosbox-x-v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd961bda0214f8d18bffc651572e786c7eb68fb7353348e2aac3f2b95907315b8',
     armv7l: 'd961bda0214f8d18bffc651572e786c7eb68fb7353348e2aac3f2b95907315b8',
     x86_64: 'b5f541655f45be3c7f4afc0281272e2dd230e2b65cdb87efcdc7bc05e113646f'
  })

  depends_on 'alsa_lib' => :executable
  depends_on 'ffmpeg' => :executable
  depends_on 'freetype' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'libglu' => :executable
  depends_on 'libglvnd' => :executable
  depends_on 'libpcap' => :executable
  depends_on 'libpng' => :executable
  depends_on 'libsdl' => :executable
  depends_on 'libslirp' => :executable
  depends_on 'libx11' => :executable
  depends_on 'libxext' => :executable
  depends_on 'libxkbfile' => :executable
  depends_on 'libxrandr' => :executable
  depends_on 'nasm' => :build
  depends_on 'ncurses' => :executable
  depends_on 'zenity' => :executable
  depends_on 'zlib' => :executable

  def self.patch
    # Add configure options.
    system "sed -i 's,--prefix=/usr,#{CREW_CONFIGURE_OPTIONS},' build"
    # Fix configure: error: Can't find curses.
    system "sed -i 's,AC_CHECK_HEADER(curses.h,AC_CHECK_HEADER(#{CREW_PREFIX}/include/ncursesw/curses.h,' configure.ac"
  end

  def self.build
    # Fix fatal error: curses.h: No such file or directory.
    system "CXXFLAGS='-I#{CREW_PREFIX}/include/ncursesw' ./build"
  end

  def self.postinstall
    ExitMessage.add "\nType 'dosbox-x' to get started.\n"
  end

  def self.postremove
    Package.agree_to_remove("#{CREW_PREFIX}/.config/dosbox-x")
  end
end
