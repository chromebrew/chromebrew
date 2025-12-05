# lib/const.rb
# Defines common constants used in different parts of crew
require 'etc'
require 'open3'

OLD_CREW_VERSION = defined?(CREW_VERSION) ? CREW_VERSION : '1.0'
CREW_VERSION = '1.68.7' unless defined?(CREW_VERSION) && CREW_VERSION == OLD_CREW_VERSION

# Kernel architecture.
KERN_ARCH = Etc.uname[:machine]

# Read and parse processor information from /proc/cpuinfo
CPUINFO = File.readlines('/proc/cpuinfo').map { |line| line.chomp.split(/\t+: /) if line.include?("\t") }.compact.to_h

# We report aarch64 & armv8l machines as armv7l for now, as we treat
# them as if they were armv7l.
# When we have proper aarch64 support, remove this.
# Also, we allow ARCH to be changed via the ARCH environment variable.
ARCH = ENV.fetch('ARCH') do |_name|
  case KERN_ARCH
  when 'aarch64', 'armv8l'
    'armv7l'
  else KERN_ARCH
  end
end

# Allow for edge case of i686 install on a x86_64 host before linux32 is
# downloaded, e.g. in a docker container.
CREW_LIB_SUFFIX = ARCH.eql?('x86_64') && Dir.exist?('/lib64') ? '64' : ''
ARCH_LIB        = "lib#{CREW_LIB_SUFFIX}"

CREW_PREFIX = ENV.fetch('CREW_PREFIX', '/usr/local')

# Glibc related constants
# Gate enablement of the new glibc behind this env variable, so that we
# have a build environment with the older glibc if this is set.
CREW_PRE_GLIBC_STANDALONE = ENV.fetch('CREW_PRE_GLIBC_STANDALONE', false)
CREW_GLIBC_PREFIX = File.join(CREW_PREFIX, 'opt/glibc-libs')
@crew_glibc_interpreter = File.file?("#{CREW_PREFIX}/bin/ld.so") ? File.join(CREW_GLIBC_PREFIX, File.basename(File.realpath("#{CREW_PREFIX}/bin/ld.so"))) : ''
CREW_GLIBC_INTERPRETER = File.file?(@crew_glibc_interpreter) ? @crew_glibc_interpreter : nil

# Glibc version can be found from the output of libc.so.6
@libcvertokens = (`#{CREW_GLIBC_PREFIX}/libc.so.6`.lines.first.chomp.split(/\s/) if File.file?("#{CREW_GLIBC_PREFIX}/libc.so.6"))
@libc_version = @libcvertokens.nil? ? Etc.confstr(Etc::CS_GNU_LIBC_VERSION).split.last : @libcvertokens[@libcvertokens.find_index('version') + 1].sub!(/[[:punct:]]?$/, '')
LIBC_VERSION = if ENV.include?('LIBC_VERSION') && ENV['LIBC_VERSION'].empty?
                 @libc_version
               else
                 ENV.fetch('LIBC_VERSION', @libc_version)
               end

if CREW_PREFIX == '/usr/local'
  CREW_BUILD_FROM_SOURCE = ENV.fetch('CREW_BUILD_FROM_SOURCE', false)
  HOME = File.exist?('/.dockerenv') ? '/home/chronos/user' : Dir.home
else
  CREW_BUILD_FROM_SOURCE = true
  HOME = File.join(CREW_PREFIX, Dir.home)
end

# These are packages that crew needs to run-- only packages that the bin/crew needs should be required here.
# lz4, for example, is required for zstd to have lz4 support, but this is not required to run bin/crew.
CREW_ESSENTIAL_PACKAGES = %W[
  bash crew_profile_base gcc_lib gmp gnu_time libnghttp2 libxcrypt ncurses patchelf readline ruby ruby_matrix upx zlib zlib_ng zstd
  #{'crew_preload' unless CREW_GLIBC_INTERPRETER.nil?}
  #{'glibc' unless CREW_GLIBC_INTERPRETER.nil?}
  #{ if LIBC_VERSION.to_f > 2.34 && LIBC_VERSION.to_f < 2.41
       "#{"glibc_lib#{LIBC_VERSION.delete('.')}" if File.file?(File.join(CREW_PREFIX, "etc/crew/meta/glibc_lib#{LIBC_VERSION.delete('.')}.filelist"))}
     #{"glibc_build#{LIBC_VERSION.delete('.')}" if File.file?(File.join(CREW_PREFIX, "etc/crew/meta/glibc_build#{LIBC_VERSION.delete('.')}.filelist"))}"
     else
       File.file?(File.join(CREW_PREFIX, "etc/crew/meta/glibc_build#{LIBC_VERSION.delete('.')}.filelist")) ? "glibc_build#{LIBC_VERSION.delete('.')}" : ''
     end
  }
].reject(&:empty?)

CREW_IN_CONTAINER = File.exist?('/.dockerenv') || ENV.fetch('CREW_IN_CONTAINER', false)

