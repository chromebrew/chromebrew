# lib/const.rb
# Defines common constants used in different parts of crew

CREW_VERSION = '1.46.9'

# kernel architecture
KERN_ARCH = `uname -m`.chomp

# read and parse processor information from /proc/cpuinfo
CPUINFO = File.read('/proc/cpuinfo') \
              .partition("\n\n")[0] \
              .scan(/^(.+?)\t*: (.+)$/).to_h \
              .transform_keys(&:downcase)

# get architectures supported by the processor natively
CPU_SUPPORTED_ARCH = if CPUINFO.key?('flags')
                       # x86-based processor stores supported instructions in 'flags' field
                       if CPUINFO['flags'].include?(' lm ')
                         # if the processor supports long mode, then it is 64-bit
                         %w[i686 x86_64]
                       else
                         # legacy x86 processor
                         %w[i686]
                       end
                     elsif CPUINFO.key?('features')
                       # ARM-based processor stores supported instructions in 'features' field
                       if CPUINFO['cpu architecture'].to_i >= 8
                         # if the processor is ARMv8+, then it is 64-bit
                         %w[aarch64 armv7l armv8l]
                       else
                         # ARMv7 processor
                         %w[armv7l]
                       end
                     end

# we are running under user-mode qemu if the processor
# does not compatible with the kernel architecture natively
QEMU_EMULATED = !CPU_SUPPORTED_ARCH.include?(KERN_ARCH)

# This helps with virtualized builds on aarch64 machines which report armv8l when linux32 is run.
# We also report aarch64 machines as armv7l for now, as we treat them as if they were armv7l.
# When we have proper aarch64 support, remove this.
ARCH = %w[aarch64 armv8l].include?(KERN_ARCH) ? 'armv7l' : ENV.fetch('ARCH', KERN_ARCH)

# Allow for edge case of i686 install on a x86_64 host before linux32 is
# downloaded, e.g. in a docker container.
CREW_LIB_SUFFIX = ARCH.eql?('x86_64') && Dir.exist?('/lib64') ? '64' : ''
ARCH_LIB        = "lib#{CREW_LIB_SUFFIX}"

# Glibc version can be found from the output of libc.so.6
LIBC_VERSION = `/#{ARCH_LIB}/libc.so.6`[/Gentoo ([^-]+)/, 1]

CREW_PREFIX = ENV.fetch('CREW_PREFIX', '/usr/local')

if CREW_PREFIX == '/usr/local'
  CREW_BUILD_FROM_SOURCE = ENV.fetch('CREW_BUILD_FROM_SOURCE', '0').eql?('1')
  HOME = Dir.home
else
  CREW_BUILD_FROM_SOURCE = true
  HOME = File.join(CREW_PREFIX, Dir.home)
end

CREW_ESSENTIAL_PACKAGES = %w[gcc_lib glibc gmp ruby zlibpkg zstd]

CREW_IN_CONTAINER = File.exist?('/.dockerenv') || ENV.fetch('CREW_IN_CONTAINER', '0').eql?('1')

CREW_CPU_VENDOR = CPUINFO['vendor_id'] || 'unknown'
# The cpuinfo vendor_id may not exist on non-x86 platforms, or when a
# container is virtualized on non-x86 platforms. Default to
# CREW_IS_INTEL for x86 architectures. Note that a QEMU_EMULATED check
# is not relevant here since qemu can be configured to pass through a
# cpuinfo vendor_id.
CREW_IS_AMD   = CREW_CPU_VENDOR.eql?('AuthenticAMD')
CREW_IS_INTEL = %w[x86_64 i686].include?(ARCH) && %w[unknown GenuineIntel].include?(CREW_CPU_VENDOR)

# Use sane minimal defaults if in container and no override specified.
CREW_KERNEL_VERSION = if CREW_IN_CONTAINER && ENV['CREW_KERNEL_VERSION'].nil?
                        case ARCH
                        when 'i686'
                          '3.8'
                        else
                          '5.10'
                        end
                      else
                        ENV.fetch('CREW_KERNEL_VERSION', `uname -r`.rpartition('.')[0])
                      end

