require 'package'

class Neovim < Package
  description 'Neovim is a refactor, and sometimes redactor, in the tradition of Vim (which itself derives from Stevie).'
  homepage 'https://neovim.io/'
  version '0.4.3'
  compatibility 'aarch64,armv7l,x86_64'
  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    source_url 'https://github.com/neovim/neovim/archive/v0.4.3.tar.gz'
    source_sha256 '91a0b5d32204a821bf414690e6b48cf69224d1961d37158c2b383f6a6cf854d2'
  end

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/neovim-0.4.3-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/neovim-0.4.3-chromeos-armv7l.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/neovim-0.4.3-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '3a984f1e22e7a401e81b3acf0af68c19f42fe9bd6c9c3496f80f27b7fac38bfb',
     armv7l: '3a984f1e22e7a401e81b3acf0af68c19f42fe9bd6c9c3496f80f27b7fac38bfb',
     x86_64: 'a0164cb3b46076bb0723b90fec6234dbb478b4067d657aa096cc765a91888464',
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
