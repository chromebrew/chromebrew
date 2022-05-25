require 'package'

class Xclock < Package
  description 'The xclock package contains a simple clock application which is used in the default xinit configuration.'
  homepage 'https://www.x.org/archive/X11R6.8.1/doc/xclock.1.html'
  version '1.1.1'
  license 'MIT-with-advertising'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/app/xclock.git'
  git_hashtag "xclock-#{version}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xclock/1.1.1_armv7l/xclock-1.1.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xclock/1.1.1_armv7l/xclock-1.1.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xclock/1.1.1_i686/xclock-1.1.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/xclock/1.1.1_x86_64/xclock-1.1.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'b35b8f4abbab0da7b6f8c04f7eabd4bddefb2b0ca56de1cbd94975c9119c5aae',
     armv7l: 'b35b8f4abbab0da7b6f8c04f7eabd4bddefb2b0ca56de1cbd94975c9119c5aae',
       i686: '6011367b96a13f19900fb84ebea21af2e955ecba1235525a00d60a6d47f8cfae',
     x86_64: '388bff5a287f56d332c7f2cf8f0e7a8915fb6723e0b1dcdac826c4e966658c47'
  })

  depends_on 'glibc' # R
  depends_on 'libx11' # R
  depends_on 'libxaw' # R
  depends_on 'libxft' # R
  depends_on 'libxkbfile' # R
  depends_on 'libxmu' # R
  depends_on 'libxrender' # R
  depends_on 'libxt' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
