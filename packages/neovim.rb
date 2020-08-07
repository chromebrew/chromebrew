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
    depends_on 'xdg_base'
  end

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/neovim-0.4.4-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/neovim-0.4.4-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/neovim-0.4.4-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '4f070268cb5386ad3cff2c3a5e7f332a79ce28335ec13f17763d2cb0c5a6083b',
     armv7l: '4f070268cb5386ad3cff2c3a5e7f332a79ce28335ec13f17763d2cb0c5a6083b',
     x86_64: '013241fb25fa27c2247ade5cffdc3694dcd58e4783c7b7a4bf339b92332804d5',
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
