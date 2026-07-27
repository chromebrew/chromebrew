require 'buildsystems/meson'

class Elinks < Meson
  description 'Full-Featured Text WWW Browser'
  homepage 'https://github.com/rkd77/elinks'
  version '0.20.0'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/rkd77/elinks.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '82f131ffe2d29e4e260f9de01d6b612abb83e04bbdf6453cf0f060d0d582fa0f',
     armv7l: '82f131ffe2d29e4e260f9de01d6b612abb83e04bbdf6453cf0f060d0d582fa0f',
       i686: 'eca6169959eb235be1953b3f764d3e4574428f8d604effe575771cdbc81298d3',
     x86_64: '091dad0eab7c41ece6269bd320395fb9feb840f9ef014300d0ab327b32ab4549'
  })

  depends_on 'brotli' => :executable
  depends_on 'bzip2' => :executable
  depends_on 'curl' => :executable
  depends_on 'expat' => :executable
  depends_on 'gcc_lib' => :executable
  depends_on 'glibc' => :executable
  depends_on 'gpgme' => :build
  depends_on 'gpm' => :executable
  depends_on 'libcss' => :executable
  depends_on 'libdom' => :executable
  depends_on 'libwapcaplet' => :executable
  depends_on 'lzip' => :build
  depends_on 'openssl' => :executable
  depends_on 'tre' => :executable
  depends_on 'zlib' => :executable

  meson_options '-Dcgi=true \
    -D256-colors=true \
    -Dhtml-highlight=true \
    -Didn=false \
    -Dgemini=true \
    -Dbrotli=true \
    -Dbzlib=true'

  def self.patch
    system "sed -i 's,/usr/bin/perl,#{CREW_PREFIX}/bin/perl,g' doc/tools/help2xml"
  end
end
