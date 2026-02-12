require 'buildsystems/meson'

class Elinks < Meson
  description 'Full-Featured Text WWW Browser'
  homepage 'https://github.com/rkd77/elinks'
  version '0.19.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/rkd77/elinks.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'ed6864a246abda8af2e118cea825a3410addba38486e3f95a8e2dc1f66f10ffe',
     armv7l: 'ed6864a246abda8af2e118cea825a3410addba38486e3f95a8e2dc1f66f10ffe',
       i686: 'b6144db59e1847f251b950cb8fdacd10c8b41848b823ebeb4d7a7965790fabcb',
     x86_64: 'f8df12160126cc07507b7e35c0379134a06055b814bb45e1de3539aeb2dfdcd8'
  })

  depends_on 'brotli' # R
  depends_on 'bzip2' # R
  depends_on 'curl' # R
  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gpgme' => :build
  depends_on 'gpm' # R
  depends_on 'libcss' # R
  depends_on 'libdom' # R
  depends_on 'libwapcaplet' # R
  depends_on 'lzip' => :build
  depends_on 'openssl' # R
  depends_on 'tre' # R
  depends_on 'zlib' # R

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
