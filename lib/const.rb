# lib/const.rb
# Defines common constants used in different parts of crew
CREW_VERSION = '1.38.7'

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

# This helps with virtualized builds on aarch64 machines
# which report armv8l when linux32 is run.
ARCH = KERN_ARCH.eql?('armv8l') ? 'armv7l' : KERN_ARCH

# This helps determine if there is a difference between kernel and user space
USER_SPACE_ARCH = ARCH.eql?('aarch64') && !Dir.exist?('/lib64') ? 'armv7l' : ARCH

# Allow for edge case of i686 install on a x86_64 host before linux32 is
# downloaded, e.g. in a docker container.
ARCH_LIB = ARCH.eql?('x86_64') && Dir.exist?('/lib64') ? 'lib64' : 'lib'

# Glibc version can be found from the output of libc.so.6
LIBC_VERSION = `/#{ARCH_LIB}/libc.so.6`[/Gentoo ([^-]+)/, 1]

CREW_PREFIX = ENV.fetch('CREW_PREFIX', '/usr/local')

if CREW_PREFIX == '/usr/local'
  CREW_BUILD_FROM_SOURCE = !!ENV['CREW_BUILD_FROM_SOURCE']&.eql?('1')
  HOME = Dir.home
else
  CREW_BUILD_FROM_SOURCE = true
  HOME = CREW_PREFIX + Dir.home
end

CREW_ARCHIVE_DEST = ENV.fetch('CREW_ARCHIVE_DEST', Dir.pwd)

CREW_IN_CONTAINER = File.exist?('/.dockerenv') || !!ENV['CREW_IN_CONTAINER']&.eql?('1')

CREW_CPU_VENDOR = CPUINFO['vendor_id'] || 'unknown'
# The cpuinfo vendor_id may not exist on non-x86 platforms, or when a
# container is virtualized on non-x86 platforms. Default to
# CREW_IS_INTEL for x86 architectures. Note that a QEMU_EMULATED check
# is not relevant here since qemu can be configured to pass through a
# cpuinfo vendor_id.
CREW_IS_AMD = CREW_CPU_VENDOR.eql?('AuthenticAMD')
CREW_IS_INTEL = %w[x86_64 i686].include?(ARCH) && %w[unknown GenuineIntel].include?(CREW_CPU_VENDOR)

# Use sane minimal defaults if in container and no override specified.
if CREW_IN_CONTAINER && ENV['CREW_KERNEL_VERSION'].nil?
  case ARCH
  when 'i686'
    CREW_KERNEL_VERSION = '3.8'
  when 'aarch64', 'armv7l'
    CREW_KERNEL_VERSION = '5.10'
  when 'x86_64'
    CREW_KERNEL_VERSION = '5.10'
  end
else
  CREW_KERNEL_VERSION = ENV.fetch('CREW_KERNEL_VERSION', `uname -r`.rpartition('.')[0])
end

CREW_LIB_PREFIX       = File.join(CREW_PREFIX, ARCH_LIB)
CREW_MAN_PREFIX       = File.join(CREW_PREFIX, 'share/man/')
CREW_LIB_PATH         = File.join(CREW_PREFIX, 'lib/crew/')
CREW_PACKAGES_PATH    = File.join(CREW_LIB_PATH, 'packages/')
CREW_CONFIG_PATH      = File.join(CREW_PREFIX, 'etc/crew/')
CREW_META_PATH        = File.join(CREW_CONFIG_PATH, 'meta/')
CREW_BREW_DIR         = File.join(CREW_PREFIX, 'tmp/crew/')
CREW_DEST_DIR         = File.join(CREW_BREW_DIR, 'dest/')
CREW_WINE_PREFIX      = File.join(CREW_LIB_PREFIX, 'wine/')
CREW_DEST_PREFIX      = File.join(CREW_DEST_DIR, CREW_PREFIX)
CREW_DEST_LIB_PREFIX  = File.join(CREW_DEST_DIR, CREW_LIB_PREFIX)
CREW_DEST_WINE_PREFIX = File.join(CREW_DEST_PREFIX, CREW_WINE_PREFIX)
CREW_DEST_MAN_PREFIX  = File.join(CREW_DEST_DIR, CREW_MAN_PREFIX)

# Local constants for contributors.
CREW_LOCAL_REPO_ROOT = `cd #{CREW_LIB_PATH} && git rev-parse --show-toplevel 2> /dev/null`.chomp

# The following is used in fixup.rb to determine if crew update needs to
# be run again.
CREW_CONST_GIT_COMMIT = `cd #{CREW_LIB_PATH} && git log -n1 --oneline #{CREW_LIB_PATH}/lib/const.rb`.split.first

