require 'buildsystems/autotools'

class Htop < Autotools
  description 'htop is an interactive process viewer for Unix systems.'
  homepage 'https://github.com/htop-dev/htop'
  version '3.4.1'
  license 'BSD and GPL-2'
  compatibility 'all'
  source_url 'https://github.com/htop-dev/htop.git'
  git_hashtag version
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '373d776a32588baa51bc834adf100958fbe7ecba9c4ac921c0753b2d4a87ee09',
     armv7l: '373d776a32588baa51bc834adf100958fbe7ecba9c4ac921c0753b2d4a87ee09',
       i686: '251e7dbdc819890ddcd2066c019e8010965c6aee63ae09db42ba0759b88126f4',
     x86_64: '82424ae093bde8ef1f8dbbb09db90e6b4347b7203131766256e74a203ce31fab'
  })

  depends_on 'buildessential' => :build
  depends_on 'glibc' => :library
  depends_on 'libcap' => :library
  depends_on 'libnl3' => :library
  depends_on 'libunwind' => :library
  depends_on 'ncurses' => :library

  autotools_pre_configure_options "CPPFLAGS='-I#{CREW_PREFIX}/include/ncursesw'"
  autotools_configure_options '--disable-unicode'
end
