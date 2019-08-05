require 'package'

class Gn < Package
  description 'GN is a meta-build system that generates build files for Ninja.'
  homepage 'https://gn.googlesource.com/gn/'
  version 'dca877f'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
  
  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python27' => :build
  depends_on 'meson' => :build

  def self.build
    system "git clone https://gn.googlesource.com/gn"
    ENV['C_INCLUDE_PATH']="#{CREW_PREFIX}/include/"
    ENV['CXX']="g++"
    Dir.chdir ("gn") do
      system "python build/gen.py"
      system "ninja -C out"
    end
  end

  def self.install
    system "install -Dm755 gn/out/gn #{CREW_DEST_PREFIX}/bin/gn"
  end

  def self.postinstall
  end
end
