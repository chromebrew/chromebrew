require 'buildsystems/autotools'

class Gtypist < Autotools
  description 'Universal typing tutor.'
  homepage 'https://www.gnu.org/software/gtypist/index.html'
  version '2.10.1'
  license 'GPL-2 and public-domain'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://ftp.gnu.org/gnu/gtypist/gtypist-#{version}.tar.xz"
  source_sha256 'ca618054e91f1ed5ef043fcc43500bbad701c959c31844d4688ff22849ac252d'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '05636c190caa54623cf8d55bb55285d599b586ceb5330c0a8cc8d3dc3d295398',
     armv7l: '05636c190caa54623cf8d55bb55285d599b586ceb5330c0a8cc8d3dc3d295398',
     x86_64: '004e0982f8e20a9f7c5d2cb7cbe813aebfa655058db864d9f08a6a92721f93af'
  })

  depends_on 'emacs' => :build
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable
  depends_on 'perl' => :logical

  run_tests

  def self.prebuild
    system 'autoreconf -fiv'
  end
end
