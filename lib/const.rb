# Defines common constants used in different parts of crew

CREW_VERSION = '1.24.0'

ARCH_ACTUAL = `uname -m`.chomp
# This helps with virtualized builds on aarch64 machines
# which report armv8l when linux32 is run.
ARCH = ( ARCH_ACTUAL == 'armv8l' ) ? 'armv7l' : ARCH_ACTUAL

# Allow for edge case of i686 install on a x86_64 host before linux32 is
# downloaded, e.g. in a docker container.
ARCH_LIB = ( ARCH == 'x86_64' and Dir.exist?('/lib64') ) ? 'lib64' : 'lib'

# Glibc version can be found from the output of libc.so.6
LIBC_VERSION = %x[/#{ARCH_LIB}/libc.so.6][/Gentoo ([^-]+)/, 1]

unless ENV['CREW_PREFIX'].to_s.empty? or ENV['CREW_PREFIX'] == '/usr/local'
  CREW_BUILD_FROM_SOURCE = 1
  CREW_PREFIX = ENV['CREW_PREFIX']
  HOME = CREW_PREFIX + ENV['HOME']
else
  CREW_BUILD_FROM_SOURCE = ENV['CREW_BUILD_FROM_SOURCE']
  CREW_PREFIX = '/usr/local'
  HOME = ENV['HOME']
end

CREW_LIB_PREFIX = CREW_PREFIX + '/' + ARCH_LIB
CREW_MAN_PREFIX = CREW_PREFIX + '/share/man'
CREW_LIB_PATH = CREW_PREFIX + '/lib/crew/'
CREW_PACKAGES_PATH = CREW_LIB_PATH + 'packages/'
CREW_CONFIG_PATH = CREW_PREFIX + '/etc/crew/'
CREW_META_PATH = CREW_CONFIG_PATH + 'meta/'
CREW_BREW_DIR = CREW_PREFIX + '/tmp/crew/'
CREW_DEST_DIR = CREW_BREW_DIR + 'dest'
CREW_DEST_PREFIX = CREW_DEST_DIR + CREW_PREFIX
CREW_DEST_LIB_PREFIX = CREW_DEST_DIR + CREW_LIB_PREFIX
CREW_DEST_MAN_PREFIX = CREW_DEST_DIR + CREW_MAN_PREFIX

# Put musl build dir under CREW_PREFIX/share/musl to avoid FHS incompatibility
CREW_MUSL_PREFIX = CREW_PREFIX + '/share/musl'
CREW_DEST_MUSL_PREFIX = CREW_DEST_DIR + CREW_MUSL_PREFIX
MUSL_LIBC_VERSION = %x[#{CREW_MUSL_PREFIX}/lib/libc.so 2>&1 >/dev/null][/\bVersion\s+\K\S+/] || nil

CREW_DEST_HOME = CREW_DEST_DIR + HOME

# File.join ensures a trailing slash if one does not exist.
if ENV['CREW_CACHE_DIR'].to_s.empty?
  CREW_CACHE_DIR = File.join(HOME + '/.cache/crewcache', '')
else
  CREW_CACHE_DIR = File.join(ENV['CREW_CACHE_DIR'], '')
end

FileUtils.mkdir_p CREW_CACHE_DIR unless Dir.exist?(CREW_CACHE_DIR)

# Set CREW_NPROC from environment variable or `nproc`
CREW_NPROC = ( ENV['CREW_NPROC'].to_s.empty? ) ? `nproc`.chomp : ENV['CREW_NPROC']

# Set following as boolean if environment variables exist.
CREW_CACHE_ENABLED = !( ENV['CREW_CACHE_ENABLED'].to_s.empty? )
CREW_CONFLICTS_ONLY_ADVISORY = !( ENV['CREW_CONFLICTS_ONLY_ADVISORY'].to_s.empty? ) # or use conflicts_ok
CREW_DISABLE_ENV_OPTIONS = !( ENV['CREW_DISABLE_ENV_OPTIONS'].to_s.empty? ) # or use no_env_options
CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY = !( ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY'].to_s.empty? ) # or use no_fhs
CREW_LA_RENAME_ENABLED = !( ENV['CREW_LA_RENAME_ENABLED'].to_s.empty? )
CREW_NOT_COMPRESS = !( ENV['CREW_NOT_COMPRESS'].to_s.empty? )
CREW_NOT_STRIP = !( ENV['CREW_NOT_STRIP'].to_s.empty? )
CREW_NOT_SHRINK_ARCHIVE = !( ENV['CREW_NOT_SHRINK_ARCHIVE'].to_s.empty? )

# Set testing constants from environment variables
CREW_TESTING_BRANCH = ENV['CREW_TESTING_BRANCH']
CREW_TESTING_REPO = ENV['CREW_TESTING_REPO']

CREW_TESTING = ( CREW_TESTING_BRANCH.to_s.empty? or CREW_TESTING_REPO.to_s.empty? ) ? '0' : ENV['CREW_TESTING']

USER = `whoami`.chomp

CHROMEOS_RELEASE = if File.exist?('/etc/lsb-release')
  File.read('/etc/lsb-release')[/CHROMEOS_RELEASE_CHROME_MILESTONE=(.+)/, 1]
else
  # newer version of Chrome OS exports info to env by default
  ENV['CHROMEOS_RELEASE_CHROME_MILESTONE']
end

# If CREW_USE_CURL environment variable exists use curl in lieu of net/http.
CREW_USE_CURL = ENV['CREW_USE_CURL'].eql?('1')

# Use an external downloader instead of net/http if CREW_DOWNLOADER is set, see lib/downloader.rb for more info
# About the format of the CREW_DOWNLOADER variable, see line 130-133 in lib/downloader.rb
CREW_DOWNLOADER = ( ENV['CREW_DOWNLOADER'].to_s.empty? ) ? nil : ENV['CREW_DOWNLOADER']

# Downloader maximum retry count
CREW_DOWNLOADER_RETRY = ( ENV['CREW_DOWNLOADER_RETRY'].to_s.empty? ) ? 3 : ENV['CREW_DOWNLOADER_RETRY'].to_i
# show download progress bar or not (only applied when using the default ruby downloader)
CREW_HIDE_PROGBAR = ENV['CREW_HIDE_PROGBAR'].eql?('1')

# set certificate file location for lib/downloader.rb
SSL_CERT_FILE = if ENV['SSL_CERT_FILE'].to_s.empty? || !File.exist?(ENV['SSL_CERT_FILE'])
                  if File.exist?("#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt")
                    "#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt"
                  else
                    '/etc/ssl/certs/ca-certificates.crt'
                  end
                else
                  ENV['SSL_CERT_FILE']
                end
SSL_CERT_DIR = if ENV['SSL_CERT_DIR'].to_s.empty? || !Dir.exist?(ENV['SSL_CERT_DIR'])
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
when 'i686'
  CREW_TGT = 'i686-cros-linux-gnu'
  CREW_BUILD = 'i686-cros-linux-gnu'
when 'x86_64'
  CREW_TGT = 'x86_64-cros-linux-gnu'
  CREW_BUILD = 'x86_64-cros-linux-gnu'
end

if ENV['CREW_LINKER'].to_s.empty?
  CREW_LINKER = 'mold'
else
  CREW_LINKER = ENV['CREW_LINKER']
end
CREW_LINKER_FLAGS = ENV['CREW_LINKER_FLAGS']

CREW_COMMON_FLAGS = "-O2 -pipe -flto -ffat-lto-objects -fPIC -fuse-ld=#{CREW_LINKER} #{CREW_LINKER_FLAGS}"
CREW_COMMON_FNO_LTO_FLAGS = "-O2 -pipe -fno-lto -fPIC -fuse-ld=#{CREW_LINKER} #{CREW_LINKER_FLAGS}"
CREW_LDFLAGS = "-flto #{CREW_LINKER_FLAGS}"
CREW_FNO_LTO_LDFLAGS = '-fno-lto'

unless CREW_DISABLE_ENV_OPTIONS
  CREW_ENV_OPTIONS_HASH = {
    'CFLAGS'   => CREW_COMMON_FLAGS,
    'CXXFLAGS' => CREW_COMMON_FLAGS,
    'FCFLAGS'  => CREW_COMMON_FLAGS,
    'FFLAGS'   => CREW_COMMON_FLAGS,
    'LDFLAGS'  => CREW_LDFLAGS
  }
else
  CREW_ENV_OPTIONS_HASH = { "CREW_DISABLE_ENV_OPTIONS" => '1' }
end
# parse from hash to shell readable string
CREW_ENV_OPTIONS = CREW_ENV_OPTIONS_HASH.map {|k, v| "#{k}=\"#{v}\"" } .join(' ')

CREW_ENV_FNO_LTO_OPTIONS_HASH = {
  'CFLAGS'   => CREW_COMMON_FNO_LTO_FLAGS,
  'CXXFLAGS' => CREW_COMMON_FNO_LTO_FLAGS,
  'FCFLAGS'  => CREW_COMMON_FNO_LTO_FLAGS,
  'FFLAGS'   => CREW_COMMON_FNO_LTO_FLAGS,
  'LDFLAGS'  => CREW_FNO_LTO_LDFLAGS
}
# parse from hash to shell readable string
CREW_ENV_FNO_LTO_OPTIONS = CREW_ENV_FNO_LTO_OPTIONS_HASH.map {|k, v| "#{k}=\"#{v}\"" } .join(' ')

CREW_OPTIONS = <<~OPT.chomp
  --prefix=#{CREW_PREFIX} \
  --libdir=#{CREW_LIB_PREFIX} \
  --mandir=#{CREW_MAN_PREFIX} \
  --build=#{CREW_BUILD} \
  --host=#{CREW_TGT} \
  --target=#{CREW_TGT} \
  --program-prefix='' \
  --program-suffix=''
OPT

CREW_MESON_OPTIONS = <<~OPT.chomp
  -Dprefix=#{CREW_PREFIX} \
  -Dlibdir=#{CREW_LIB_PREFIX} \
  -Dmandir=#{CREW_MAN_PREFIX} \
  -Dbuildtype=release \
  -Db_lto=true \
  -Dstrip=true \
  -Db_pie=true \
  -Dcpp_args='-O2' \
  -Dc_args='-O2'
OPT

CREW_MESON_FNO_LTO_OPTIONS = <<~OPT.chomp
  -Dprefix=#{CREW_PREFIX} \
  -Dlibdir=#{CREW_LIB_PREFIX} \
  -Dmandir=#{CREW_MAN_PREFIX} \
  -Dbuildtype=release \
  -Db_lto=false \
  -Dstrip=true \
  -Db_pie=true \
  -Dcpp_args='-O2' \
  -Dc_args='-O2'
OPT

# Use ninja or samurai
if ENV['CREW_NINJA'].to_s.downcase == 'ninja'
  CREW_NINJA = 'ninja'
else
  CREW_NINJA = 'samu'
end

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

CREW_LIB_SUFFIX = ( ARCH == 'x86_64' ) ? '64' : ''
CREW_CMAKE_LIBSUFFIX_OPTIONS = "#{CREW_CMAKE_OPTIONS} -DLIB_SUFFIX=#{CREW_LIB_SUFFIX}"

PY3_SETUP_BUILD_OPTIONS = "--executable=#{CREW_PREFIX}/bin/python3"
PY2_SETUP_BUILD_OPTIONS = "--executable=#{CREW_PREFIX}/bin/python2"
PY_SETUP_INSTALL_OPTIONS_NO_SVEM = "--root=#{CREW_DEST_DIR} --prefix=#{CREW_PREFIX} -O2 --compile"
PY_SETUP_INSTALL_OPTIONS = "#{PY_SETUP_INSTALL_OPTIONS_NO_SVEM} --single-version-externally-managed"
PY3_BUILD_OPTIONS = "--wheel --no-isolation"
PY3_INSTALLER_OPTIONS = "--destdir=#{CREW_DEST_DIR} --compile-bytecode 2 dist/*.whl"

CREW_ESSENTIAL_FILES = `LD_TRACE_LOADED_OBJECTS=1 #{CREW_PREFIX}/bin/ruby`.scan(/\t([^ ]+)/).flatten +
                       `LD_TRACE_LOADED_OBJECTS=1 #{CREW_PREFIX}/bin/rsync`.scan(/\t([^ ]+)/).flatten +
                       %w[libzstd.so.1 libstdc++.so.6]
CREW_ESSENTIAL_FILES.uniq!
