require 'buildsystems/meson'

class Elinks < Meson
  description 'Full-Featured Text WWW Browser'
  homepage 'https://github.com/rkd77/elinks'
  version '0.16.1.1'
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://github.com/rkd77/elinks.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/elinks/0.16.1.1_armv7l/elinks-0.16.1.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/elinks/0.16.1.1_armv7l/elinks-0.16.1.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/elinks/0.16.1.1_i686/elinks-0.16.1.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/elinks/0.16.1.1_x86_64/elinks-0.16.1.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'e8672bf1e0e8532672bde9e64d129fdc6942580efab6296f794406edfe3c7b7d',
     armv7l: 'e8672bf1e0e8532672bde9e64d129fdc6942580efab6296f794406edfe3c7b7d',
       i686: 'c410b2bf0dbd5a5d914f58d9da41822ef9044153e5cd79e6ec47d3387d49447b',
     x86_64: 'cbc7f1bd03f93429eb81992dea522584f9fb5b46bc8059c1b43f967a5941501e'
  })

  depends_on 'brotli' # R
  depends_on 'bzip2' # R
  depends_on 'expat' # R
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gpgme' => :build
  depends_on 'gpm' # R
  depends_on 'lzip' => :build
  depends_on 'openssl' # R
  depends_on 'tre' # R
  depends_on 'zlibpkg' # R

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