CREW_LOCAL_REPO_BASE = File.basename(CREW_LOCAL_REPO_ROOT)
CREW_LOCAL_MANIFEST_PATH = ENV.fetch('CREW_LOCAL_MANIFEST_PATH', "#{CREW_LOCAL_REPO_ROOT}/manifest")

# Put musl build dir under CREW_PREFIX/share/musl to avoid FHS incompatibility
CREW_MUSL_PREFIX = "#{CREW_PREFIX}/share/musl"
CREW_DEST_MUSL_PREFIX = File.join(CREW_DEST_DIR, CREW_MUSL_PREFIX)
MUSL_LIBC_VERSION = `#{CREW_MUSL_PREFIX}/lib/libc.so 2>&1 >/dev/null`[/\bVersion\s+\K\S+/]

CREW_DEST_HOME = CREW_DEST_DIR + HOME

CREW_CACHE_DIR = ENV.fetch('CREW_CACHE_DIR', "#{HOME}/.cache/crewcache")
CREW_CACHE_BUILD = ENV['CREW_CACHE_BUILD']
CREW_CACHE_FAILED_BUILD = ENV['CREW_CACHE_FAILED_BUILD']

# Set CREW_NPROC from environment variable or `nproc`
CREW_NPROC = ENV.fetch('CREW_NPROC', `nproc`.chomp)

# Set following as boolean if environment variables exist.
CREW_CACHE_ENABLED                   = !!ENV['CREW_CACHE_ENABLED']&.eql?('1')
CREW_CONFLICTS_ONLY_ADVISORY         = !!ENV['CREW_CONFLICTS_ONLY_ADVISORY']&.eql?('1')         # or use conflicts_ok
CREW_DISABLE_ENV_OPTIONS             = !!ENV['CREW_DISABLE_ENV_OPTIONS']&.eql('1')              # or use no_env_options
CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY = !!ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY']&.eql?('1') # or use no_fhs
CREW_NOT_COMPRESS                    = !!ENV['CREW_NOT_COMPRESS']&.eql?('1')                    # or use no_compress
CREW_NOT_LINKS                       = !!ENV['CREW_NOT_LINKS']&.eql?('1')                       # or use no_links
CREW_NOT_STRIP                       = !!ENV['CREW_NOT_STRIP']&.eql?('1')                       # or use no_strip
CREW_NOT_SHRINK_ARCHIVE              = !!ENV['CREW_NOT_SHRINK_ARCHIVE']&.eql?('1')              # or use no_shrink

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
CREW_DISABLE_MVDIR = !!ENV['CREW_DISABLE_MVDIR']&.eql?('1')

# If CREW_USE_CURL environment variable exists use curl in lieu of net/http.
CREW_USE_CURL = !!ENV['CREW_USE_CURL']&.eql?('1')

# Use an external downloader instead of net/http if CREW_DOWNLOADER is set, see lib/downloader.rb for more info
# About the format of the CREW_DOWNLOADER variable, see line 130-133 in lib/downloader.rb
CREW_DOWNLOADER = ENV['CREW_DOWNLOADER']

# Downloader maximum retry count
CREW_DOWNLOADER_RETRY = ENV.fetch('CREW_DOWNLOADER_RETRY', 3).to_i
# show download progress bar or not (only applied when using the default ruby downloader)
CREW_HIDE_PROGBAR = !!ENV['CREW_HIDE_PROGBAR']&.eql?('1')

# set certificate file location for lib/downloader.rb
SSL_CERT_FILE = unless ENV['SSL_CERT_FILE'] && File.exist?(ENV['SSL_CERT_FILE'])
                  if File.exist?("#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt")
                    "#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt"
                  else
                    '/etc/ssl/certs/ca-certificates.crt'
                  end
                else
                  ENV['SSL_CERT_FILE']
                end
SSL_CERT_DIR = unless ENV['SSL_CERT_DIR'] && Dir.exist?(ENV['SSL_CERT_DIR'])
                 if Dir.exist?("#{CREW_PREFIX}/etc/ssl/certs")
                   "#{CREW_PREFIX}/etc/ssl/certs"
                 else
                   '/etc/ssl/certs'
                 end
               else
                 ENV['SSL_CERT_DIR']
               end

case ARCH
when 'aarch64', 'armv7l'
  CREW_TGT = 'armv7l-cros-linux-gnueabihf'
  CREW_BUILD = 'armv7l-cros-linux-gnueabihf'
  # These settings have been selected to match debian armhf.
  # Using -mfpu=neon breaks builds such as webkit2gtk.
  CREW_ARCH_FLAGS = '-mfloat-abi=hard -mthumb -mfpu=vfpv3-d16 -march=armv7-a+fp'
