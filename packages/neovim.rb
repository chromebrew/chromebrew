require 'package'

class Neovim < Package
  description 'Neovim is a refactor, and sometimes redactor, in the tradition of Vim (which itself derives from Stevie).'
  homepage 'https://neovim.io/'
  version '0.4.4'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    source_url 'https://github.com/neovim/neovim/archive/v0.4.4.tar.gz'
    source_sha256 '2f76aac59363677f37592e853ab2c06151cca8830d4b3fe4675b4a52d41fc42c'
  end

  binary_url ({
  })
  binary_sha256 ({
  })

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
