require 'package'

class Htop < Package
  description 'htop is an interactive process viewer for Unix systems.'
  homepage 'https://github.com/htop-dev/htop'
  version '3.2.2'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/htop-dev/htop/archive/refs/tags/3.2.2.tar.gz'
  source_sha256 '3829c742a835a0426db41bb039d1b976420c21ec65e93b35cd9bfd2d57f44ac8'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'd1a46af7a625b50a304fcaecedcbc8204297b53519bd3ead8ba044e4c31686c4',
     armv7l: 'd1a46af7a625b50a304fcaecedcbc8204297b53519bd3ead8ba044e4c31686c4',
       i686: '8410a807707dee0dd9980a16ae16e42902842cb34e3a11919ff2eda7facfe407',
     x86_64: '01c92862b89fa1b5d3738f301f28e8a9c119eaaacd1b047fa8fb0f05139979ed'
  })

  depends_on 'buildessential' => :build
  depends_on 'glibc' # R
  depends_on 'libcap' # R
  depends_on 'libunwind' # R
  depends_on 'ncurses' # R

  def self.build
    system '[ -x configure ] || NOCONFIGURE=1 ./autogen.sh'
    system "CPPFLAGS='-I#{CREW_PREFIX}/include/ncursesw' \
      ./configure #{CREW_OPTIONS} \
      --disable-unicode"
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
