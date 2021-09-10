# Defines common constants used in different parts of crew

CREW_VERSION = '1.16.6'

ARCH_ACTUAL = `uname -m`.strip
# This helps with virtualized builds on aarch64 machines
# which report armv8l when linux32 is run.
ARCH = if ARCH_ACTUAL == 'armv8l' then 'armv7l' else ARCH_ACTUAL end

# Allow for edge case of i686 install on a x86_64 host before linux32 is
# downloaded, e.g. in a docker container.
ARCH_LIB = if ARCH == 'x86_64' and Dir.exist?('/lib64') then 'lib64' else 'lib' end

# Glibc version can be found from the output of libc.so.6
@libcvertokens=  %x[/#{ARCH_LIB}/libc.so.6].lines.first.chomp.split(/[\s]/)
LIBC_VERSION = @libcvertokens[@libcvertokens.find_index("version") + 1].sub!(/[[:punct:]]?$/,'')

if ENV['CREW_PREFIX'] and ENV['CREW_PREFIX'] != '' and ENV['CREW_PREFIX'] != '/usr/local'
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

CREW_DEST_HOME = CREW_DEST_DIR + HOME

# File.join ensures a trailing slash if one does not exist.
if ENV['CREW_CACHE_DIR'].to_s.empty?
  CREW_CACHE_DIR = File.join(HOME + '/.cache/crewcache', '')
else
  CREW_CACHE_DIR = File.join(ENV['CREW_CACHE_DIR'], '')
end

FileUtils.mkdir_p CREW_CACHE_DIR unless Dir.exist? CREW_CACHE_DIR

CREW_CACHE_ENABLED = ENV['CREW_CACHE_ENABLED']

CREW_CONFLICTS_ONLY_ADVISORY = ENV['CREW_CONFLICTS_ONLY_ADVISORY']

CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY = ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY']

# Set CREW_NPROC from environment variable or `nproc`
if ENV['CREW_NPROC'].to_s.empty?
  CREW_NPROC = `nproc`.strip
else
  CREW_NPROC = ENV['CREW_NPROC']
end

# Set CREW_NOT_COMPRESS from environment variable
CREW_NOT_COMPRESS = ENV['CREW_NOT_COMPRESS']

# Set CREW_NOT_STRIP from environment variable
CREW_NOT_STRIP = ENV['CREW_NOT_STRIP']

CREW_SHRINK_ARCHIVE = ENV['CREW_SHRINK_ARCHIVE']

# Set testing constants from environment variables
crew_testing_repo = ENV['CREW_TESTING_REPO']
crew_testing_branch = ENV['CREW_TESTING_BRANCH']
crew_testing = ENV['CREW_TESTING']
crew_testing = '0' if crew_testing_repo.nil? || crew_testing_repo.empty?
crew_testing = '0' if crew_testing_branch.nil? || crew_testing_branch.empty?
CREW_TESTING = crew_testing
CREW_TESTING_BRANCH = crew_testing_branch
CREW_TESTING_REPO = crew_testing_repo

CREW_USE_PIXZ = ENV['CREW_USE_PIXZ']

USER = `whoami`.chomp

CHROMEOS_RELEASE = `grep CHROMEOS_RELEASE_CHROME_MILESTONE= /etc/lsb-release | cut -d'=' -f2`.chomp

# If CURL environment variable exists use it in lieu of curl.
CURL = ENV['CURL'] || 'curl'

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

CREW_COMMON_FLAGS = '-O2 -pipe -flto -ffat-lto-objects -fPIC -fuse-ld=gold'
CREW_COMMON_FNO_LTO_FLAGS = '-O2 -pipe -fno-lto -fPIC -fuse-ld=gold'
CREW_FNO_LTO_LDFLAGS = '-fno-lto'
CREW_LDFLAGS = '-flto'

CREW_ENV_OPTIONS = "CFLAGS='#{CREW_COMMON_FLAGS}' CXXFLAGS='#{CREW_COMMON_FLAGS}' FCFLAGS='#{CREW_COMMON_FLAGS}' FFLAGS='#{CREW_COMMON_FLAGS}' LDFLAGS='#{CREW_LDFLAGS}'"
CREW_OPTIONS = "--prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --mandir=#{CREW_MAN_PREFIX} --build=#{CREW_BUILD} --host=#{CREW_TGT} --target=#{CREW_TGT} --program-prefix='' --program-suffix=''"
CREW_MESON_OPTIONS = "-Dprefix=#{CREW_PREFIX} -Dlibdir=#{CREW_LIB_PREFIX} -Dmandir=#{CREW_MAN_PREFIX} -Dbuildtype=release -Db_lto=true -Dstrip=true -Db_pie=true -Dcpp_args='-O2' -Dc_args='-O2'"
CREW_MESON_FNO_LTO_OPTIONS = "-Dprefix=#{CREW_PREFIX} -Dlibdir=#{CREW_LIB_PREFIX} -Dmandir=#{CREW_MAN_PREFIX} -Dbuildtype=release -Db_lto=false -Dstrip=true -Db_pie=true -Dcpp_args='-O2' -Dc_args='-O2'"

# Cmake sometimes wants to use LIB_SUFFIX to install libs in LIB64, so specify such for x86_64
# This is often considered deprecated. See discussio at https://gitlab.kitware.com/cmake/cmake/-/issues/18640
# and also https://bugzilla.redhat.com/show_bug.cgi?id=1425064
# Let's have two CREW_CMAKE_OPTIONS since this avoids the logic in the recipe file.
CREW_CMAKE_OPTIONS = "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_LIBRARY_PATH=#{CREW_LIB_PREFIX} -DCMAKE_C_FLAGS='#{CREW_COMMON_FLAGS}' -DCMAKE_CXX_FLAGS='#{CREW_COMMON_FLAGS}' -DCMAKE_EXE_LINKER_FLAGS='#{CREW_LDFLAGS}' -DCMAKE_SHARED_LINKER_FLAGS='#{CREW_LDFLAGS}' -DCMAKE_STATIC_LINKER_FLAGS='#{CREW_LDFLAGS}' -DCMAKE_MODULE_LINKER_FLAGS='#{CREW_LDFLAGS}' -DPROPERTY_INTERPROCEDURAL_OPTIMIZATION=TRUE -DCMAKE_BUILD_TYPE=Release"
CREW_CMAKE_FNO_LTO_OPTIONS = "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_LIBRARY_PATH=#{CREW_LIB_PREFIX} -DCMAKE_C_FLAGS='#{CREW_COMMON_FNO_LTO_FLAGS}' -DCMAKE_CXX_FLAGS='#{CREW_COMMON_FNO_LTO_FLAGS}' -DCMAKE_EXE_LINKER_FLAGS=#{CREW_FNO_LTO_LDFLAGS} -DCMAKE_SHARED_LINKER_FLAGS=#{CREW_FNO_LTO_LDFLAGS} -DCMAKE_STATIC_LINKER_FLAGS=#{CREW_FNO_LTO_LDFLAGS} -DCMAKE_MODULE_LINKER_FLAGS=#{CREW_FNO_LTO_LDFLAGS} -DCMAKE_BUILD_TYPE=Release"
CREW_LIB_SUFFIX = if ARCH == 'x86_64' then '64' else '' end
CREW_CMAKE_LIBSUFFIX_OPTIONS = "#{CREW_CMAKE_OPTIONS} -DLIB_SUFFIX=#{CREW_LIB_SUFFIX}"

PY3_SETUP_BUILD_OPTIONS = "--executable=#{CREW_PREFIX}/bin/python3"
PY2_SETUP_BUILD_OPTIONS = "--executable=#{CREW_PREFIX}/bin/python2"
PY_SETUP_INSTALL_OPTIONS_NO_SVEM = "--root=#{CREW_DEST_DIR} --prefix=#{CREW_PREFIX} -O2 --compile"
PY_SETUP_INSTALL_OPTIONS = "#{PY_SETUP_INSTALL_OPTIONS_NO_SVEM} --single-version-externally-managed"

CREW_FIRST_PACKAGES = %w[curl git pixz shared_mime_info]
CREW_LAST_PACKAGES = %w[ghc mandb gtk3 gtk4 sommelier]