CREW_CPU_VENDOR = CPUINFO['vendor_id']
# The cpuinfo vendor_id may not exist on non-x86 platforms, or when a
# container is virtualized on non-x86 platforms. Default to
# CREW_IS_INTEL for x86 architectures.
if %w[x86_64 i686].include?(ARCH)
  CREW_IS_AMD = CREW_CPU_VENDOR.eql?('AuthenticAMD').nil?
  CREW_IS_INTEL = %w[unknown GenuineIntel].include?(CREW_CPU_VENDOR)
else
  CREW_IS_AMD = nil
  CREW_IS_INTEL = nil
end

# Use sane minimal defaults if in container and no override specified.
CREW_KERNEL_VERSION =
  if (CREW_IN_CONTAINER && ENV.fetch('CREW_KERNEL_VERSION', nil).nil?) || ENV['CI']
    ARCH.eql?('i686') ? '3.8' : '6.12'
  else
    ENV.fetch('CREW_KERNEL_VERSION', Etc.uname[:release].rpartition('.').first)
  end

# Local constants for contributors.
CREW_CACHE_DIR          = ENV.fetch('CREW_CACHE_DIR', "#{HOME}/.cache/crewcache")
CREW_CACHE_FAILED_BUILD = ENV.fetch('CREW_CACHE_FAILED_BUILD', false)
CREW_CACHE_BUILD        = ENV.fetch('CREW_CACHE_BUILD', false)
CREW_LOCAL_REPO_ROOT = `git rev-parse --show-toplevel 2>/dev/null`.chomp
CREW_LOCAL_BUILD_DIR = "#{CREW_LOCAL_REPO_ROOT}/release/#{ARCH}"
CREW_MAX_BUILD_TIME  = ENV.fetch('CREW_MAX_BUILD_TIME', '19800') # GitHub Action containers are killed after 6 hours, so set to 5.5 hours.
CREW_GITLAB_PKG_REPO = 'https://gitlab.com/api/v4/projects/26210301/packages'
GITLAB_TOKEN = ENV.fetch('GITLAB_TOKEN', nil)
GITLAB_TOKEN_USERNAME = ENV.fetch('GITLAB_TOKEN_USERNAME', nil)
CREW_GITLAB_TOKEN_LABEL = if GITLAB_TOKEN.nil?
                            ''
                          else
                            (GITLAB_TOKEN.split('-').first == 'glpat' ? 'PRIVATE-TOKEN' : 'DEPLOY-TOKEN')
                          end

CREW_LIB_PREFIX       = File.join(CREW_PREFIX, ARCH_LIB)
CREW_MAN_PREFIX       = File.join(CREW_PREFIX, 'share/man')
CREW_LIB_PATH         = Dir.exist?(File.join(CREW_PREFIX, 'lib/crew')) ? File.join(CREW_PREFIX, 'lib/crew') : CREW_LOCAL_REPO_ROOT
CREW_PACKAGES_PATH    = File.join(CREW_LIB_PATH, 'packages')

crew_config_path = File.join(CREW_PREFIX, 'etc/crew')
CREW_CONFIG_PATH      = (Dir.exist?(crew_config_path) && File.writable?(crew_config_path) ? crew_config_path : ENV.fetch('CREW_CONFIG_PATH', File.join('/tmp', 'etc/crew')))
CREW_META_PATH        = File.join(CREW_CONFIG_PATH, 'meta')
crew_brew_dir = File.join(CREW_PREFIX, 'tmp/crew')
CREW_BREW_DIR         = (Dir.exist?(crew_brew_dir) && File.writable?(crew_brew_dir) ? crew_brew_dir : ENV.fetch('CREW_BREW_DIR', File.join('/tmp', 'crew')))
CREW_DEST_DIR         = File.join(CREW_BREW_DIR, 'dest')
CREW_DEST_PREFIX      = File.join(CREW_DEST_DIR, CREW_PREFIX)
CREW_DEST_LIB_PREFIX  = File.join(CREW_DEST_DIR, CREW_LIB_PREFIX)
CREW_DEST_MAN_PREFIX  = File.join(CREW_DEST_DIR, CREW_MAN_PREFIX)
CREW_WINE_PREFIX      = File.join(CREW_LIB_PREFIX, 'wine')
CREW_DEST_WINE_PREFIX = File.join(CREW_DEST_PREFIX, CREW_WINE_PREFIX)

# Put musl build dir under CREW_PREFIX/share/musl to avoid FHS incompatibility
CREW_MUSL_PREFIX      = File.join(CREW_PREFIX, '/share/musl/')
CREW_DEST_MUSL_PREFIX = File.join(CREW_DEST_DIR, CREW_MUSL_PREFIX)
MUSL_LIBC_VERSION     = File.executable?("#{CREW_MUSL_PREFIX}/lib/libc.so") ? `#{CREW_MUSL_PREFIX}/lib/libc.so 2>&1`[/\bVersion\s+\K\S+/] : nil unless defined?(MUSL_LIBC_VERSION)

CREW_DEST_HOME  = File.join(CREW_DEST_DIR, HOME)
CREW_NO_GIT     = ENV.fetch('CREW_NO_GIT', false)
CREW_UNATTENDED = ENV.fetch('CREW_UNATTENDED', false)

