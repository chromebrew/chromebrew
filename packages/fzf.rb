require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.23.1'
  compatibility 'all'
  source_url 'https://github.com/junegunn/fzf/archive/0.23.1.tar.gz'
  source_sha256 '07576e47d2d446366eb7806fd9f825a2340cc3dc7f799f1f53fe038ca9bf30f6'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'go' => :build

  def self.build
    system "make"
    system "sed -i 's,bin/fzf,#{CREW_DEST_PREFIX}/bin/fzf,' Makefile"
  end

  def self.install
    system "mkdir -p #{CREW_DEST_PREFIX}/bin"
    system "make install"
  end
end
