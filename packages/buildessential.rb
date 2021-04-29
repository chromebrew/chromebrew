require 'package'

class Buildessential < Package
  description 'A collection of tools essential to compile and build software.'
  homepage ''
  version '1.13'
  license 'GPL-3+'
  compatibility 'all'

  is_fake

  # Some package installs won't work without this
  depends_on 'crew_profile_base'

  #install first to get ldconfig
  depends_on 'glibc'
  depends_on 'gcc11'
  depends_on 'binutils'
  depends_on 'gmp'
  depends_on 'mpfr'
  depends_on 'mpc'
  depends_on 'isl'
  depends_on 'libyaml'
  depends_on 'gcc_tools'
  depends_on 'linuxheaders'
  depends_on 'make'
  depends_on 'pkgconfig'

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

  # build documentation
  depends_on 'compressdoc'
  depends_on 'doxygen'
  depends_on 'help2man'
  depends_on 'gtk_doc'

  # Assembler
  #depends_on 'nasm'
  #depends_on 'yasm'

  # BASIC
  #depends_on 'freebasic'
  #depends_on 'qb64'

  # CMake
  depends_on 'cmake'

  # COBOL
  #depends_on 'gnucobol'

  # Google
  #depends_on 'dart'
  #depends_on 'flutter'
  #depends_on 'go'
  #depends_on 'gox'
  #depends_on 'gyp'

  # Haskell
  #depends_on 'ghc'

  # Java
  #depends_on 'jdk'

  # LLVM
  depends_on 'llvm'

  # Meson build system
  depends_on 'meson'

  # Node.js
  #depends_on 'nodebrew'
  #depends_on 'nvm'
  #depends_on 'yarn'

  # Pascal
  #depends_on 'fpc'

  # Perl
  depends_on 'perl'
  depends_on 'pcre'
  depends_on 'pcre2'

  # Perl module build?
  #depends_on 'perl_module_build'

  # PHP
  #depends_on 'php'
  #depends_on 'composer'

  # Python
  depends_on 'python2'
  depends_on 'python3'

  # Qt
  #depends_on 'qtcreator'
  #depends_on 'qttools'

  # Rust
  #depends_on 'rust'

  # Samurai
  #depends_on 'samurai'

  # xorg protocol headers
  #depends_on 'xorg_proto'
end
