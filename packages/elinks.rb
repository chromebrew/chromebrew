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
    aarch64: '44b2811e076aebbf37793742e99b35c633b8142dfa9b34efaeb15b6695abb53f',
     armv7l: '44b2811e076aebbf37793742e99b35c633b8142dfa9b34efaeb15b6695abb53f',
       i686: '53a036a8ea6cdef93a38f6b65359b7c380199d54bd14b6b1db1333fc38e84071',
     x86_64: '979b4e3b4a5a5adbb1a8b0f2de49cebabfb86027c34bfecd0fb6f6fd9620583a'
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
