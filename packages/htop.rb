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
    aarch64: '338489c46d466ee3fe7e98667fb4f580105d5dd7a7a97f12d9405ff15fa4657a',
     armv7l: '338489c46d466ee3fe7e98667fb4f580105d5dd7a7a97f12d9405ff15fa4657a',
       i686: '355a2351b50b0a69a08688ef995dfb8f1ac54b994c7d55a5417edf145b2387bc',
     x86_64: 'c98dbc6b4834fa31fc8c6485844c5be340c3a8a9c23fe1974aa5d6087e0bcb19'
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
