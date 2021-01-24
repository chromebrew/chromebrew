# Defines common constants used in different parts of crew

CREW_VERSION = '1.5.11'

ARCH_ACTUAL = `uname -m`.strip
# This helps with virtualized builds on aarch64 machines
# which report armv8l when linux32 is run.
ARCH = if ARCH_ACTUAL == 'armv8l' then 'armv7l' else ARCH_ACTUAL end

ARCH_LIB = if ARCH == 'x86_64' then 'lib64' else 'lib' end
LIBC_VERSION = if File.exist? "/#{ARCH_LIB}/libc-2.27.so" then '2.27' else '2.23' end

if ENV['CREW_PREFIX'].to_s == ''
  CREW_PREFIX = '/usr/local'
else
  CREW_PREFIX = ENV['CREW_PREFIX']
  @pkg.build_from_source = true
end

CREW_LIB_PREFIX = CREW_PREFIX + '/' + ARCH_LIB
CREW_MAN_PREFIX = CREW_PREFIX + '/share/man'
CREW_LIB_PATH = CREW_PREFIX + '/lib/crew/'
CREW_CONFIG_PATH = CREW_PREFIX + '/etc/crew/'
CREW_BREW_DIR = CREW_PREFIX + '/tmp/crew/'
CREW_DEST_DIR = CREW_BREW_DIR + 'dest'
CREW_DEST_PREFIX = CREW_DEST_DIR + CREW_PREFIX
CREW_DEST_LIB_PREFIX = CREW_DEST_DIR + CREW_LIB_PREFIX
CREW_DEST_MAN_PREFIX = CREW_DEST_DIR + CREW_MAN_PREFIX

if ENV['CREW_PREFIX'].to_s == ''
  HOME = ENV['HOME']
else
  HOME = CREW_PREFIX + ENV['HOME']
end

if ENV['CREW_CACHE_DIR'].to_s == ''
  CREW_CACHE_DIR = HOME + '/.cache/crewcache/'
else
  CREW_CACHE_DIR = ENV['CREW_CACHE_DIR']
end

CREW_DEST_HOME = CREW_DEST_DIR + HOME

# Set CREW_NPROC from environment variable or `nproc`
if ENV["CREW_NPROC"].to_s == ''
  CREW_NPROC = `nproc`.strip
else
  CREW_NPROC = ENV["CREW_NPROC"]
end

# Set CREW_NOT_COMPRESS from environment variable
CREW_NOT_COMPRESS = ENV["CREW_NOT_COMPRESS"]

# Set CREW_NOT_STRIP from environment variable
CREW_NOT_STRIP = ENV["CREW_NOT_STRIP"]

USER = `whoami`.chomp

CHROMEOS_RELEASE = `grep CHROMEOS_RELEASE_CHROME_MILESTONE= /etc/lsb-release | cut -d'=' -f2`.chomp

case ARCH
when 'aarch64', 'armv7l'
  CREW_BUILD = 'armv7l-cros-linux-gnueabihf'
when 'i686'
  CREW_BUILD = 'i686-cros-linux-gnu'
when 'x86_64'
  CREW_BUILD = 'x86_64-cros-linux-gnu'
end

CREW_OPTIONS = "--prefix=#{CREW_PREFIX} --libdir=#{CREW_LIB_PREFIX} --mandir=#{CREW_MAN_PREFIX} --build=#{CREW_BUILD} --host=#{CREW_BUILD} --target=#{CREW_BUILD}"
CREW_MESON_OPTIONS = "-Dprefix=#{CREW_PREFIX} -Dlibdir=#{CREW_LIB_PREFIX} -Dmandir=#{CREW_MAN_PREFIX} -Dbuildtype=release -Dc_args='-fuse-ld=lld' -Dcpp_args='-fuse-ld=lld'"
CREW_MESON_LTO_OPTIONS = "-Dprefix=#{CREW_PREFIX} -Dlibdir=#{CREW_LIB_PREFIX} -Dmandir=#{CREW_MAN_PREFIX} -Dbuildtype=release   -Dcpp_args='-flto -fuse-ld=gold' -Dcpp_link_args='-flto' -Dc_args='-flto -fuse-ld=gold' -Dc_link_args='-flto'"

# Cmake sometimes wants to use LIB_SUFFIX to install libs in LIB64, so specify such for x86_64
# This is often considered deprecated. See discussio at https://gitlab.kitware.com/cmake/cmake/-/issues/18640
# and also https://bugzilla.redhat.com/show_bug.cgi?id=1425064
# Let's have two CREW_CMAKE_OPTIONS since this avoids the logic in the recipe file.
CREW_CMAKE_OPTIONS = "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_LIBRARY_PATH=#{CREW_LIB_PREFIX} -DCMAKE_BUILD_TYPE=Release --build=#{CREW_BUILD} --host=#{CREW_BUILD} --target=#{CREW_BUILD}"
CREW_LIB_SUFFIX = if ARCH == 'x86_64' then '64' else '' end
CREW_CMAKE_LIBSUFFIX_OPTIONS = "-DCMAKE_INSTALL_PREFIX=#{CREW_PREFIX} -DCMAKE_LIBRARY_PATH=#{CREW_LIB_PREFIX} -DLIB_SUFFIX=#{CREW_LIB_SUFFIX} -DCMAKE_BUILD_TYPE=Release --build=#{CREW_BUILD} --host=#{CREW_BUILD} --target=#{CREW_BUILD}"