CREW_STANDALONE_UPGRADE_ORDER = %w[libxcrypt crew_preload glibc openssl ruby python3 perl icu4c sommelier]

CREW_DEBUG        = ARGV.include?('-D') || ARGV.include?('--debug')
CREW_FORCE        = ARGV.include?('-f') || ARGV.include?('--force')
CREW_VERBOSE      = ARGV.include?('-v') || ARGV.include?('--verbose') || ARGV.include?('-vv')
CREW_VERY_VERBOSE = ARGV.include?('-vv')

# Set CREW_NPROC from environment variable, `distcc -j`, or `nproc`.
CREW_NPROC =
  if File.file?("#{CREW_PREFIX}/bin/distcc")
    ENV.fetch('CREW_NPROC', `distcc -j`.chomp)
  else
    ENV.fetch('CREW_NPROC', `nproc`.chomp)
  end

# Set following as boolean if environment variables exist.
# Timeout for agree questions in package.rb:
CREW_AGREE_TIMEOUT_SECONDS           = ENV.fetch('CREW_AGREE_TIMEOUT_SECONDS', 10).to_i
CREW_CACHE_ENABLED                   = ENV.fetch('CREW_CACHE_ENABLED', CREW_CACHE_FAILED_BUILD)
CREW_CONFLICTS_ONLY_ADVISORY         = ENV.fetch('CREW_CONFLICTS_ONLY_ADVISORY', false)
# or use conflicts_ok
CREW_DISABLE_ENV_OPTIONS             = ENV.fetch('CREW_DISABLE_ENV_OPTIONS', false)
# or use no_env_options
CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY = ENV.fetch('CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY', false)
# or use no_fhs
CREW_NOT_COMPRESS                    = ENV.fetch('CREW_NOT_COMPRESS', false)
# or use no_compress
CREW_NOT_LINKS                       = ENV.fetch('CREW_NOT_LINKS', false)
# or use no_links
CREW_NOT_STRIP                       = ENV.fetch('CREW_NOT_STRIP', false)
# or use no_strip
CREW_NOT_SHRINK_ARCHIVE              = ENV.fetch('CREW_NOT_SHRINK_ARCHIVE', false)
# or use no_shrink

# Allow git constants to be set from environment variables (for testing)
CREW_REPO   = ENV.fetch('CREW_REPO', 'https://github.com/chromebrew/chromebrew.git')
CREW_BRANCH = ENV.fetch('CREW_BRANCH', 'master')

USER = Etc.getlogin

CHROMEOS_RELEASE =
  if File.exist?('/etc/lsb-release')
    File.read('/etc/lsb-release')[/CHROMEOS_RELEASE_CHROME_MILESTONE=(.+)/, 1]
  else
    # newer version of Chrome OS exports info to env by default
    ENV.fetch('CHROMEOS_RELEASE_CHROME_MILESTONE', nil)
  end

# If CREW_DISABLE_MVDIR environment variable exists and is equal to 1 use rsync/tar to install files in lieu of crew-mvdir.
CREW_DISABLE_MVDIR = ENV.fetch('CREW_DISABLE_MVDIR', false)

# Days between crew prompting to run 'crew update' and doing gem updates.
CREW_UPDATE_CHECK_INTERVAL = ENV.fetch('CREW_UPDATE_CHECK_INTERVAL', 7).to_i

# If CREW_USE_CURL environment variable exists use curl in lieu of net/http.
CREW_USE_CURL = ENV.fetch('CREW_USE_CURL', false)

# Use an external downloader instead of net/http if CREW_DOWNLOADER is set, see lib/downloader.rb for more info
# About the format of the CREW_DOWNLOADER variable, see line 130-133 in lib/downloader.rb
CREW_DOWNLOADER = ENV.fetch('CREW_DOWNLOADER', nil)

# Downloader maximum retry count
CREW_DOWNLOADER_RETRY = ENV.fetch('CREW_DOWNLOADER_RETRY', 3).to_i

# show download progress bar or not (only applied when using the default ruby downloader)
CREW_HIDE_PROGBAR = ENV.fetch('CREW_HIDE_PROGBAR', false)

# set certificate file location for lib/downloader.rb
SSL_CERT_FILE =
  if ENV['SSL_CERT_FILE'] && File.exist?(ENV['SSL_CERT_FILE'])
    ENV['SSL_CERT_FILE']
  elsif File.exist?("#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt")
    "#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt"
  else
    '/etc/ssl/certs/ca-certificates.crt'
  end

SSL_CERT_DIR =
  if ENV['SSL_CERT_DIR'] && Dir.exist?(ENV['SSL_CERT_DIR'])
    ENV['SSL_CERT_DIR']
  elsif Dir.exist?("#{CREW_PREFIX}/etc/ssl/certs")
    "#{CREW_PREFIX}/etc/ssl/certs"
  else
    '/etc/ssl/certs'
  end

