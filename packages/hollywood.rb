require 'package'

class Hollywood < Package
  description 'Fill your console with Hollywood melodrama technobabble.'
  homepage 'https://a.hollywood.computer/'
  version '1.21'
  license 'Apache-2.0'
  compatibility 'all'
  source_url "https://httpredir.debian.org/debian/pool/main/h/hollywood/hollywood_1.21.orig.tar.gz"
  source_sha256 '793ef1f022b376e131c75e05ff1b55a010c0f4193225bb79018855cb9ab89acb'

  # Hollywood doesn't need binaries
  
  depends_on 'byobu'
  depends_on 'apg'
  depends_on 'bmon'
  depends_on 'cmatrix'
  depends_on 'htop'
  depends_on 'jp2a'
  depends_on 'mlocate'
  depends_on 'moreutils'
  depends_on 'speedometer'
  depends_on 'tree'
  depends_on 'util_linux'

  def self.patch
    system "sed -i 's:WIDGET_DIR=\"$(dirname $0)/../lib/$PKG\":WIDGET_DIR=\"$(dirname $0)/../libexec/$PKG\":' ./bin/hollywood"
  end
  
  def self.build
    FileUtils.cp_r "./lib", "./libexec"
  end
  
  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/libexec"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/man/man1"
    FileUtils.cp "./bin/hollywood", "#{CREW_DEST_PREFIX}/bin/"
    FileUtils.cp_r "./libexec/hollywood/", "#{CREW_DEST_PREFIX}/libexec/"
    FileUtils.cp_r "./share/hollywood/", "#{CREW_DEST_PREFIX}/share/"
    FileUtils.cp "./share/man/man1/hollywood.1", "#{CREW_DEST_PREFIX}/share/man/man1/"
  end
end
