# lib/const.rb
# Defines common constants used in different parts of crew
require 'etc'

OLD_CREW_VERSION ||= defined?(CREW_VERSION) ? CREW_VERSION : '1.0'
CREW_VERSION ||= '1.60.5' unless defined?(CREW_VERSION) && CREW_VERSION == OLD_CREW_VERSION

# Kernel architecture.
KERN_ARCH ||= Etc.uname[:machine]

# Read and parse processor information from /proc/cpuinfo
CPUINFO ||= File.readlines('/proc/cpuinfo').map { |line| line.chomp.split(/\t+: /) if line.include?("\t") }.compact.to_h

# We report aarch64 & armv8l machines as armv7l for now, as we treat
# them as if they were armv7l.
# When we have proper aarch64 support, remove this.
# Also, we allow ARCH to be changed via the ARCH environment variable.
ARCH ||= ENV.fetch('ARCH') do |_name|
  case KERN_ARCH
  when 'aarch64', 'armv8l'
    'armv7l'
  else KERN_ARCH
  end
end

# Allow for edge case of i686 install on a x86_64 host before linux32 is
# downloaded, e.g. in a docker container.
CREW_LIB_SUFFIX ||= ARCH.eql?('x86_64') && Dir.exist?('/lib64') ? '64' : ''
ARCH_LIB        ||= "lib#{CREW_LIB_SUFFIX}"

CREW_PREFIX ||= ENV.fetch('CREW_PREFIX', '/usr/local') unless defined?(CREW_PREFIX)

# Glibc related constants
CREW_GLIBC_PREFIX      ||= File.join(CREW_PREFIX, 'opt/glibc-libs')
CREW_GLIBC_INTERPRETER ||= File.symlink?("#{CREW_PREFIX}/bin/ld.so") ? File.realpath("#{CREW_PREFIX}/bin/ld.so") : nil unless defined?(CREW_GLIBC_INTERPRETER)

# Glibc version can be found from the output of libc.so.6
@libcvertokens = (`LD_AUDIT= #{CREW_GLIBC_PREFIX}/libc.so.6`.lines.first.chomp.split(/[\s]/) if File.file?("#{CREW_GLIBC_PREFIX}/libc.so.6"))
@libc_version = @libcvertokens.nil? ? Etc.confstr(Etc::CS_GNU_LIBC_VERSION).split.last : @libcvertokens[@libcvertokens.find_index('version') + 1].sub!(/[[:punct:]]?$/, '')
LIBC_VERSION ||= ENV.fetch('LIBC_VERSION', @libc_version) unless defined?(LIBC_VERSION)

if CREW_PREFIX == '/usr/local'
  CREW_BUILD_FROM_SOURCE ||= ENV.fetch('CREW_BUILD_FROM_SOURCE', false) unless defined?(CREW_BUILD_FROM_SOURCE)
  HOME ||= File.exist?('/.dockerenv') ? '/home/chronos/user' : Dir.home
else
  CREW_BUILD_FROM_SOURCE ||= true
  HOME ||= File.join(CREW_PREFIX, Dir.home)
end