CREW_ARCH_FLAGS_OVERRIDE = ENV.fetch('CREW_ARCH_FLAGS_OVERRIDE', '')
case ARCH
when 'aarch64', 'armv7l'
  CREW_TARGET = 'armv7l-cros-linux-gnueabihf'
  # These settings have been selected to match debian armhf.
  # Using -mfpu=neon breaks builds such as webkit2gtk.
  CREW_ARCH_FLAGS = CREW_ARCH_FLAGS_OVERRIDE.to_s.empty? ? '-mfloat-abi=hard -mthumb -mfpu=vfpv3-d16 -march=armv7-a+fp' : CREW_ARCH_FLAGS_OVERRIDE
when 'i686'
  CREW_TARGET = 'i686-cros-linux-gnu'
  CREW_ARCH_FLAGS = CREW_ARCH_FLAGS_OVERRIDE.to_s.empty? ? '' : CREW_ARCH_FLAGS_OVERRIDE
when 'x86_64'
  CREW_TARGET = 'x86_64-cros-linux-gnu'
  CREW_ARCH_FLAGS = CREW_ARCH_FLAGS_OVERRIDE.to_s.empty? ? '' : CREW_ARCH_FLAGS_OVERRIDE
end

# Does the CREW_BUILD_NO_PACKAGE_FILE_HASH_UPDATES env variable exist,
# and if so, is it empty?
CREW_BUILD_NO_PACKAGE_FILE_HASH_UPDATES = ([true, false].include?(ENV.fetch('CREW_BUILD_NO_PACKAGE_FILE_HASH_UPDATES', false)) ? false : !ENV.fetch('CREW_BUILD_NO_PACKAGE_FILE_HASH_UPDATES').empty?)

CREW_LINKER = ENV.fetch('CREW_LINKER', 'mold')
CREW_LINKER_FLAGS = ENV.fetch('CREW_LINKER_FLAGS', '-flto=auto')

CREW_CORE_FLAGS           = "-O3 -pipe -ffat-lto-objects -fPIC -fuse-ld=#{CREW_LINKER} #{CREW_ARCH_FLAGS} #{CREW_LINKER_FLAGS}"
CREW_COMMON_FLAGS         = "#{CREW_CORE_FLAGS} -flto=auto"
CREW_COMMON_FNO_LTO_FLAGS = "#{CREW_CORE_FLAGS} -fno-lto"
CREW_FNO_LTO_LDFLAGS      = '-fno-lto'

CREW_ENV_OPTIONS_HASH =
  if CREW_DISABLE_ENV_OPTIONS
    { 'CREW_DISABLE_ENV_OPTIONS' => '1' }
  else
    {
      'CFLAGS'          => CREW_COMMON_FLAGS,
      'CXXFLAGS'        => CREW_COMMON_FLAGS,
      'FCFLAGS'         => CREW_COMMON_FLAGS,
      'FFLAGS'          => CREW_COMMON_FLAGS,
      'LIBRARY_PATH'    => CREW_GLIBC_INTERPRETER.nil? ? '' : "#{CREW_GLIBC_PREFIX}:#{CREW_LIB_PREFIX}",
      'LDFLAGS'         => CREW_LINKER_FLAGS
    }.reject { |_k, v| v == '' }
  end

# parse from hash to shell readable string
CREW_ENV_OPTIONS = CREW_ENV_OPTIONS_HASH.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')

CREW_ENV_FNO_LTO_OPTIONS_HASH = {
  'CFLAGS'          => CREW_COMMON_FNO_LTO_FLAGS,
  'CXXFLAGS'        => CREW_COMMON_FNO_LTO_FLAGS,
  'FCFLAGS'         => CREW_COMMON_FNO_LTO_FLAGS,
  'FFLAGS'          => CREW_COMMON_FNO_LTO_FLAGS,
  'LIBRARY_PATH'    => CREW_GLIBC_INTERPRETER.nil? ? '' : "#{CREW_GLIBC_PREFIX}:#{CREW_LIB_PREFIX}",
  'LDFLAGS'         => CREW_FNO_LTO_LDFLAGS
}.reject { |_k, v| v == '' }
# parse from hash to shell readable string
CREW_ENV_FNO_LTO_OPTIONS = CREW_ENV_FNO_LTO_OPTIONS_HASH.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')

CREW_CONFIGURE_OPTIONS = <<~OPT.chomp
  --prefix=#{CREW_PREFIX} \
  --libdir=#{CREW_LIB_PREFIX} \
  --mandir=#{CREW_MAN_PREFIX} \
  --disable-dependency-tracking \
  --program-prefix='' \
  --program-suffix=''
OPT

CREW_MESON_OPTIONS = <<~OPT.chomp
  -Dprefix=#{CREW_PREFIX} \
  -Dlibdir=#{CREW_LIB_PREFIX} \
  -Dlocalstatedir=#{CREW_PREFIX}/var/local \
  -Dmandir=#{CREW_MAN_PREFIX} \
  -Dsharedstatedir=#{CREW_PREFIX}/var/local/lib \
  -Dbuildtype=release \
  -Db_lto=true \
  -Dstrip=true \
  -Db_pie=true \
  -Dc_args='#{CREW_CORE_FLAGS}' \
  -Dc_link_args='#{CREW_LINKER_FLAGS}' \
  -Dcpp_args='#{CREW_CORE_FLAGS}' \
  -Dcpp_link_args='#{CREW_LINKER_FLAGS}'