when 'i686'
  CREW_TGT = 'i686-cros-linux-gnu'
  CREW_BUILD = 'i686-cros-linux-gnu'
  CREW_ARCH_FLAGS = ''
when 'x86_64'
  CREW_TGT = 'x86_64-cros-linux-gnu'
  CREW_BUILD = 'x86_64-cros-linux-gnu'
  CREW_ARCH_FLAGS = ''
end

CREW_LINKER = ENV.fetch('CREW_LINKER', 'mold')
CREW_LINKER_FLAGS = ENV['CREW_LINKER_FLAGS']

CREW_CORE_FLAGS = "-O2 -pipe -ffat-lto-objects -fPIC #{CREW_ARCH_FLAGS} -fuse-ld=#{CREW_LINKER} #{CREW_LINKER_FLAGS}"
CREW_COMMON_FLAGS = "#{CREW_CORE_FLAGS} -flto=auto"
CREW_COMMON_FNO_LTO_FLAGS = "#{CREW_CORE_FLAGS} -fno-lto"
CREW_LDFLAGS = "-flto=auto #{CREW_LINKER_FLAGS}"
CREW_FNO_LTO_LDFLAGS = '-fno-lto'

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
  -DCMAKE_C_FLAGS='#{CREW_COMMON_FLAGS}' \
  -DCMAKE_CXX_FLAGS='#{CREW_COMMON_FLAGS}' \
  -DCMAKE_EXE_LINKER_FLAGS='#{CREW_LDFLAGS}' \
  -DCMAKE_SHARED_LINKER_FLAGS='#{CREW_LDFLAGS}' \
  -DCMAKE_STATIC_LINKER_FLAGS='#{CREW_LDFLAGS}' \
  -DCMAKE_MODULE_LINKER_FLAGS='#{CREW_LDFLAGS}' \
  -DCMAKE_INTERPROCEDURAL_OPTIMIZATION=TRUE \
  -DCMAKE_BUILD_TYPE=Release
OPT
CREW_CMAKE_FNO_LTO_OPTIONS = <<~OPT.chomp
  -DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} \
  -DCMAKE_LIBRARY_PATH=#{CREW_LIB_PREFIX} \
  -DCMAKE_C_FLAGS='#{CREW_COMMON_FNO_LTO_FLAGS}' \
  -DCMAKE_CXX_FLAGS='#{CREW_COMMON_FNO_LTO_FLAGS}' \
  -DCMAKE_EXE_LINKER_FLAGS=#{CREW_FNO_LTO_LDFLAGS} \
  -DCMAKE_SHARED_LINKER_FLAGS=#{CREW_FNO_LTO_LDFLAGS} \
  -DCMAKE_STATIC_LINKER_FLAGS=#{CREW_FNO_LTO_LDFLAGS} \
  -DCMAKE_MODULE_LINKER_FLAGS=#{CREW_FNO_LTO_LDFLAGS} \
  -DCMAKE_BUILD_TYPE=Release
OPT

CREW_LIB_SUFFIX = ARCH.eql?('x86_64') ? '64' : ''
CREW_CMAKE_LIBSUFFIX_OPTIONS = "#{CREW_CMAKE_OPTIONS} -DLIB_SUFFIX=#{CREW_LIB_SUFFIX}"

PY3_SETUP_BUILD_OPTIONS = "--executable=#{CREW_PREFIX}/bin/python3"
PY2_SETUP_BUILD_OPTIONS = "--executable=#{CREW_PREFIX}/bin/python2"
PY_SETUP_INSTALL_OPTIONS_NO_SVEM = "--root=#{CREW_DEST_DIR} --prefix=#{CREW_PREFIX} -O2 --compile"
PY_SETUP_INSTALL_OPTIONS = "#{PY_SETUP_INSTALL_OPTIONS_NO_SVEM} --single-version-externally-managed"
PY3_BUILD_OPTIONS = '--wheel --no-isolation'
PY3_INSTALLER_OPTIONS = "--destdir=#{CREW_DEST_DIR} --compile-bytecode 2 dist/*.whl"

CREW_ESSENTIAL_FILES = `LD_TRACE_LOADED_OBJECTS=1 #{CREW_PREFIX}/bin/ruby`.scan(/\t([^ ]+)/).flatten +
                       %w[libzstd.so.1 libstdc++.so.6]
CREW_ESSENTIAL_FILES.uniq!
