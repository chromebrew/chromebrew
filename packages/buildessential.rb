require 'package'

class Buildessential < Package
  description 'A collection of tools essential to compile and build software.'
  homepage ''
  version '1.25'
  license 'GPL-3+'
  compatibility 'all'

  is_fake

  # Make sure core is installed
  depends_on 'core'

  # install first to get ldconfig
  depends_on 'glibc_lib'
  depends_on 'glibc_dev'
  depends_on 'gcc_dev'
  depends_on 'gmp'
  depends_on 'mpfr'
  depends_on 'mpc'
  depends_on 'isl'
  depends_on 'libyaml'
  depends_on 'linuxheaders'
  depends_on 'make'
  depends_on 'pkgconfig'
  depends_on 'binutils'

  # Linkers
  depends_on 'mold'

  # typically required libraries & tools to configure packages
  # e.g. using "./autogen.sh"
  depends_on 'automake'
  depends_on 'bison'
  depends_on 'diffutils'
  depends_on 'filecmd'
  depends_on 'flex'
  depends_on 'gettext'
  depends_on 'intltool'
  depends_on 'libtool'
  depends_on 'patch'
  depends_on 'sed'
  depends_on 'util_macros'
  depends_on 'valgrind'

  # build documentation
  depends_on 'compressdoc'
  depends_on 'doxygen'
  depends_on 'help2man'
  depends_on 'gtk_doc'
  depends_on 'texinfo' # This contains makeinfo

  # Assembler
  # depends_on 'nasm'
  # depends_on 'yasm'

  # BASIC
  # depends_on 'freebasic'
  # depends_on 'qb64'
  # depends_on 'smallbasic'

  # CMake
  depends_on 'cmake'

  # COBOL
  # depends_on 'gnucobol'

  # Google
  # depends_on 'dart'
  # depends_on 'flutter'
  # depends_on 'gb'
  # depends_on 'go'
  # depends_on 'gox'
  # depends_on 'gyp'

  # Haskell
  # depends_on 'ghc'

  # Java
  # depends_on 'jdk'
  # depends_on 'openjdk8'
  # depends_on 'openjdk11'
  # depends_on 'openjdk17'

  # Linter
  depends_on 'linter'

  # Lisp
  # depends_on 'ccl'
  # depends_on 'clisp'
  # depends_on 'newlisp'
  # depends_on 'owl'
  # depends_on 'roswell'
  # depends_on 'sbcl'

  # LLVM
  # This can be pulled in on a per-package basis...
  # depends_on 'llvm17_dev'
  depends_on 'llvm17_lib' # This provides llvm-strip

  # Meson build system
  depends_on 'mesonbuild'

  # Node.js
  # depends_on 'nodebrew'
  # depends_on 'nvm'
  # depends_on 'yarn'

  # Pascal
  # depends_on 'fpc'

  # Patchelf
  # for setting library paths in packages
  # depends_on 'patchelf'

  # Add pax_utils (gives us lddtree)
  depends_on 'pax_utils'

  # Perl
  depends_on 'perl'
  depends_on 'pcre'
  depends_on 'pcre2'

  # Perl module build?
  # depends_on 'perl_module_build'

  # PHP
  # depends_on 'php'
  # depends_on 'composer'

  # Python
  depends_on 'python3'
  depends_on 'py3_build'
  depends_on 'py3_installer'
  depends_on 'py3_flit_core'
  depends_on 'py3_pip'
  # Pax_utils needs this.
  depends_on 'py3_pyelftools'

  # Qt
  # depends_on 'qtcreator'
  # depends_on 'qttools'

  # Rust
  # depends_on 'rust'

  # Samurai
  # depends_on 'samurai'

  # Add Gnu_time to get time binary
  depends_on 'gnu_time'

  # xorg protocol headers
  # depends_on 'xorg_proto'

  # Packages needed for shrinking package archives
  depends_on 'rdfind'
  depends_on 'symlinks'
  depends_on 'upx'

  # Packages needed for compressing archives
  depends_on 'zstd'

  # Ruby gems
  # Add rubocop for linting packages. (This also installs the
  # rubocop config file.)
  depends_on 'ruby_rubocop'
  # Add ruby_debug
  depends_on 'ruby_debug'
  # Add ruby_concurrent_ruby
  depends_on 'ruby_concurrent_ruby'
end