OPT

# Use ninja or samurai
CREW_NINJA = ENV.fetch('CREW_NINJA', 'ninja')

# Cmake sometimes wants to use LIB_SUFFIX to install libs in LIB64, so specify such for x86_64
# This is often considered deprecated. See discussio at https://gitlab.kitware.com/cmake/cmake/-/issues/18640
# and also https://bugzilla.redhat.com/show_bug.cgi?id=1425064
# CMAKE_LIBRARY_PATH is the build LIBRARY_PATH, as opposed to
# CMAKE_INSTALL_LIBDIR which defaults to lib or lib64.
CREW_CMAKE_OPTIONS = <<~OPT.chomp
  -DCMAKE_INSTALL_LIBDIR=#{ARCH_LIB} \
  -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
  -DCMAKE_LIBRARY_PATH='#{CREW_GLIBC_INTERPRETER.nil? ? CREW_LIB_PREFIX : "#{CREW_GLIBC_PREFIX};#{CREW_LIB_PREFIX}"}' \
  -DCMAKE_C_FLAGS='#{CREW_COMMON_FLAGS.gsub(/-fuse-ld=.{2,4}\s/, '')}' \
  -DCMAKE_CXX_FLAGS='#{CREW_COMMON_FLAGS.gsub(/-fuse-ld=.{2,4}\s/, '')}' \
  -DCMAKE_EXE_LINKER_FLAGS='#{CREW_LINKER_FLAGS}' \
  -DCMAKE_LINKER_TYPE=MOLD \
  -DCMAKE_SHARED_LINKER_FLAGS='#{CREW_LINKER_FLAGS}' \
  -DCMAKE_MODULE_LINKER_FLAGS='#{CREW_LINKER_FLAGS}' \
  -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=TRUE \
  -DCMAKE_BUILD_TYPE=Release \
  -Wno-dev
OPT

CREW_CMAKE_LIBSUFFIX_OPTIONS = "#{CREW_CMAKE_OPTIONS} -DLIB_SUFFIX=#{CREW_LIB_SUFFIX}"

GEM_ARCH = case ARCH
           when 'x86_64'
             'x86_64-linux'
           when 'i686'
             'x86-linux'
           when 'aarch64', 'armv7l'
             'armv8l-linux-eabihf'
           end

PY3_SETUP_BUILD_OPTIONS          = "--executable=#{CREW_PREFIX}/bin/python3"
PY2_SETUP_BUILD_OPTIONS          = "--executable=#{CREW_PREFIX}/bin/python2"
PY_SETUP_INSTALL_OPTIONS_NO_SVEM = "--root=#{CREW_DEST_DIR} --prefix=#{CREW_PREFIX} --compile"
PY_SETUP_INSTALL_OPTIONS         = "#{PY_SETUP_INSTALL_OPTIONS_NO_SVEM} --single-version-externally-managed"
PY3_BUILD_OPTIONS                = '--wheel --no-isolation'
PY3_INSTALLER_OPTIONS            = "--destdir=#{CREW_DEST_DIR} --compile-bytecode 2 dist/*.whl"
PY3_PIP_RETRIES                  = ENV.fetch('PY3_PIP_RETRIES', '5')

# Defaults for the current versions used in version checking, in case
# we are checking versions from outside Chromebrew, such as in CI.
# Do adjust necessary variables in install.sh when changed here.
crew_gcc_ver_default = '15'
crew_icu_ver_default = '77.1'
crew_llvm_ver_default = '21'
crew_perl_ver_default = '5.42'
crew_py_ver_default = '3.14'
crew_ruby_ver_default = '3.4'
if ENV['CI']
  CREW_GCC_VER  = "gcc#{crew_gcc_ver_default}"
  CREW_ICU_VER  = "icu#{crew_icu_ver_default}"
  CREW_LLVM_VER = "llvm#{crew_llvm_ver_default}"
  CREW_PERL_VER = "perl#{crew_perl_ver_default}"
  CREW_PY_VER   = "py#{crew_py_ver_default}"
  CREW_RUBY_VER = "ruby#{crew_ruby_ver_default}"
else
  CREW_GCC_VER  = Kernel.system('which gcc', %i[out err] => File::NULL) ? "gcc#{`gcc -dumpversion`.chomp}" : "gcc#{crew_gcc_ver_default}"
  CREW_ICU_VER  = Kernel.system('which uconv', %i[out err] => File::NULL) ? "icu#{`uconv --version`.chomp.split[3]}" : "icu#{crew_icu_ver_default}"
  CREW_LLVM_VER = Kernel.system('which llvm-config', %i[out err] => File::NULL) ? "llvm#{`llvm-config --version`.chomp.split('.')[0]}" : "llvm#{crew_llvm_ver_default}"
  CREW_PERL_VER = Kernel.system('which perl', %i[out err] => File::NULL) ? "perl#{`perl --version|xargs|cut -d\\( -f2|cut -d\\) -f1|cut -dv -f2`.chomp.sub(/\.\d+$/, '')}" : "perl#{crew_perl_ver_default}"
  CREW_PY_VER   = Kernel.system("#{CREW_PREFIX}/bin/python3 --version", %i[out err] => File::NULL) ? "py#{`python3 -c "print('.'.join(__import__('platform').python_version_tuple()[:2]))"`.chomp}" : "py#{crew_py_ver_default}"
  CREW_RUBY_VER = "ruby#{RUBY_VERSION.slice(/(?:.*(?=\.))/)}"
