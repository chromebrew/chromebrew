require 'package'

class Fzf < Package
  description 'A command-line fuzzy finder'
  homepage 'https://github.com/junegunn/fzf'
  version '0.23.1'
  compatibility 'aarch64,armv7l,x86_64'
  source_url 'https://github.com/junegunn/fzf/archive/0.23.1.tar.gz'
  source_sha256 '07576e47d2d446366eb7806fd9f825a2340cc3dc7f799f1f53fe038ca9bf30f6'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/fzf-0.23.1-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/fzf-0.23.1-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/fzf-0.23.1-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '034490807bf8b4dc3b996a70f492b99e54ac2ed3035e60d819af0b9565ebb79a',
     armv7l: '034490807bf8b4dc3b996a70f492b99e54ac2ed3035e60d819af0b9565ebb79a',
     x86_64: '92b216ea7e169115704c2a1deeca5df5bd734b309038215b9e78cbad44e1402b',
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
