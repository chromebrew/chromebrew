require 'package'

class Buildessential < Package
  description 'A collection of tools essential to compile and build software.'
  homepage ''
  version '1.8'
  compatibility 'all'

  is_fake


  # For libtool patching
  depends_on 'grep'

  #install first to get ldconfig
  depends_on 'glibc'
  depends_on 'gcc10'
  depends_on 'gcc_tools'
  depends_on 'linuxheaders'
  depends_on 'make'
  depends_on 'pkgconfig'

  # install man pages
  depends_on 'manpages'

  # compress man pages
  depends_on 'compressdoc'

  # build documentation
  depends_on 'doxygen'

  # configure scripts reference the file command
  depends_on 'filecmd'

  # essential dependency for many packages
  depends_on 'readline'

  # override the system version with sandbox mode enabled
  depends_on 'sed'

  # typically required libraries to compile source code using "./autogen.sh"
  depends_on 'automake'
  depends_on 'libtool'
  depends_on 'intltool'
  depends_on 'patch'
  depends_on 'diffutils'
  depends_on 'bison'
  depends_on 'flex'
  depends_on 'util_macros'
  depends_on 'gettext'
  depends_on 'wget' # in some cases, patches might be required and can be downloaded using wget
  depends_on 'gawk'

  # compression utilities
  depends_on 'lzip'
  depends_on 'unzip'
  depends_on 'zip'

  # cmake
  depends_on 'cmake'

  # xorg protocols headers
  #depends_on 'xorg_proto'

  # maybe meson build system ?
  depends_on 'meson'

  # perl module build ?
  # depends_on 'perl_module_build'

end