end
@buildsystems = ['Package']
Dir.glob("#{CREW_LIB_PATH}/lib/buildsystems/*.rb") { |file| @buildsystems << File.foreach(file, encoding: Encoding::UTF_8).grep(/^class/).to_s.split[1] }
CREW_VALID_BUILDSYSTEMS = @buildsystems.sort!

# Some packges need manual adjustments of URLS for different versions.
CREW_UPDATER_EXCLUDED_PKGS = Set[
  { pkg_name: 'clear_cache', comments: 'Internal Chromebrew Package.' },
  { pkg_name: 'gdk_base', comments: 'Internal Chromebrew Package.' },
  { pkg_name: 'glibc', comments: 'Requires manual update.' },
  { pkg_name: 'gpm', comments: 'Upstream is defunct.' },
  { pkg_name: 'hello_world_chromebrew', comments: 'Internal Chromebrew Package.' },
  { pkg_name: 'ld_default', comments: 'Internal Chromebrew Package.' },
  { pkg_name: 'linuxheaders', comments: 'Requires manual update.' },
  { pkg_name: 'pkg_config', comments: 'Upstream is abandoned.' },
  { pkg_name: 'py3_ldapdomaindump', comments: 'Build is broken.' },
  { pkg_name: 'ruby', comments: 'i686 needs building with GCC 14.' },
  { pkg_name: 'util_linux', comments: '2.41.2 build broken. See https://github.com/util-linux/util-linux/issues/3763' },
  { pkg_name: 'xdg_base', comments: 'Internal Chromebrew Package.' }
].to_h { |h| [h[:pkg_name], h[:comments]] }
CREW_AUTOMATIC_VERSION_UPDATE_EXCLUSION_REGEX = "(#{CREW_UPDATER_EXCLUDED_PKGS.keys.map { |p| "^#{p}$" }.join('|')})"

