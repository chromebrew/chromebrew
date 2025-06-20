require 'package'

class Ansifilter < Package
  description 'Ansifilter parses common ANSI codes to remove them or to convert them to another colored text file format (HTML, TeX, LaTeX, RTF, Pango or BBCode).'
  homepage 'http://andre-simon.de/doku/ansifilter/en/ansifilter.php'
  version '2.21'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://gitlab.com/saalen/ansifilter.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ada9c9e7b8af6cb38e636d9716d8bda3809f3decd7f323bcf19da95b12d1ce49',
     armv7l: 'ada9c9e7b8af6cb38e636d9716d8bda3809f3decd7f323bcf19da95b12d1ce49',
       i686: '60d9d935d68a763b8c3bad7dca796ed45dc490aa50028a07c4866f3f9c25a8e7',
     x86_64: '9a4c35ea87585bf78a1e3f5a909e66baa53ed33955922072c6d6ef929080c3d4'
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