CREW_LIB_PREFIX       = File.join(CREW_PREFIX, ARCH_LIB)
CREW_MAN_PREFIX       = File.join(CREW_PREFIX, 'share/man')
CREW_LIB_PATH         = File.join(CREW_PREFIX, 'lib/crew')
CREW_PACKAGES_PATH    = File.join(CREW_LIB_PATH, 'packages')
CREW_CONFIG_PATH      = File.join(CREW_PREFIX, 'etc/crew')
CREW_META_PATH        = File.join(CREW_CONFIG_PATH, 'meta')
CREW_BREW_DIR         = File.join(CREW_PREFIX, 'tmp/crew')
CREW_DEST_DIR         = File.join(CREW_BREW_DIR, 'dest')
CREW_WINE_PREFIX      = File.join(CREW_LIB_PREFIX, 'wine')
CREW_DEST_PREFIX      = File.join(CREW_DEST_DIR, CREW_PREFIX)
CREW_DEST_LIB_PREFIX  = File.join(CREW_DEST_DIR, CREW_LIB_PREFIX)
CREW_DEST_WINE_PREFIX = File.join(CREW_DEST_PREFIX, CREW_WINE_PREFIX)
CREW_DEST_MAN_PREFIX  = File.join(CREW_DEST_DIR, CREW_MAN_PREFIX)

# Local constants for contributors.
CREW_LOCAL_REPO_ROOT = `git rev-parse --show-toplevel 2> /dev/null`.chomp
CREW_LOCAL_BUILD_DIR = "#{CREW_LOCAL_REPO_ROOT}/release/#{ARCH}"

# The following is used in fixup.rb to determine if crew update needs to
# be run again.
CREW_CONST_GIT_COMMIT = `cd #{CREW_LIB_PATH} && git log -n1 --oneline #{CREW_LIB_PATH}/lib/const.rb`.split.first

# Put musl build dir under CREW_PREFIX/share/musl to avoid FHS incompatibility
CREW_MUSL_PREFIX      = File.join(CREW_PREFIX, '/share/musl/')
CREW_DEST_MUSL_PREFIX = File.join(CREW_DEST_DIR, CREW_MUSL_PREFIX)
MUSL_LIBC_VERSION     = `[ -x '#{CREW_MUSL_PREFIX}/lib/libc.so' ] && #{CREW_MUSL_PREFIX}/lib/libc.so 2>&1`[/\bVersion\s+\K\S+/]

CREW_DEST_HOME          = File.join(CREW_DEST_DIR, HOME)
CREW_CACHE_DIR          = ENV.fetch('CREW_CACHE_DIR', "#{HOME}/.cache/crewcache")
CREW_CACHE_BUILD        = ENV.fetch('CREW_CACHE_BUILD', '0').eql?('1')
CREW_CACHE_FAILED_BUILD = ENV.fetch('CREW_CACHE_FAILED_BUILD', '0').eql?('1')

# Set CREW_NPROC from environment variable, `distcc -j`, or `nproc`.
if File.file?("#{CREW_PREFIX}/bin/distcc")
  CREW_NPROC = ENV.fetch('CREW_NPROC', `distcc -j`.chomp)
else
  CREW_NPROC = ENV.fetch('CREW_NPROC', `nproc`.chomp)
end

# Set following as boolean if environment variables exist.
CREW_CACHE_ENABLED                   = ENV.fetch('CREW_CACHE_ENABLED', '0').eql?('1')
CREW_CONFLICTS_ONLY_ADVISORY         = ENV.fetch('CREW_CONFLICTS_ONLY_ADVISORY', '0').eql?('1')         # or use conflicts_ok
CREW_DISABLE_ENV_OPTIONS             = ENV.fetch('CREW_DISABLE_ENV_OPTIONS', '0').eql?('1')             # or use no_env_options
CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY = ENV.fetch('CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY', '0').eql?('1') # or use no_fhs
CREW_NOT_COMPRESS                    = ENV.fetch('CREW_NOT_COMPRESS', '0').eql?('1')                    # or use no_compress
CREW_NOT_LINKS                       = ENV.fetch('CREW_NOT_LINKS', '0').eql?('1')                       # or use no_links
CREW_NOT_STRIP                       = ENV.fetch('CREW_NOT_STRIP', '0').eql?('1')                       # or use no_strip
CREW_NOT_SHRINK_ARCHIVE              = ENV.fetch('CREW_NOT_SHRINK_ARCHIVE', '0').eql?('1')              # or use no_shrink

# Allow git constants to be set from environment variables (for testing)
CREW_REPO   = ENV.fetch('CREW_REPO', 'https://github.com/chromebrew/chromebrew.git')
CREW_BRANCH = ENV.fetch('CREW_BRANCH', 'master')

USER = `whoami`.chomp

