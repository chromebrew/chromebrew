require 'package'

class Tcpflow < Package
  description 'TCP/IP packet demultiplexer'
  homepage 'https://github.com/simsong/tcpflow'
  version '1.6.1'
  license 'GPL-3'
  compatibility 'all'
  source_url 'https://github.com/simsong/tcpflow.git'
  git_hashtag "tcpflow-#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tcpflow/1.6.1_armv7l/tcpflow-1.6.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tcpflow/1.6.1_armv7l/tcpflow-1.6.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tcpflow/1.6.1_i686/tcpflow-1.6.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/tcpflow/1.6.1_x86_64/tcpflow-1.6.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '46718d8c909cae4a175ec7fc95e04e560407d615c66134ff1f903427712a03c9',
     armv7l: '46718d8c909cae4a175ec7fc95e04e560407d615c66134ff1f903427712a03c9',
       i686: '747f148abc6a655671ab6e24503572e03c5ed0d53e702cb2b2abbeb4b7170aa2',
     x86_64: '4ad32e11746afa35888f1878c503694349b7ff9979b485922b26037f88f3bd65'
  })

  depends_on 'boost' => :build
  depends_on 'bz2' # R
  depends_on 'cairo' => :build
  depends_on 'expat' # R
  depends_on 'freetype' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'harfbuzz' # R
  depends_on 'libcap_ng' # R
  depends_on 'libmd' # R
  depends_on 'libpcap' # R
  depends_on 'openssl' # R
  depends_on 'pixman' # R
  depends_on 'sqlite' # R
  depends_on 'zlibpkg' # R

  def self.build
    system 'bash bootstrap.sh'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} make install"
  end
end
