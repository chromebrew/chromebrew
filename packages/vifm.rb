require 'buildsystems/autotools'

class Vifm < Autotools
  description 'Vifm is an ncurses based file manager with vi like keybindings/modes/options/commands/configuration, which also borrows some useful ideas from mutt.'
  homepage 'https://vifm.info/'
  version '0.14.5'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/vifm/vifm/vifm-#{version}.tar.bz2"
  source_sha256 '5de33fd6637ce91cdce162358ec393f6fe5e9734deb1833ea16776d619960422'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'abb2eec9d0fa295b83e88fa12b65bfbcec4809a1fa69a38fab824fe524dc1cbe',
     armv7l: 'abb2eec9d0fa295b83e88fa12b65bfbcec4809a1fa69a38fab824fe524dc1cbe',
       i686: '9e1546930cf4a48303ed5f8bd5939f9db49e035f85f950570a6a88d4ee1f98f3',
     x86_64: '2f35d1035fb6e44f8b58144b77d760880393c7c162a8c7de1f5fb210dc5df4dd'
  })

  depends_on 'filecmd' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable

  autotools_pre_configure_options "CPPFLAGS=-I#{CREW_PREFIX}/include/ncursesw"
  autotools_configure_options '--without-glib --without-X11'
end
