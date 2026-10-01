require 'buildsystems/autotools'

class Xmlstarlet < Autotools
  description 'XMLStarlet is a command line XML toolkit which can be used to transform, query, validate, and edit XML documents and files using simple set of shell commands in similar way it is done for plain text files using grep/sed/awk/tr/diff/patch.'
  homepage 'https://xmlstar.sourceforge.net/'
  version '1.7.0'
  license 'MIT'
  compatibility 'all'
  source_url 'https://github.com/xmlstarlet/xmlstarlet.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '68b7172fe01c2c8e17d54e1758d212d35d58a7560901c900058717c30b8a3068',
     armv7l: '68b7172fe01c2c8e17d54e1758d212d35d58a7560901c900058717c30b8a3068',
       i686: 'b461fd10a3ec654da32d8cd2fdd23d3bedf75cce5fd3a8eb54ae29c9f65398d0',
     x86_64: 'f7c2842250919a5763c152d01b6a734ac7550e4bd90eea07aa55141c394055fe'
  })

  depends_on 'glibc' => :executable
  depends_on 'libxml2' => :executable
  depends_on 'libxslt' => :executable

  autotools_skip_autogen

  autotools_install_extras do
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/xml", "#{CREW_DEST_PREFIX}/bin/xmlstarlet"
  end
end
