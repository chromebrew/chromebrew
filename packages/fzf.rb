require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.17.3'
  source_url 'https://github.com/junegunn/fzf/archive/0.17.3.tar.gz'
  source_sha256 'e843904417adf926613431e4403fded24fade56269446e92aac6ff1db86af81e'

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