# These are packages that crew needs to run-- only packages that the bin/crew needs should be required here.
# lz4, for example, is required for zstd to have lz4 support, but this is not required to run bin/crew.
# The LIBC_VERSION ternary is to reflect the change from glibc_build to glibc_lib as the source of essential libraries starting at glibc 2.35.
CREW_ESSENTIAL_PACKAGES ||= %W[gcc_lib #{LIBC_VERSION.to_f > 2.34 ? "glibc_lib#{LIBC_VERSION.delete('.')}" : "glibc_build#{LIBC_VERSION.delete('.')}"} glibc_standalone gmp ruby zlib zlib_ng zstd]

CREW_IN_CONTAINER ||= File.exist?('/.dockerenv') || ENV.fetch('CREW_IN_CONTAINER', false) unless defined?(CREW_IN_CONTAINER)

CREW_CPU_VENDOR ||= CPUINFO['vendor_id'] unless defined?(CREW_CPU_VENDOR)
# The cpuinfo vendor_id may not exist on non-x86 platforms, or when a
# container is virtualized on non-x86 platforms. Default to
# CREW_IS_INTEL for x86 architectures.
if %w[x86_64 i686].include?(ARCH)
  CREW_IS_AMD ||= CREW_CPU_VENDOR.eql?('AuthenticAMD').nil? unless defined?(CREW_IS_AMD)
  CREW_IS_INTEL ||= %w[unknown GenuineIntel].include?(CREW_CPU_VENDOR) unless defined?(CREW_IS_INTEL)
else
  CREW_IS_AMD ||= nil unless defined?(CREW_IS_AMD)
  CREW_IS_INTEL ||= nil unless defined?(CREW_IS_INTEL)
end

# Use sane minimal defaults if in container and no override specified.
CREW_KERNEL_VERSION ||=
  if CREW_IN_CONTAINER && ENV.fetch('CREW_KERNEL_VERSION', nil).nil?
    ARCH.eql?('i686') ? '3.8' : '5.10'
  else
    ENV.fetch('CREW_KERNEL_VERSION', Etc.uname[:release].rpartition('.').first)
  end

CREW_LIB_PREFIX       ||= File.join(CREW_PREFIX, ARCH_LIB)
CREW_MAN_PREFIX       ||= File.join(CREW_PREFIX, 'share/man')
CREW_LIB_PATH         ||= File.join(CREW_PREFIX, 'lib/crew')
CREW_PACKAGES_PATH    ||= File.join(CREW_LIB_PATH, 'packages')
CREW_CONFIG_PATH      ||= File.join(CREW_PREFIX, 'etc/crew')
CREW_META_PATH        ||= File.join(CREW_CONFIG_PATH, 'meta')
CREW_BREW_DIR         ||= File.join(CREW_PREFIX, 'tmp/crew')
CREW_DEST_DIR         ||= File.join(CREW_BREW_DIR, 'dest')
CREW_DEST_PREFIX      ||= File.join(CREW_DEST_DIR, CREW_PREFIX)
CREW_DEST_LIB_PREFIX  ||= File.join(CREW_DEST_DIR, CREW_LIB_PREFIX)
CREW_DEST_MAN_PREFIX  ||= File.join(CREW_DEST_DIR, CREW_MAN_PREFIX)
CREW_WINE_PREFIX      ||= File.join(CREW_LIB_PREFIX, 'wine')
CREW_DEST_WINE_PREFIX ||= File.join(CREW_DEST_PREFIX, CREW_WINE_PREFIX)

# Local constants for contributors.
CREW_LOCAL_REPO_ROOT ||= `git rev-parse --show-toplevel 2> /dev/null`.chomp
CREW_LOCAL_BUILD_DIR ||= "#{CREW_LOCAL_REPO_ROOT}/release/#{ARCH}"
CREW_GITLAB_PKG_REPO ||= 'https://gitlab.com/api/v4/projects/26210301/packages'

# Put musl build dir under CREW_PREFIX/share/musl to avoid FHS incompatibility
CREW_MUSL_PREFIX      ||= File.join(CREW_PREFIX, '/share/musl/')
CREW_DEST_MUSL_PREFIX ||= File.join(CREW_DEST_DIR, CREW_MUSL_PREFIX)
MUSL_LIBC_VERSION     ||= File.executable?("#{CREW_MUSL_PREFIX}/lib/libc.so") ? `#{CREW_MUSL_PREFIX}/lib/libc.so 2>&1`[/\bVersion\s+\K\S+/] : nil unless defined?(MUSL_LIBC_VERSION)

CREW_DEST_HOME          ||= File.join(CREW_DEST_DIR, HOME)
CREW_CACHE_DIR          ||= ENV.fetch('CREW_CACHE_DIR', "#{HOME}/.cache/crewcache") unless defined?(CREW_CACHE_DIR)
CREW_CACHE_BUILD        ||= ENV.fetch('CREW_CACHE_BUILD', false) unless defined?(CREW_CACHE_BUILD)
CREW_CACHE_FAILED_BUILD ||= ENV.fetch('CREW_CACHE_FAILED_BUILD', false) unless defined?(CREW_CACHE_FAILED_BUILD)
CREW_NO_GIT             ||= ENV.fetch('CREW_NO_GIT', false) unless defined?(CREW_NO_GIT)
CREW_UNATTENDED         ||= ENV.fetch('CREW_UNATTENDED', false) unless defined?(CREW_UNATTENDED)

CREW_STANDALONE_UPGRADE_ORDER = %w[openssl ruby python3] unless defined?(CREW_STANDALONE_UPGRADE_ORDER)

CREW_DEBUG   ||= ARGV.intersect?(%w[-D --debug]) unless defined?(CREW_DEBUG)
CREW_FORCE   ||= ARGV.intersect?(%w[-f --force]) unless defined?(CREW_FORCE)
CREW_VERBOSE ||= ARGV.intersect?(%w[-v --verbose]) unless defined?(CREW_VERBOSE)

# Set CREW_NPROC from environment variable, `distcc -j`, or `nproc`.
CREW_NPROC ||=
  if File.file?("#{CREW_PREFIX}/bin/distcc")
    ENV.fetch('CREW_NPROC', `distcc -j`.chomp)
  else
    ENV.fetch('CREW_NPROC', `nproc`.chomp)
  end

# Set following as boolean if environment variables exist.
# Timeout for agree questions in package.rb:
CREW_AGREE_TIMEOUT_SECONDS           ||= ENV.fetch('CREW_AGREE_TIMEOUT_SECONDS', 10).to_i unless defined?(CREW_AGREE_TIMEOUT_SECONDS)
CREW_CACHE_ENABLED                   ||= ENV.fetch('CREW_CACHE_ENABLED', false) unless defined?(CREW_CACHE_ENABLED)
CREW_CONFLICTS_ONLY_ADVISORY         ||= ENV.fetch('CREW_CONFLICTS_ONLY_ADVISORY', false) unless defined?(CREW_CONFLICTS_ONLY_ADVISORY)
# or use conflicts_ok
CREW_DISABLE_ENV_OPTIONS             ||= ENV.fetch('CREW_DISABLE_ENV_OPTIONS', false) unless defined?(CREW_DISABLE_ENV_OPTIONS)
# or use no_env_options
CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY ||= ENV.fetch('CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY', false) unless defined?(CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY)
# or use no_fhs
CREW_NOT_COMPRESS                    ||= ENV.fetch('CREW_NOT_COMPRESS', false) unless defined?(CREW_NOT_COMPRESS)
# or use no_compress
CREW_NOT_LINKS                       ||= ENV.fetch('CREW_NOT_LINKS', false) unless defined?(CREW_NOT_LINKS)
# or use no_links
CREW_NOT_STRIP                       ||= ENV.fetch('CREW_NOT_STRIP', false) unless defined?(CREW_NOT_STRIP)
# or use no_strip
CREW_NOT_SHRINK_ARCHIVE              ||= ENV.fetch('CREW_NOT_SHRINK_ARCHIVE', false) unless defined?(CREW_NOT_SHRINK_ARCHIVE)
# or use no_shrink

# Allow git constants to be set from environment variables (for testing)
CREW_REPO   ||= ENV.fetch('CREW_REPO', 'https://github.com/chromebrew/chromebrew.git') unless defined?(CRE_REPO)
CREW_BRANCH ||= ENV.fetch('CREW_BRANCH', 'master') unless defined?(CREW_BRANCH)

USER ||= Etc.getlogin unless defined?(USER)

unless defined?(CHROMEOS_RELEASE)
  CHROMEOS_RELEASE =
    if File.exist?('/etc/lsb-release')
      File.read('/etc/lsb-release')[/CHROMEOS_RELEASE_CHROME_MILESTONE=(.+)/, 1]
    else
      # newer version of Chrome OS exports info to env by default
      ENV.fetch('CHROMEOS_RELEASE_CHROME_MILESTONE', nil)
    end
end

# If CREW_DISABLE_MVDIR environment variable exists and is equal to 1 use rsync/tar to install files in lieu of crew-mvdir.
CREW_DISABLE_MVDIR ||= ENV.fetch('CREW_DISABLE_MVDIR', false) unless defined?(CREW_DISABLE_MVDIR)

# Days between crew prompting to run 'crew update' and doing gem updates.
CREW_UPDATE_CHECK_INTERVAL ||= ENV.fetch('CREW_UPDATE_CHECK_INTERVAL', 7).to_i unless defined?(CREW_UPDATE_CHECK_INTERVAL)

# If CREW_USE_CURL environment variable exists use curl in lieu of net/http.
CREW_USE_CURL ||= ENV.fetch('CREW_USE_CURL', false) unless defined?(CREW_USE_CURL)

# Use an external downloader instead of net/http if CREW_DOWNLOADER is set, see lib/downloader.rb for more info
# About the format of the CREW_DOWNLOADER variable, see line 130-133 in lib/downloader.rb
CREW_DOWNLOADER ||= ENV.fetch('CREW_DOWNLOADER', nil) unless defined?(CREW_DOWNLOADER)

# Downloader maximum retry count
CREW_DOWNLOADER_RETRY ||= ENV.fetch('CREW_DOWNLOADER_RETRY', 3).to_i unless defined?(CREW_DOWNLOADER_RETRY)

# show download progress bar or not (only applied when using the default ruby downloader)
CREW_HIDE_PROGBAR = ENV.fetch('CREW_HIDE_PROGBAR', false) unless defined?(CREW_HIDE_PROGBAR)

# set certificate file location for lib/downloader.rb
SSL_CERT_FILE ||=
  if ENV['SSL_CERT_FILE'] && File.exist?(ENV['SSL_CERT_FILE'])
    ENV['SSL_CERT_FILE']
  elsif File.exist?("#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt")
    "#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt"
  else
    '/etc/ssl/certs/ca-certificates.crt'
  end

SSL_CERT_DIR ||=
  if ENV['SSL_CERT_DIR'] && Dir.exist?(ENV['SSL_CERT_DIR'])
    ENV['SSL_CERT_DIR']
  elsif Dir.exist?("#{CREW_PREFIX}/etc/ssl/certs")
    "#{CREW_PREFIX}/etc/ssl/certs"
  else
    '/etc/ssl/certs'
  end

CREW_ARCH_FLAGS_OVERRIDE ||= ENV.fetch('CREW_ARCH_FLAGS_OVERRIDE', '') unless defined?(CREW_ARCH_FLAGS_OVERRIDE)
case ARCH
when 'aarch64', 'armv7l'
  CREW_TARGET ||= 'armv7l-cros-linux-gnueabihf'
  # These settings have been selected to match debian armhf.
  # Using -mfpu=neon breaks builds such as webkit2gtk.
  CREW_ARCH_FLAGS ||= CREW_ARCH_FLAGS_OVERRIDE.to_s.empty? ? '-mfloat-abi=hard -mthumb -mfpu=vfpv3-d16 -march=armv7-a+fp' : CREW_ARCH_FLAGS_OVERRIDE
when 'i686'
  CREW_TARGET ||= 'i686-cros-linux-gnu'
  CREW_ARCH_FLAGS ||= CREW_ARCH_FLAGS_OVERRIDE.to_s.empty? ? '' : CREW_ARCH_FLAGS_OVERRIDE
when 'x86_64'
  CREW_TARGET ||= 'x86_64-cros-linux-gnu'
  CREW_ARCH_FLAGS ||= CREW_ARCH_FLAGS_OVERRIDE.to_s.empty? ? '' : CREW_ARCH_FLAGS_OVERRIDE
end

CREW_LINKER ||= ENV.fetch('CREW_LINKER', 'mold') unless defined?(CREW_LINKER)
CREW_LINKER_FLAGS ||= ENV.fetch('CREW_LINKER_FLAGS', '-flto=auto') unless defined?(CREW_LINKER_FLAGS)

CREW_CORE_FLAGS           ||= "-O3 -pipe -ffat-lto-objects -fPIC #{CREW_ARCH_FLAGS} -fuse-ld=#{CREW_LINKER} #{CREW_LINKER_FLAGS}"
CREW_COMMON_FLAGS         ||= "#{CREW_CORE_FLAGS} -B#{CREW_GLIBC_PREFIX} -flto=auto"
CREW_COMMON_FNO_LTO_FLAGS ||= "#{CREW_CORE_FLAGS} -B#{CREW_GLIBC_PREFIX} -fno-lto"
CREW_FNO_LTO_LDFLAGS      ||= '-fno-lto'

CREW_LINKER_FLAGS << " -Wl,--dynamic-linker,#{CREW_GLIBC_INTERPRETER} -B#{CREW_GLIBC_PREFIX} -L#{CREW_GLIBC_PREFIX}" if CREW_GLIBC_INTERPRETER

CREW_ENV_OPTIONS_HASH ||=
  if CREW_DISABLE_ENV_OPTIONS
    { 'CREW_DISABLE_ENV_OPTIONS' => '1' }
  else
    {
      'CFLAGS'          => CREW_COMMON_FLAGS,
      'CXXFLAGS'        => CREW_COMMON_FLAGS,
      'FCFLAGS'         => CREW_COMMON_FLAGS,
      'FFLAGS'          => CREW_COMMON_FLAGS,
      'LIBRARY_PATH'    => "#{CREW_GLIBC_PREFIX}:#{CREW_LIB_PREFIX}",
      'LDFLAGS'         => CREW_LINKER_FLAGS
    }
  end

# parse from hash to shell readable string
CREW_ENV_OPTIONS ||= CREW_ENV_OPTIONS_HASH.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')

CREW_ENV_FNO_LTO_OPTIONS_HASH ||= {
  'CFLAGS'          => CREW_COMMON_FNO_LTO_FLAGS,
  'CXXFLAGS'        => CREW_COMMON_FNO_LTO_FLAGS,
  'FCFLAGS'         => CREW_COMMON_FNO_LTO_FLAGS,
  'FFLAGS'          => CREW_COMMON_FNO_LTO_FLAGS,
  'LIBRARY_PATH'    => "#{CREW_GLIBC_PREFIX}:#{CREW_LIB_PREFIX}",
  'LDFLAGS'         => CREW_FNO_LTO_LDFLAGS
}
# parse from hash to shell readable string
CREW_ENV_FNO_LTO_OPTIONS ||= CREW_ENV_FNO_LTO_OPTIONS_HASH.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')

CREW_CONFIGURE_OPTIONS ||= <<~OPT.chomp
  --prefix=#{CREW_PREFIX} \
  --libdir=#{CREW_LIB_PREFIX} \
  --mandir=#{CREW_MAN_PREFIX} \
  --disable-dependency-tracking \
  --program-prefix='' \
  --program-suffix=''
OPT

CREW_MESON_OPTIONS ||= <<~OPT.chomp
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
CREW_NINJA ||= ENV.fetch('CREW_NINJA', 'ninja') unless defined?(CREW_NINJA)

# Cmake sometimes wants to use LIB_SUFFIX to install libs in LIB64, so specify such for x86_64
# This is often considered deprecated. See discussio at https://gitlab.kitware.com/cmake/cmake/-/issues/18640
# and also https://bugzilla.redhat.com/show_bug.cgi?id=1425064
# CMAKE_LIBRARY_PATH is the build LIBRARY_PATH, as opposed to
# CMAKE_INSTALL_LIBDIR which defaults to lib or lib64.
CREW_CMAKE_OPTIONS ||= <<~OPT.chomp
  -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
  -DCMAKE_LIBRARY_PATH='#{CREW_GLIBC_PREFIX};#{CREW_LIB_PREFIX}' \
  -DCMAKE_C_FLAGS='#{CREW_COMMON_FLAGS.gsub(/-fuse-ld=.{2,4}\s/, '')}' \
  -DCMAKE_CXX_FLAGS='#{CREW_COMMON_FLAGS.gsub(/-fuse-ld=.{2,4}\s/, '')}' \
  -DCMAKE_EXE_LINKER_FLAGS='#{CREW_LINKER_FLAGS}' \
  -DCMAKE_LINKER_TYPE=#{CREW_LINKER.upcase} \
  -DCMAKE_SHARED_LINKER_FLAGS='#{CREW_LINKER_FLAGS}' \
  -DCMAKE_MODULE_LINKER_FLAGS='#{CREW_LINKER_FLAGS}' \
  -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=TRUE \
  -DCMAKE_BUILD_TYPE=Release
OPT

CREW_CMAKE_LIBSUFFIX_OPTIONS ||= "#{CREW_CMAKE_OPTIONS} -DLIB_SUFFIX=#{CREW_LIB_SUFFIX}"

GEM_ARCH ||= case ARCH
             when 'x86_64'
               'x86_64-linux'
             when 'i686'
               'x86-linux'
             when 'aarch64', 'armv7l'
               'armv8l-linux-eabihf'
             end

PY3_SETUP_BUILD_OPTIONS          ||= "--executable=#{CREW_PREFIX}/bin/python3"
PY2_SETUP_BUILD_OPTIONS          ||= "--executable=#{CREW_PREFIX}/bin/python2"
PY_SETUP_INSTALL_OPTIONS_NO_SVEM ||= "--root=#{CREW_DEST_DIR} --prefix=#{CREW_PREFIX} --compile"
PY_SETUP_INSTALL_OPTIONS         ||= "#{PY_SETUP_INSTALL_OPTIONS_NO_SVEM} --single-version-externally-managed"
PY3_BUILD_OPTIONS                ||= '--wheel --no-isolation'
PY3_INSTALLER_OPTIONS            ||= "--destdir=#{CREW_DEST_DIR} --compile-bytecode 2 dist/*.whl"
PY3_PIP_RETRIES                  ||= ENV.fetch('PY3_PIP_RETRIES', '5') unless defined?(PY3_PIP_RETRIES)

CREW_GCC_VER ||= Kernel.system('which gcc', %i[out err] => File::NULL) ? "gcc#{`gcc -dumpversion`.chomp}" : 'gcc14' unless defined?(CREW_GCC_VER)
CREW_ICU_VER ||= Kernel.system('which uconv', %i[out err] => File::NULL) ? "icu#{`uconv --version`.chomp.split[3]}" : 'icu75.1' unless defined?(CREW_ICU_VER)
CREW_LLVM_VER ||= Kernel.system('which llvm-config', %i[out err] => File::NULL) ? "llvm#{`llvm-config --version`.chomp.split('.')[0]}" : 'llvm20' unless defined?(CREW_LLVM_VER)
CREW_PERL_VER ||= Kernel.system('which perl', %i[out err] => File::NULL) ? "perl#{`perl -MConfig -e "print \\\"\\\$Config{'PERL_API_REVISION'}.\\\$Config{'PERL_API_VERSION'}\\\";"`}" : 'perl5.40' unless defined?(CREW_PERL_VER)
CREW_PY_VER ||= Kernel.system("#{CREW_PREFIX}/bin/python3 --version", %i[out err] => File::NULL) ? "py#{`python3 -c "print('.'.join(__import__('platform').python_version_tuple()[:2]))"`.chomp}" : 'py3.13' unless defined?(CREW_PY_VER)
CREW_RUBY_VER ||= "ruby#{RUBY_VERSION.slice(/(?:.*(?=\.))/)}" unless defined?(CREW_RUBY_VER)
@buildsystems = ['Package']
Dir.glob("#{CREW_LIB_PATH}/lib/buildsystems/*.rb") { |file| @buildsystems << File.foreach(file, encoding: Encoding::UTF_8).grep(/^class/).to_s.split[1] }
CREW_VALID_BUILDSYSTEMS ||= @buildsystems.sort!

CREW_LICENSE ||= <<~LICENSESTRING
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

CREW_DOCOPT ||= <<~DOCOPT
  Chromebrew - Package manager for Chrome OS https://chromebrew.github.io

  Usage:
    crew build [options] [-f|--force] [-k|--keep] [-v|--verbose] <name> ...
    crew check [-f|--force] <name> ...
    crew const [options] [-v|--verbose] [<name> ...]
    crew deps [options] [--deep] [-t|--tree] [-b|--include-build-deps] [--exclude-buildessential] [-v|--verbose] <name> ...
    crew download [options] [-s|--source] [-v|--verbose] <name> ...
    crew files [options] <name> ...
    crew help [options] [<command>] [-v|--verbose] [<subcommand>]
    crew install [options] [-f|--force] [-k|--keep] [-s|--source] [-S|--recursive-build] [-v|--verbose] <name> ...
    crew list [options] [-v|--verbose] (available|compatible|incompatible|essential|installed)
    crew postinstall [options] [-v|--verbose] <name> ...
    crew prop [options] [<property>]
    crew reinstall [options] [-f|--force] [-k|--keep] [-s|--source] [-S|--recursive-build] [-v|--verbose] <name> ...
    crew remove [options] [-f|--force] [-v|--verbose] <name> ...
    crew search [options] [-v|--verbose] <name> ...
    crew sysinfo [options] [-v|--verbose]
    crew update [options] [-v|--verbose]
    crew upgrade [options] [-f|--force] [-k|--keep] [-s|--source] [-v|--verbose] [<name> ...]
    crew upload [options] [-f|--force] [-v|--verbose] [<name> ...]
    crew upstream [options] [-v|--verbose] [<name> ...]
    crew whatprovides [options] <pattern> ...

    -b --include-build-deps  Include build dependencies in output.
    -c --color               Use colors even if standard out is not a tty.
    -d --no-color            Disable colors even if standard out is a tty.
    -D --debug               Enable debugging.
    -f --force               Force where relevant.
    -h --help                Show this screen.
    -k --keep                Keep the `CREW_BREW_DIR` (#{CREW_BREW_DIR}) directory.
    -L --license             Display the crew license.
    -s --source              Build or download from source even if pre-compiled binary exists.
    -S --recursive-build     Build from source, including all dependencies, even if pre-compiled binaries exist.
    -t --tree                Print dependencies in a tree-structure format.
    -v --verbose             Show extra information.
    -V --version             Display the crew version.
DOCOPT

# All available crew commands.
CREW_COMMANDS ||= CREW_DOCOPT.scan(/crew ([^\s]+)/).flatten.sort.join(', ').gsub('.', '')
