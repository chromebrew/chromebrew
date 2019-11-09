require 'package'

class Neovim < Package
  description 'Neovim is a refactor, and sometimes redactor, in the tradition of Vim (which itself derives from Stevie).'
  homepage 'https://neovim.io/'
  version '0.4.3'
  source_url 'https://github.com/neovim/neovim/archive/v0.4.3.tar.gz'
  source_sha256 '91a0b5d32204a821bf414690e6b48cf69224d1961d37158c2b383f6a6cf854d2'

  binary_url ({
  })
  binary_sha256 ({
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
