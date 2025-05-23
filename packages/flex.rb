require 'buildsystems/autotools'

class Flex < Autotools
  description 'Flex (The Fast Lexical Analyzer) is a fast lexical analyser generator tool for generating programs that perform pattern-matching on text.'
  homepage 'https://www.gnu.org/software/flex/'
  version '2.6.4-2'
  license 'BSD'
  compatibility 'all'
  source_url 'https://github.com/westes/flex/releases/download/v2.6.4/flex-2.6.4.tar.gz'
  source_sha256 'e87aae032bf07c26f85ac0ed3250998c37621d95f8bd748b31f15b33c45ee995'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7968e998075c49c0b49d0db6d9d2fc49f1e1e35a283a1cd450db8b149191cfcc',
     armv7l: '7968e998075c49c0b49d0db6d9d2fc49f1e1e35a283a1cd450db8b149191cfcc',
       i686: '9fd42095b66754a94d1b09b242966275efcd41b39f75ca0ba504b75125a38bf9',
     x86_64: 'c2dc3fd71ce8109b2bd2d8fa233e0082a772d50d0dcf5629cc105f2c5d8be8b6'
  })

  depends_on 'bison' => :build
  depends_on 'glibc' # R
  depends_on 'm4' => :build

  autotools_configure_options '--with-pic --disable-static --enable-shared'

  def self.patch
    downloader 'https://gitlab.archlinux.org/archlinux/packaging/packages/flex/-/raw/main/flex-pie.patch?ref_type=heads&inline=false',
               '20f3cce6b0ea6ab67a902a46b89c292b959994dedcbe6ee5d187f9bba1408b0e', 'flex-pie.patch'
    system 'patch -p1 -i flex-pie.patch'
    system 'autoreconf -fiv'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
    FileUtils.ln_s "#{CREW_PREFIX}/bin/flex", "#{CREW_DEST_PREFIX}/bin/lex"
  end
end
