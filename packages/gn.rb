require 'package'

class Gn < Package
  description 'GN is a meta-build system that generates build files for Ninja.'
  homepage 'https://gn.googlesource.com/gn/'
  version 'dca877f'
  source_url 'https://chromium.googlesource.com/chromiumos/containers/sommelier/+/0.20/README?format=TEXT'
  source_sha256 'b58d799b16d20abf92369fe0749c73f7398996f0afa9933517051778a8bb16c3'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python27' => :build
  depends_on 'meson' => :build

  def self.build
    system "git clone https://gn.googlesource.com/gn"
    system 'set C_INCLUDE_PATH /usr/local/include/'
    Dir.chdir ("gn") do
      system "python build/gen.py"
      system "ninja -C out"
    end
  end

  def self.install
    system "install -Dm755 out/gn #{CREW_DEST_PREFIX}/bin/gn"
  end

  def self.postinstall
  end
end
