require 'buildsystems/cmake'

class Codelite < CMake
  description 'CodeLite is an open source, free, cross platform IDE, specialized in C, C++, Rust, Python, PHP and JavaScript'
  homepage 'https://codelite.org/'
  version '18.4.0'
  license 'GPL-2'
  compatibility 'aarch64 armv7l x86_64'
  source_url 'https://github.com/eranif/codelite.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '647f66c5d486f4abe313930586f7d8ffaee8094173ac084b1c8cc6fa1e6a7a3d',
     armv7l: '647f66c5d486f4abe313930586f7d8ffaee8094173ac084b1c8cc6fa1e6a7a3d',
     x86_64: '1429fd6f2465453991f3b9db9c228f728bbf286f5419ba771d91d9e1a76840cd'
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
