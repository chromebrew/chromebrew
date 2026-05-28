require 'package'

class Gettext_tiny < Package
  description 'gettext-tiny provides lightweight replacements for tools typically used from the GNU gettext suite.'
  homepage 'https://github.com/sabotage-linux/gettext-tiny'
  version '0.3.3'
  license 'MIT'
  compatibility 'all'
  source_url "https://ftp.barfooze.de/pub/sabotage/tarballs/gettext-tiny-#{version}.tar.xz"
  source_sha256 '6715234941fed4f3694d6b56c18f3f20053fe344fce15ab148906036caa24dc7'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'fb74752838dc56bca3e5bd68bf1515feae541e5ce4318d5862806f59e2ff3dcb',
     armv7l: 'fb74752838dc56bca3e5bd68bf1515feae541e5ce4318d5862806f59e2ff3dcb',
       i686: 'cd369725539644f89a2b691fe52fa1a4a7a264d7cf42c5ca93113c559af25920',
     x86_64: 'a638eaab1a250a5a4dac7434c20ad954c83a4160d465b4acbd480d0ca88817ef'
  })

  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable

  conflicts_with 'gettext'

  def self.build
    system 'make', 'LIBINTL=NONE'
  end

  def self.install
    system 'make', 'LIBINTL=NONE', "DESTDIR=#{CREW_DEST_DIR}", "prefix=#{CREW_PREFIX}", "libdir=#{CREW_LIB_PREFIX}", 'install'
  end
end
