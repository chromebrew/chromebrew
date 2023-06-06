require 'package'

class Libx11 < Package
  description 'C interface to the X window system'
  homepage 'https://x.org'
  version '1.8.4'
  license 'X11'
  compatibility 'all'
  source_url 'https://gitlab.freedesktop.org/xorg/lib/libx11.git'
  git_hashtag "libX11-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.8.4_armv7l/libx11-1.8.4-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.8.4_armv7l/libx11-1.8.4-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.8.4_i686/libx11-1.8.4-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libx11/1.8.4_x86_64/libx11-1.8.4-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '68489f184757df334f516f130f0bc304e1652577ea645d17ee545e98627ba3ce',
     armv7l: '68489f184757df334f516f130f0bc304e1652577ea645d17ee545e98627ba3ce',
       i686: '8c5de7d7bc568a66ae1f52f9c0beda5f53ddd8b31b5ae9ec80574ce6b189e808',
     x86_64: '70456b24c640dea2012d0ca1b278a18f4fd8dfa6d664b54562552ce1b52c7ef4'
  })

  depends_on 'glibc' # R
  depends_on 'libbsd' # R
  depends_on 'libmd' # R
  depends_on 'libxau' # R
  depends_on 'libxcb' # R
  depends_on 'libxdmcp' # R
  depends_on 'libxtrans' => :build
  depends_on 'llvm_lib16' => :build
  depends_on 'xorg_proto' => :build

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system 'filefix'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
