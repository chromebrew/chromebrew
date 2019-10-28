require 'package'

class Neovim < Package
  description 'Neovim is a refactor, and sometimes redactor, in the tradition of Vim (which itself derives from Stevie).'
  homepage 'https://neovim.io/'
  version '0.4.2'
  source_url 'https://github.com/neovim/neovim/archive/v0.4.2.tar.gz'
  source_sha256 '9f874d3d2a74f33b931db62adebe28f8d2ec116270d1e13998b58a73348b6e56'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/neovim-0.4.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/neovim-0.4.2-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/neovim-0.4.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4f34e7ec984b6e5e9ea0c71780b475157b7d158b4d4887e92d96f12531a6e4a2',
     armv7l: '4f34e7ec984b6e5e9ea0c71780b475157b7d158b4d4887e92d96f12531a6e4a2',
     x86_64: 'e5a5461efeab2b27240dbaa7908ceb874982d1094fafd01d5d75b0af1df7118e',
  })

  depends_on 'meson' => :build

  def self.patch
    system "sed -i 's,add_compile_options(-fstack-protector-strong),add_compile_options(-fstack-protector-strong)\\n    link_libraries(-fstack-protector-strong),g' CMakeLists.txt"
    system "sed -i 's,add_compile_options(-fstack-protector --param ssp-buffer-size=4),add_compile_options(-fstack-protector --param ssp-buffer-size=4)\\n    link_libraries(-fstack-protector --param ssp-buffer-size=4),g' CMakeLists.txt"
  end

  def self.build
    system 'make', 'CMAKE_BUILD_TYPE=RelWithDebInfo'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
