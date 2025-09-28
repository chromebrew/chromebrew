require 'package'

class Nethogs < Package
  description "Linux 'net top' tool"
  homepage 'https://github.com/raboof/nethogs'
  version '0.8.8'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/raboof/nethogs.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'c123320353c55444546c61c75116f8d9225f72f82bf315fc641801f85b416320',
     armv7l: 'c123320353c55444546c61c75116f8d9225f72f82bf315fc641801f85b416320',
       i686: '0a8f67fc63b3e607344fa7d48581279d3caeb726a8baa466513f5ca4cd3d308f',
     x86_64: '7772c37491162fd7a40b41f090b2bc5bd63570708f55e5c0e891f6c20589537a'
  })

  depends_on 'ncurses'
  depends_on 'libpcap'

  def self.build
    system "PREFIX=#{CREW_PREFIX} CPPFLAGS='-I#{CREW_PREFIX}/include/ncursesw' make"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
