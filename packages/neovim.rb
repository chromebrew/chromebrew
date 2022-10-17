require 'package'

class Neovim < Package
  description 'Neovim is a refactor, and sometimes redactor, in the tradition of Vim (which itself derives from Stevie).'
  homepage 'https://neovim.io/'
  version '0.8.0'
  license 'Apache-2.0 and vim'
  compatibility 'all'
  source_url 'https://github.com/neovim/neovim.git'
  git_hashtag "v#{version}"

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/neovim/0.8.0_armv7l/neovim-0.8.0-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/neovim/0.8.0_armv7l/neovim-0.8.0-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/neovim/0.8.0_i686/neovim-0.8.0-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/neovim/0.8.0_x86_64/neovim-0.8.0-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'de13d5f6f05c830f324a28dae940342e4e4664167a9aebc156a42ebe07d11171',
     armv7l: 'de13d5f6f05c830f324a28dae940342e4e4664167a9aebc156a42ebe07d11171',
       i686: '74aa26a81166856482eafe1feda1025e415735bd8314240c980df941ae444c4a',
     x86_64: '9050b20d8d9d3ace8ffad7110cd7e61da1db94c5938ccfe48f983fa6a977cd01'
  })

  depends_on 'msgpack_c'
  depends_on 'libluv'
  depends_on 'libtermkey'
  depends_on 'libuv'
  depends_on 'libvterm'
  depends_on 'luajit'
  depends_on 'luajit_bitop'
  depends_on 'luajit_lpeg'
  depends_on 'luajit_mpack'
  depends_on 'tree_sitter'
  depends_on 'unibilium'
  depends_on 'xdg_base'

  def self.build
    FileUtils.mkdir('builddir')
    Dir.chdir('builddir') do
      system "cmake #{CREW_CMAKE_OPTIONS} \
        ../ -G Ninja"
    end
    system 'samu -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} samu -C builddir install"
  end
end
