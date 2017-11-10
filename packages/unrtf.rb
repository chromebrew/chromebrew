require 'package'

class Unrtf < Package
  description 'UnRTF is a command-line program written in C which converts documents in Rich Text Format (.rtf) to HTML, LaTeX, troff macros, and RTF itself.'
  homepage 'https://www.gnu.org/software/unrtf/'
  version '0.21.9'
  source_url 'https://www.gnu.org/software/unrtf/unrtf-0.21.9.tar.gz'
  source_sha256 '22a37826f96d754e335fb69f8036c068c00dd01ee9edd9461a36df0085fb8ddd'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'glibc'

  def self.build
    system './bootstrap'
    system './configure',
      "--prefix=#{CREW_PREFIX}",
      '--disable-depedency-tracking',
      '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
