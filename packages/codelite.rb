require 'buildsystems/cmake'

class Codelite < CMake
  description 'CodeLite is an open source, free, cross platform IDE, specialized in C, C++, Rust, Python, PHP and JavaScript'
  homepage 'https://codelite.org/'
  version '18.5.0'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/eranif/codelite.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '5be1f656f8e56a45fe59ed467a8b544fa5a41f21f5894f01e8203f17114db701',
     armv7l: '5be1f656f8e56a45fe59ed467a8b544fa5a41f21f5894f01e8203f17114db701',
     x86_64: '060ed8c4068b25579052c4e02454140cc33355710288aade924679fb5800be04'
  })

  depends_on 'at_spi2_core' => :library
  depends_on 'cairo' => :library
  depends_on 'gcc_lib' => :library
  depends_on 'gdk_pixbuf' => :library
  depends_on 'glib' => :library
  depends_on 'glibc' => :library
  depends_on 'glibc_lib' => :library
  depends_on 'gtk3' => :library
  depends_on 'harfbuzz' => :library
  depends_on 'hunspell_base' => :library
  depends_on 'libedit' => :library
  depends_on 'libssh' => :library
  depends_on 'openssl' => :library
  depends_on 'pango' => :library
  depends_on 'sqlite' => :library
  depends_on 'uchardet' => :library
  depends_on 'wxwidgets' => :library

  no_fhs

  def self.postremove
    Package.agree_to_remove("#{HOME}/.codelite")
  end
end
