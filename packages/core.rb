require 'package'

class Core < Package
  description 'Core Chromebrew Packages.'
  homepage 'https://github.com/chromebrew/chromebrew'
  version '3.15'
  license 'GPL-3+'
  compatibility 'all'

  is_fake

  depends_on 'bash'
  depends_on 'bash_completion'
  depends_on 'brotli'
  depends_on 'bzip2'
  depends_on 'c_ares'
  depends_on 'ca_certificates'
  depends_on 'command_not_found'
  depends_on 'crew_mvdir'
  depends_on 'crew_preload' unless CREW_GLIBC_INTERPRETER.nil?
  depends_on 'crew_profile_base'
  depends_on 'crew_sudo' if CHROMEOS_RELEASE.to_i > 116 && !CREW_IN_CONTAINER
  depends_on 'e2fsprogs'
  depends_on 'elfutils'
  depends_on 'expat'
  depends_on 'filecmd'
  depends_on 'flex'
  depends_on 'gawk'
  depends_on 'grep'
  depends_on 'gcc_lib'
  depends_on 'gdbm'
  depends_on 'gettext'
  depends_on 'git'
  depends_on 'git_mestrelion_tools'
  # The standalone glibc is installed on newer systems, and on older
  # systems we have glibc_dev and glibc_lib metapackages.
  depends_on 'glibc'
  depends_on 'glibc_lib' if CREW_GLIBC_INTERPRETER.nil?
  depends_on 'gmp'
  depends_on 'gnutls'
  depends_on 'groff'
  depends_on 'icu4c'
  depends_on 'jq'
  depends_on 'krb5'
  depends_on 'less'
  depends_on 'libarchive'
  depends_on 'libcyrussasl'
  depends_on 'libdb'
  depends_on 'libedit'
  depends_on 'libffi'
  depends_on 'libidn2'
  depends_on 'libmetalink'
  depends_on 'libnghttp2'
  depends_on 'libnsl'
  depends_on 'libpipeline'
  depends_on 'libpsl'
  depends_on 'libseccomp'
  depends_on 'libsigsegv'
  depends_on 'libssp'
  depends_on 'libtasn1'
  depends_on 'libtirpc'
  depends_on 'libunbound'
  depends_on 'libunistring'
  depends_on 'libversion'
  depends_on 'libxcrypt' # Newer glibc no longer includes this.
  depends_on 'libxml2'
  depends_on 'libyaml'
  depends_on 'lz4'
  depends_on 'lzip'
  depends_on 'm4'
  depends_on 'man_db'
  depends_on 'manpages'
  depends_on 'mawk'
  depends_on 'most'
  depends_on 'ncurses'
  depends_on 'nettle'
  depends_on 'openldap'
  depends_on 'openssl'
  depends_on 'patchelf'
  depends_on 'p11kit'
  depends_on 'pcre'
  depends_on 'pcre2'
  depends_on 'perl'
  depends_on 'popt'
  # Provides pstree, which is used within crew.
  depends_on 'psmisc'
  depends_on 'py3_wheel'
  depends_on 'python3'
  depends_on 'readline'
  depends_on 'rtmpdump'
  depends_on 'ruby'
  depends_on 'ruby_concurrent_ruby'
  # Allows for building binary gems if necessary.
  depends_on 'ruby_gem_compiler'
  # For use in ruby prompts.
  depends_on 'ruby_highline'
  # needed by misc_functions
  depends_on 'ruby_matrix'
  # Needed for buildsystems reporting.
  depends_on 'ruby_method_source'
  # Adds File.which
  depends_on 'ruby_ptools'
  # This contains the debugger config files.
  depends_on 'ruby_pry'
  # Need rake for unit tests.
  depends_on 'ruby_rake' if CREW_IN_CONTAINER
  # crew check -V breaks without this.
  depends_on 'ruby_ruby_libversion'
  # Needed for rubygem updates
  depends_on 'ruby_rubygems_update'
  # These are the "Default Gems" that come with Ruby.
  depends_on 'default_gems'
  # These are the "Bundled Gems" that come with Ruby.
  depends_on 'bundled_gems'
  depends_on 'sed'
  depends_on 'slang'
  depends_on 'sqlite'
  depends_on 'tar'
  depends_on 'uchardet'
  depends_on 'unzip'
  depends_on 'upx'
  depends_on 'uutils_coreutils' unless ARCH == 'i686' # Currently broken.
  depends_on 'which'
  depends_on 'xzutils'
  depends_on 'xxhash'
  depends_on 'zip'
  depends_on 'zlib'
  depends_on 'zlib_ng'
  depends_on 'zstd'
end
