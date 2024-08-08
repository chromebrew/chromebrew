require 'package'

class Ansifilter < Package
  description 'Ansifilter parses common ANSI codes to remove them or to convert them to another colored text file format (HTML, TeX, LaTeX, RTF, Pango or BBCode).'
  homepage 'http://andre-simon.de/doku/ansifilter/en/ansifilter.php'
  version '2.20'
  license 'GPL-3+'
  compatibility 'all'
  source_url 'https://gitlab.com/saalen/ansifilter.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'da375a75732ae5d4534a7278c4d40dd26d89bdf9aa3a8f7eed1f9ce38ee65905',
     armv7l: 'da375a75732ae5d4534a7278c4d40dd26d89bdf9aa3a8f7eed1f9ce38ee65905',
       i686: 'b42d604aa940d8ebf298958fb1a4b93b3d2dcf29b7900783c914947878e9665f',
     x86_64: '12f6c518b5c1cf12192cde003ca0df4ce16a5bbf72dd23bddd3c34cb743cbbd4'
  })

  def self.build
    system 'make', "PREFIX=#{CREW_PREFIX}"
  end

  def self.install
    system 'make', "PREFIX=#{CREW_PREFIX}", "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