CHROMEOS_RELEASE = if File.exist?('/etc/lsb-release')
                     File.read('/etc/lsb-release')[/CHROMEOS_RELEASE_CHROME_MILESTONE=(.+)/, 1]
                   else
                     # newer version of Chrome OS exports info to env by default
                     ENV.fetch('CHROMEOS_RELEASE_CHROME_MILESTONE', nil)
                   end

# If CREW_DISABLE_MVDIR environment variable exists and is equal to 1 use rsync/tar to install files in lieu of crew-mvdir.
CREW_DISABLE_MVDIR = ENV.fetch('CREW_DISABLE_MVDIR', '0').eql?('1')

# If CREW_USE_CURL environment variable exists use curl in lieu of net/http.
CREW_USE_CURL = ENV.fetch('CREW_USE_CURL', '0').eql?('1')

# Use an external downloader instead of net/http if CREW_DOWNLOADER is set, see lib/downloader.rb for more info
# About the format of the CREW_DOWNLOADER variable, see line 130-133 in lib/downloader.rb
CREW_DOWNLOADER = ENV.fetch('CREW_DOWNLOADER', nil)

# Downloader maximum retry count
CREW_DOWNLOADER_RETRY = ENV.fetch('CREW_DOWNLOADER_RETRY', 3).to_i

# show download progress bar or not (only applied when using the default ruby downloader)
CREW_HIDE_PROGBAR = ENV.fetch('CREW_HIDE_PROGBAR', '0').eql?('1')

# set certificate file location for lib/downloader.rb
SSL_CERT_FILE = if ENV['SSL_CERT_FILE'] && File.exist?(ENV['SSL_CERT_FILE'])
                  ENV['SSL_CERT_FILE']
                elsif File.exist?("#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt")
                  "#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt"
                else
                  '/etc/ssl/certs/ca-certificates.crt'
                end
SSL_CERT_DIR = if ENV['SSL_CERT_DIR'] && Dir.exist?(ENV['SSL_CERT_DIR'])
                 ENV['SSL_CERT_DIR']
               elsif Dir.exist?("#{CREW_PREFIX}/etc/ssl/certs")
                 "#{CREW_PREFIX}/etc/ssl/certs"
               else
                 '/etc/ssl/certs'
               end

CREW_ARCH_FLAGS_OVERRIDE = ENV.fetch('CREW_ARCH_FLAGS_OVERRIDE', '')
case ARCH
when 'aarch64', 'armv7l'
  CREW_TGT = 'armv7l-cros-linux-gnueabihf'
  CREW_BUILD = 'armv7l-cros-linux-gnueabihf'
  # These settings have been selected to match debian armhf.
  # Using -mfpu=neon breaks builds such as webkit2gtk.
  CREW_ARCH_FLAGS = CREW_ARCH_FLAGS_OVERRIDE.to_s.empty? ? '-mfloat-abi=hard -mthumb -mfpu=vfpv3-d16 -march=armv7-a+fp' : CREW_ARCH_FLAGS_OVERRIDE
when 'i686'
  CREW_TGT = 'i686-cros-linux-gnu'
  CREW_BUILD = 'i686-cros-linux-gnu'
  CREW_ARCH_FLAGS = CREW_ARCH_FLAGS_OVERRIDE.to_s.empty? ? '' : CREW_ARCH_FLAGS_OVERRIDE
when 'x86_64'
  CREW_TGT = 'x86_64-cros-linux-gnu'
  CREW_BUILD = 'x86_64-cros-linux-gnu'
  CREW_ARCH_FLAGS = CREW_ARCH_FLAGS_OVERRIDE.to_s.empty? ? '' : CREW_ARCH_FLAGS_OVERRIDE
end

CREW_LINKER       = ENV.fetch('CREW_LINKER', 'mold')
CREW_LINKER_FLAGS = ENV.fetch('CREW_LINKER_FLAGS', '')

CREW_CORE_FLAGS           = "-O2 -pipe -ffat-lto-objects -fPIC #{CREW_ARCH_FLAGS} -fuse-ld=#{CREW_LINKER} #{CREW_LINKER_FLAGS}"
CREW_COMMON_FLAGS         = "#{CREW_CORE_FLAGS} -flto=auto"
CREW_COMMON_FNO_LTO_FLAGS = "#{CREW_CORE_FLAGS} -fno-lto"
CREW_LDFLAGS              = "-flto=auto #{CREW_LINKER_FLAGS}"
CREW_FNO_LTO_LDFLAGS      = '-fno-lto'

