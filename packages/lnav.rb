require 'buildsystems/autotools'

class Lnav < Autotools
  description 'An advanced log file viewer for the small-scale'
  homepage 'https://lnav.org/'
  version '0.11.2'
  license 'BSD-2 Clause'
  compatibility 'x86_64'
  source_url 'https://github.com/tstack/lnav.git'
  git_hashtag "v#{version}"
  binary_compression 'tar.zst'

  binary_url({
    x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/lnav/0.11.2_x86_64/lnav-0.11.2-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    x86_64: 'a3da030ad5690e7f447b58530966820e38e3d85bdb145d7fa77d02898fbb3453'
  })

  depends_on 'gcc' => :build
  depends_on 'pcre2' # R
  depends_on 'sqlite' # R
  depends_on 'ncurses' # R
  depends_on 'readline' # R
  depends_on 'zlibpkg' # R
  depends_on 'bzip2' # R
  depends_on 'libcurl' # R
  depends_on 'libarchive' # R
  depends_on 'wireshark' # R
end