# Some packages have different names in anitya.
CREW_ANITYA_PACKAGE_NAME_MAPPINGS = Set[
  { pkg_name: 'asdf', anitya_pkg: 'asdf-vm', comments: '' },
  { pkg_name: 'broadway', anitya_pkg: 'gtk+3.0~stable', comments: '' },
  { pkg_name: 'cf', anitya_pkg: 'cf', comments: 'Prefer to GitHub' },
  { pkg_name: 'cups', anitya_pkg: 'cups', comments: 'Prefer to GitHub' },
  { pkg_name: 'cvs', anitya_pkg: 'cvs-stable', comments: '' },
  { pkg_name: 'docbook_xml51', anitya_pkg: 'docbook-xml', comments: '' },
  { pkg_name: 'doxygen', anitya_pkg: 'doxygen', comments: '' },
  { pkg_name: 'filecmd', anitya_pkg: 'file', comments: '' },
  { pkg_name: 'gcr_3', anitya_pkg: 'gcr~3', comments: '' },
  { pkg_name: 'gcr_4', anitya_pkg: 'gcr', comments: '' },
  { pkg_name: 'gemacs', anitya_pkg: 'emacs', comments: '' },
  { pkg_name: 'gexiv2', anitya_pkg: 'gexiv2~14.x', comments: '' },
  { pkg_name: 'gnome_docking_library', anitya_pkg: 'gdl', comments: '' },
  { pkg_name: 'gnu_time', anitya_pkg: 'time', comments: '' },
  { pkg_name: 'go_tools', anitya_pkg: 'golang-x-tools', comments: '' },
  { pkg_name: 'gsfonts', anitya_pkg: 'gs-fonts', comments: '' },
  { pkg_name: 'gtk3', anitya_pkg: 'gtk+3.0~stable', comments: '' },
  { pkg_name: 'gtk4', anitya_pkg: 'gtk', comments: '' },
  { pkg_name: 'gtkmm4', anitya_pkg: 'gtkmm', comments: '' },
  { pkg_name: 'gtksharp2', anitya_pkg: 'gtk-sharp', comments: '' },
  { pkg_name: 'gtksourceview_5', anitya_pkg: 'gtksourceview', comments: '' },
  { pkg_name: 'gvim', anitya_pkg: 'vim', comments: '' },
  { pkg_name: 'hunspell_en_us', anitya_pkg: 'LibreOffice', comments: '' },
  { pkg_name: 'hunspell_es_any', anitya_pkg: 'LibreOffice', comments: '' },
  { pkg_name: 'hunspell_es_us', anitya_pkg: 'LibreOffice', comments: '' },
  { pkg_name: 'hunspell_fr_fr', anitya_pkg: 'LibreOffice', comments: '' },
  { pkg_name: 'js91', anitya_pkg: 'spidermonkey~91', comments: '' },
  { pkg_name: 'js102', anitya_pkg: 'spidermonkey~102', comments: '' },
  { pkg_name: 'js115', anitya_pkg: 'spidermonkey~115', comments: '' },
  { pkg_name: 'js140', anitya_pkg: 'spidermonkey~140', comments: '' },
  { pkg_name: 'libappindicator_gtk3', anitya_pkg: 'libappindicator', comments: '' },
  { pkg_name: 'libcom_err', anitya_pkg: 'e2fsprogs', comments: '' },
  { pkg_name: 'libdbusmenu_gtk3', anitya_pkg: 'libdbusmenu', comments: '' },
  { pkg_name: 'libgedit_amtk', anitya_pkg: 'libgedit-amtk', comments: 'Prefer to GitHub' },
  { pkg_name: 'libgedit_gtksourceview', anitya_pkg: 'libgedit-gtksourceview', comments: 'Prefer to GitHub' },
  { pkg_name: 'libgconf', anitya_pkg: 'gconf', comments: '' },
  { pkg_name: 'libhubbub', anitya_pkg: 'hubbub', comments: '' },
  { pkg_name: 'libindicator_gtk3', anitya_pkg: 'libindicator', comments: '' },
  { pkg_name: 'libkmod', anitya_pkg: 'kmod', comments: '' },
  { pkg_name: 'libmbedtls', anitya_pkg: 'mbedtls', comments: 'Prefer to GitHub' },
  { pkg_name: 'libmediainfo', anitya_pkg: 'mediainfo', comments: '' },
  { pkg_name: 'libnghttp3', anitya_pkg: 'nghttp3', comments: '' },
  { pkg_name: 'libngtcp2', anitya_pkg: 'ngtcp2', comments: '' },
  { pkg_name: 'libpeas2', anitya_pkg: 'libpeas', comments: '' },
  { pkg_name: 'libpth', anitya_pkg: 'pth', comments: '' },
  { pkg_name: 'libsdl', anitya_pkg: 'sdl', comments: '' },
  { pkg_name: 'libsoup2', anitya_pkg: 'libsoup2~stable', comments: '' },
  { pkg_name: 'libssp', anitya_pkg: 'gcc', comments: '' },
  { pkg_name: 'libstfl', anitya_pkg: 'stfl', comments: '' },
  { pkg_name: 'libtinfo', anitya_pkg: 'ncurses', comments: '' },
  { pkg_name: 'libunbound', anitya_pkg: 'unbound', comments: '' },
  { pkg_name: 'libx264', anitya_pkg: 'x264', comments: '' },
  { pkg_name: 'libxml2_autotools', anitya_pkg: 'libxml2', comments: '' },
  { pkg_name: 'linux_pam', anitya_pkg: 'pam', comments: '' },
  { pkg_name: "#{CREW_LLVM_VER}_build", anitya_pkg: 'llvm', comments: '' },
  { pkg_name: "#{CREW_LLVM_VER}_dev", anitya_pkg: 'llvm', comments: '' },
  { pkg_name: "#{CREW_LLVM_VER}_lib", anitya_pkg: 'llvm', comments: '' },
  { pkg_name: 'mediainfo_gui', anitya_pkg: 'mediainfo', comments: '' },
  { pkg_name: 'mold', anitya_pkg: 'mold', comments: 'Prefer to GitHub' },
  { pkg_name: 'ninja', anitya_pkg: 'ninja-build', comments: '' },
  { pkg_name: 'nnn', anitya_pkg: 'nnn', comments: 'Prefer to GitHub' },
  { pkg_name: 'openssl', anitya_pkg: 'openssl-3.5-LTS', comments: 'Prefer to GitHub' },
  { pkg_name: 'owl', anitya_pkg: 'Owl Lisp', comments: '' },
  { pkg_name: 'pcre2', anitya_pkg: 'pcre2', comments: 'Prefer to GitHub' },
  { pkg_name: 'pkg_7_zip', anitya_pkg: '7zip~stable', comments: 'Prefer to GitHub' },
  { pkg_name: 'procps', anitya_pkg: 'procps-ng', comments: '' },
  { pkg_name: 'pthread_stubs', anitya_pkg: 'libpthread-stubs', comments: '' },
  { pkg_name: 'py3_atspi', anitya_pkg: 'pyatspi', comments: '' },
  { pkg_name: 'python3', anitya_pkg: 'python314', comments: '' },
  { pkg_name: 'rdfind', anitya_pkg: 'rdfind', comments: 'Prefer to GitHub' },
  { pkg_name: 'rest', anitya_pkg: 'librest', comments: 'Prefer to GitHub' },
  { pkg_name: 'selenium_server_standalone', anitya_pkg: 'selenium', comments: '' },
  { pkg_name: 'signal_desktop', anitya_pkg: 'signal', comments: '' },
  { pkg_name: 'smbclient', anitya_pkg: 'samba', comments: '' },
  { pkg_name: 'tcpwrappers', anitya_pkg: 'tcp_wrappers', comments: '' },
  { pkg_name: 'tepl_6', anitya_pkg: 'libgedit-tepl', comments: '' },
  { pkg_name: 'upx', anitya_pkg: 'upx', comments: 'Prefer to GitHub' },
  { pkg_name: 'vidstab', anitya_pkg: 'vid.stab', comments: 'Prefer to GitHub' },
  { pkg_name: 'vim_runtime', anitya_pkg: 'vim', comments: '' },
  { pkg_name: 'wayland_info', anitya_pkg: 'wayland-utils', comments: '' },
  { pkg_name: 'webkit2gtk_4_0', anitya_pkg: 'webkitgtk~stable', comments: '' },
  { pkg_name: 'webkit2gtk_4_1', anitya_pkg: 'webkitgtk~stable', comments: '' },
  { pkg_name: 'webkitgtk_6', anitya_pkg: 'webkitgtk~stable', comments: '' },
  { pkg_name: 'xauth', anitya_pkg: 'xorg-x11-xauth', comments: '' },
  { pkg_name: 'xercesc', anitya_pkg: 'xerces-c', comments: 'Prefer to GitHub' },
  { pkg_name: 'xorg_proto', anitya_pkg: 'xorgproto', comments: '' },
  { pkg_name: 'xxd_standalone', anitya_pkg: 'vim', comments: '' },
  { pkg_name: 'yad', anitya_pkg: 'yad', comments: 'Prefer to GitHub' },
  { pkg_name: 'zig13', anitya_pkg: 'zig', comments: '' },
  { pkg_name: 'zimg', anitya_pkg: 'zimg', comments: 'Prefer to GitHub' },
  { pkg_name: 'zoneinfo', anitya_pkg: 'tzdata', comments: '' }
].to_h { |h| [h[:pkg_name], h[:anitya_pkg]] }