CREW_ENV_OPTIONS_HASH = if CREW_DISABLE_ENV_OPTIONS
                          { 'CREW_DISABLE_ENV_OPTIONS' => '1' }
                        else
                          {
                            'CFLAGS'          => CREW_COMMON_FLAGS,
                            'CXXFLAGS'        => CREW_COMMON_FLAGS,
                            'FCFLAGS'         => CREW_COMMON_FLAGS,
                            'FFLAGS'          => CREW_COMMON_FLAGS,
                            'LD_LIBRARY_PATH' => CREW_LIB_PREFIX,
                            'LDFLAGS'         => CREW_LDFLAGS
                          }
                        end
# parse from hash to shell readable string
CREW_ENV_OPTIONS = CREW_ENV_OPTIONS_HASH.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')

CREW_ENV_FNO_LTO_OPTIONS_HASH = {
  'CFLAGS'          => CREW_COMMON_FNO_LTO_FLAGS,
  'CXXFLAGS'        => CREW_COMMON_FNO_LTO_FLAGS,
  'FCFLAGS'         => CREW_COMMON_FNO_LTO_FLAGS,
  'FFLAGS'          => CREW_COMMON_FNO_LTO_FLAGS,
  'LD_LIBRARY_PATH' => CREW_LIB_PREFIX,
  'LDFLAGS'         => CREW_FNO_LTO_LDFLAGS
}
# parse from hash to shell readable string
CREW_ENV_FNO_LTO_OPTIONS = CREW_ENV_FNO_LTO_OPTIONS_HASH.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')

CREW_OPTIONS = <<~OPT.chomp
  --prefix=#{CREW_PREFIX} \
  --libdir=#{CREW_LIB_PREFIX} \
  --mandir=#{CREW_MAN_PREFIX} \
  --disable-dependency-tracking \
  --build=#{CREW_BUILD} \
  --host=#{CREW_TGT} \
  --target=#{CREW_TGT} \
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
  -Dcpp_args='#{CREW_CORE_FLAGS}' \
  -Dc_args='#{CREW_CORE_FLAGS}'
OPT

CREW_MESON_FNO_LTO_OPTIONS = <<~OPT.chomp
  -Dprefix=#{CREW_PREFIX} \
  -Dlibdir=#{CREW_LIB_PREFIX} \
  -Dlocalstatedir=#{CREW_PREFIX}/var/local \
  -Dmandir=#{CREW_MAN_PREFIX} \
  -Dsharedstatedir=#{CREW_PREFIX}/var/local/lib \
  -Dbuildtype=release \
  -Db_lto=false \
  -Dstrip=true \
  -Db_pie=true \
  -Dcpp_args='#{CREW_CORE_FLAGS}' \
  -Dc_args='#{CREW_CORE_FLAGS}'
OPT

# Use ninja or samurai
CREW_NINJA = ENV.fetch('CREW_NINJA', 'ninja')

# Cmake sometimes wants to use LIB_SUFFIX to install libs in LIB64, so specify such for x86_64
# This is often considered deprecated. See discussio at https://gitlab.kitware.com/cmake/cmake/-/issues/18640
# and also https://bugzilla.redhat.com/show_bug.cgi?id=1425064
# Let's have two CREW_CMAKE_OPTIONS since this avoids the logic in the recipe file.
CREW_CMAKE_OPTIONS = <<~OPT.chomp
  -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
  -DCMAKE_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
  -DCMAKE_C_FLAGS='#{CREW_COMMON_FLAGS.gsub(/-fuse-ld=.{2,4}\s/, '')}' \
  -DCMAKE_CXX_FLAGS='#{CREW_COMMON_FLAGS.gsub(/-fuse-ld=.{2,4}\s/, '')}' \
  -DCMAKE_EXE_LINKER_FLAGS='#{CREW_LDFLAGS}' \
  -DCMAKE_LINKER_TYPE=#{CREW_LINKER.upcase} \
  -DCMAKE_SHARED_LINKER_FLAGS='#{CREW_LDFLAGS}' \
  -DCMAKE_STATIC_LINKER_FLAGS='#{CREW_LDFLAGS}' \
  -DCMAKE_MODULE_LINKER_FLAGS='#{CREW_LDFLAGS}' \
  -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=TRUE \
  -DCMAKE_BUILD_TYPE=Release
