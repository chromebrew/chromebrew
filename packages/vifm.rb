require 'buildsystems/autotools'

class Vifm < Autotools
  description 'Vifm is an ncurses based file manager with vi like keybindings/modes/options/commands/configuration, which also borrows some useful ideas from mutt.'
  homepage 'https://vifm.info/'
  version '0.14.4'
  license 'GPL-2'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/vifm/vifm/vifm-#{version}.tar.bz2"
  source_sha256 '40bc32ec10d829ada3d0297d33cd4f302c520bb431287d544fc0a05ae45fdb1b'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '47a824aab61a1c28d99e07b193e3c1ab3d74f8282332ebb157e00d83ccb8ac31',
     armv7l: '47a824aab61a1c28d99e07b193e3c1ab3d74f8282332ebb157e00d83ccb8ac31',
       i686: 'b8a87ed0f2ab53c58c60e0a2e14d82329257c18f5ad1f0d9c002681ae7c447ac',
     x86_64: '25b92a68de966eccb733db7434c84474846dd405b8d261037cb971934f95f6cc'
  })

  depends_on 'filecmd' => :executable
  depends_on 'glibc' => :executable
  depends_on 'glibc_lib' => :executable
  depends_on 'ncurses' => :executable

  autotools_pre_configure_options "CPPFLAGS=-I#{CREW_PREFIX}/include/ncursesw"
  autotools_configure_options '--without-glib --without-X11'
end
