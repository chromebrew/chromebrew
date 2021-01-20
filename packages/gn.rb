require 'package'

class Gn < Package
  description 'GN is a meta-build system that generates build files for Ninja.'
  homepage 'https://gn.googlesource.com/gn/'
  version 'dca877f'
  compatibility 'all'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/gn-dca877f-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/gn-dca877f-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/gn-dca877f-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/gn-dca877f-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7ecb46dc020a7f2ef83c9f299b93e33b7d7907915a580eae29fba4038d348572',
     armv7l: '7ecb46dc020a7f2ef83c9f299b93e33b7d7907915a580eae29fba4038d348572',
       i686: '24f08672a3063c1fb151239d347a8126d204f0b9ef81114512acd8a70772b4d8',
     x86_64: '385d47846ff117275793dc43d9ef004d4aa1075b29af3d9283f289cfc757d59f',
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