OPT
CREW_CMAKE_FNO_LTO_OPTIONS = <<~OPT.chomp
  -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
  -DCMAKE_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
  -DCMAKE_C_FLAGS='#{CREW_COMMON_FNO_LTO_FLAGS.gsub(/-fuse-ld=.{2,4}\s/, '')}' \
  -DCMAKE_CXX_FLAGS='#{CREW_COMMON_FNO_LTO_FLAGS.gsub(/-fuse-ld=.{2,4}\s/, '')}' \
  -DCMAKE_EXE_LINKER_FLAGS=#{CREW_FNO_LTO_LDFLAGS} \
  -DCMAKE_LINKER_TYPE=#{CREW_LINKER.upcase} \
  -DCMAKE_SHARED_LINKER_FLAGS=#{CREW_FNO_LTO_LDFLAGS} \
  -DCMAKE_STATIC_LINKER_FLAGS=#{CREW_FNO_LTO_LDFLAGS} \
  -DCMAKE_MODULE_LINKER_FLAGS=#{CREW_FNO_LTO_LDFLAGS} \
  -DCMAKE_BUILD_TYPE=Release
OPT

CREW_CMAKE_LIBSUFFIX_OPTIONS = "#{CREW_CMAKE_OPTIONS} -DLIB_SUFFIX=#{CREW_LIB_SUFFIX}"

PY3_SETUP_BUILD_OPTIONS          = "--executable=#{CREW_PREFIX}/bin/python3"
PY2_SETUP_BUILD_OPTIONS          = "--executable=#{CREW_PREFIX}/bin/python2"
PY_SETUP_INSTALL_OPTIONS_NO_SVEM = "--root=#{CREW_DEST_DIR} --prefix=#{CREW_PREFIX} -O2 --compile"
PY_SETUP_INSTALL_OPTIONS         = "#{PY_SETUP_INSTALL_OPTIONS_NO_SVEM} --single-version-externally-managed"
PY3_BUILD_OPTIONS                = '--wheel --no-isolation'
PY3_INSTALLER_OPTIONS            = "--destdir=#{CREW_DEST_DIR} --compile-bytecode 2 dist/*.whl"

CREW_LICENSE = <<~LICENSESTRING
  Copyright (C) 2013-2024 Chromebrew Authors

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
    crew build [options] [-k|--keep] [-v|--verbose] <name> ...
    crew check [-V|--version] [-v|--verbose] <name> ...
    crew const [-v|--verbose] [<name> ...]
    crew deps [options] [--deep] [-t|--tree] [-b|--include-build-deps] [--exclude-buildessential] [-v|--verbose] <name> ...
    crew download [options] [-s|--source] [-v|--verbose] <name> ...
    crew files <name> ...
    crew help [<command>] [-v|--verbose] [<subcommand>]
    crew install [options] [-k|--keep] [-s|--source] [-S|--recursive-build] [-v|--verbose] <name> ...
    crew list [options] [-v|--verbose] (available|installed|compatible|incompatible)
    crew postinstall [options] [-v|--verbose] <name> ...
    crew prop [<property>]
    crew reinstall [options] [-k|--keep] [-s|--source] [-S|--recursive-build] [-v|--verbose] <name> ...
    crew remove [-v|--verbose] <name> ...
    crew search [options] [-v|--verbose] [<name> ...]
    crew sysinfo [-v|--verbose]
    crew test [-v|--verbose] [<name> ...]
    crew update [options] [-v|--verbose] [<compatible>]
    crew upgrade [options] [-k|--keep] [-s|--source] [-v|--verbose] [<name> ...]
    crew upload [options] [-v|--verbose] [<name> ...]
    crew whatprovides [options] [-v|--verbose] <pattern> ...

    -b --include-build-deps  Include build dependencies in output.
    -t --tree                Print dependencies in a tree-structure format.
    -c --color               Use colors even if standard out is not a tty.
    -d --no-color            Disable colors even if standard out is a tty.
    -f --force               Force where relevant.
    -k --keep                Keep the `CREW_BREW_DIR` (#{CREW_BREW_DIR}) directory.
    -L --license             Display the crew license.
    -s --source              Build or download from source even if pre-compiled binary exists.
    -S --recursive-build     Build from source, including all dependencies, even if pre-compiled binaries exist.
    -v --verbose             Show extra information.
    -V --version             Display the crew version.
    -h --help                Show this screen.

  version #{CREW_VERSION}
DOCOPT

# All available crew commands.
CREW_COMMANDS = CREW_DOCOPT.scan(/crew ([^\s]+)/).flatten.sort.join(', ').gsub('.', '')
