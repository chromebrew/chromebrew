require 'package'

class Ansifilter < Package
  description 'Ansifilter parses common ANSI codes to remove them or to convert them to another colored text file format (HTML, TeX, LaTeX, RTF, Pango or BBCode).'
  homepage 'http://andre-simon.de/doku/ansifilter/en/ansifilter.php'
  version '2.22'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://gitlab.com/saalen/ansifilter.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '7742ae36f472fd8082e663c59d3fadb3b47e96c431aca4f6e1b1d483501d7662',
     armv7l: '7742ae36f472fd8082e663c59d3fadb3b47e96c431aca4f6e1b1d483501d7662',
       i686: '1058b2e8cd7650305f44863e2e6abb2f657235cc15f95fe01fd1860b7534348c',
     x86_64: 'd2d7ef991a3ef271a18dfd9be65babe988cb64d4c63521795d6e80d77a4a4ae1'
  })

  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