CREW_LICENSE = <<~LICENSESTRING
  Copyright (C) 2013-2025 Chromebrew Authors

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program. If not, see https://www.gnu.org/licenses/gpl-3.0.html.

  Chromebrew embeds lib/docopt.rb from another project under the MIT License.
  You should have received a copy of the license along with this program.
  If not, see https://github.com/docopt/docopt.rb/blob/master/LICENSE
LICENSESTRING

CREW_DOCOPT = <<~DOCOPT
  Chromebrew - Package manager for Chrome OS https://chromebrew.github.io

  Usage:
    crew build [options] [-f|--force] [-k|--keep] [-v|--verbose] <name> ...
    crew check [-f|--force] <name> ...
    crew const [options] [-v|--verbose] [<name> ...]
    crew deps [options] [--deep] [-t|--tree] [-b|--include-build-deps] [--exclude-buildessential] [-v|--verbose] <name> ...
    crew diskstat [options] [-a|--all] [<count>]
    crew download [options] [-s|--source] [-v|--verbose] <name> ...
    crew files [options] <name> ...
    crew help [options] [<command>] [-v|--verbose] [<subcommand>]
    crew install [options] [-f|--force] [-k|--keep] [--regenerate-filelist] [-s|--source] [-S|--recursive-build] [-v|--verbose] <name> ...
    crew list [options] [-v|--verbose] (available|compatible|incompatible|essential|installed)
    crew postinstall [options] [-v|--verbose] <name> ...
    crew prop [options] [<property>]
    crew reinstall [options] [-f|--force] [-k|--keep] [-s|--source] [--regenerate-filelist] [-S|--recursive-build] [-v|--verbose] <name> ...
    crew remove [options] [-f|--force] [-v|--verbose] <name> ...
    crew search [options] [-v|--verbose] <name> ...
    crew sysinfo [options] [-v|--verbose]
    crew update [options] [-v|--verbose]
    crew update_package_file [options] [-v|--verbose] [<name> ...]
    crew upgrade [options] [-f|--force] [-k|--keep] [--regenerate-filelist] [-s|--source] [-v|--verbose] [<name> ...]
    crew upload [options] [-f|--force] [-v|--verbose] [<name> ...]
    crew upstream [options] [-j|--json|-u|--update-package-files|-v|--verbose|-vv] <name> ...
    crew version [options] [<name>]
    crew whatprovides [options] <pattern> ...

    -b --include-build-deps    Include build dependencies in output.
    -c --color                 Use colors even if standard out is not a tty.
    -d --no-color              Disable colors even if standard out is a tty.
    -D --debug                 Enable debugging.
    -f --force                 Force where relevant.
    -h --help                  Show this screen.
    -j --json                  Display output in json format.
    -k --keep                  Keep the `CREW_BREW_DIR` (#{CREW_BREW_DIR}) directory.
    -L --license               Display the crew license.
    -s --source                Build or download from source even if pre-compiled binary exists.
    -S --recursive-build       Build from source, including all dependencies, even if pre-compiled binaries exist.
    --regenerate-filelist      Force regeneration of package filelists on install.
    -t --tree                  Print dependencies in a tree-structure format.
    -u --update-package-files  Attempt to update the package version.
    -v --verbose               Show extra information.
    -V --version               Display the crew version.
DOCOPT

# All available crew commands.
CREW_COMMANDS = CREW_DOCOPT.scan(/crew ([^\s]+)/).flatten.sort.join(', ').gsub('.', '')
