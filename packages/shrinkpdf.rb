require 'package'

class Shrinkpdf < Package
  description 'A simple wrapper around Ghostscript to shrink PDFs (as in reduce filesize) under Linux.'
  homepage 'https://github.com/aklomp/shrinkpdf'
  version '1.2'
  license 'BSD-3'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/aklomp/shrinkpdf.git'
  git_hashtag "v#{version}"

  depends_on 'ghostscript'

  no_compile_needed

  def self.install
    FileUtils.install 'shrinkpdf.sh', "#{CREW_DEST_PREFIX}/bin/shrinkpdf", mode: 0o755
  end
end
