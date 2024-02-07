# Adapted from Arch Linux libdovi PKGBUILD at:
# https://aur.archlinux.org/cgit/aur.git/plain/PKGBUILD?h=libdovi

require 'package'

class Libdovi < Package
  description 'Library to read and write Dolby Vision metadata C-API'
  homepage 'https://github.com/quietvoid/dovi_tool/tree/main/dolby_vision'
  version '3.2.0'
  license 'MIT'
  compatibility 'x86_64 aarch64 armv7l'
  source_url 'https://github.com/quietvoid/dovi_tool.git'
  git_hashtag "libdovi-#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '868a507f25ddd419671643660d5898baf219f5b5b1cc1a618b12801267ad71f4',
     armv7l: '868a507f25ddd419671643660d5898baf219f5b5b1cc1a618b12801267ad71f4',
     x86_64: '347462cc5dc77220eb884de12a2cc98eaf5ba5be5bc5bca9c668b3dcb3c5a5ad'
  })

  depends_on 'cargo_c' => :build
  depends_on 'fontconfig' => :build
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'rust' => :build

  def self.build
    Dir.chdir('dolby_vision') do
      system "#{ARCH == 'x86_64' ? 'RUSTFLAGS="-C target-cpu=x86-64-v3"' : ''} cargo build --release"
    end
  end

  def self.install
    Dir.chdir('dolby_vision') do
      system "cargo cinstall \
        --prefix=#{CREW_PREFIX} \
        --destdir=#{CREW_DEST_DIR} \
        --libdir=#{CREW_LIB_PREFIX}"
    end
  end
end
