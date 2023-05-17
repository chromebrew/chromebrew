# Defines common constants used in different parts of crew

CREW_VERSION = '1.33.6'

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

# Allow for edge case of i686 install on a x86_64 host before linux32 is
# downloaded, e.g. in a docker container.
ARCH_LIB = ARCH.eql?('x86_64') && Dir.exist?('/lib64') ? 'lib64' : 'lib'

# Glibc version can be found from the output of libc.so.6
LIBC_VERSION = `/#{ARCH_LIB}/libc.so.6`[/Gentoo ([^-]+)/, 1]

if ENV['CREW_PREFIX'].to_s.empty? || (ENV['CREW_PREFIX'] == '/usr/local')
  CREW_BUILD_FROM_SOURCE = ENV.fetch('CREW_BUILD_FROM_SOURCE', nil)
  CREW_PREFIX = '/usr/local'
  HOME = Dir.home
else
  CREW_BUILD_FROM_SOURCE = 1
  CREW_PREFIX = ENV.fetch('CREW_PREFIX', nil)
  HOME = CREW_PREFIX + Dir.home
end

CREW_IN_CONTAINER = File.exist?('/.dockerenv') || !ENV['CREW_IN_CONTAINER'].to_s.empty?

CREW_CPU_VENDOR = CPUINFO['vendor_id'] || 'unknown'
# vendor_id may not exist on non-x86 platforms.
CREW_IS_AMD = ARCH == 'x86_64' ? CPUINFO['vendor_id'].include?('AuthenticAMD') : false
CREW_IS_INTEL = ARCH == 'x86_64' || ARCH == 'i686' ? CPUINFO['vendor_id'].include?('GenuineIntel') : false

# Use sane minimal defaults if in container and no override specified.
if CREW_IN_CONTAINER && ENV['CREW_KERNEL_VERSION'].to_s.empty?
  case ARCH
  when 'i686'
    CREW_KERNEL_VERSION = '3.8'
  when 'aarch64', 'armv7l'
    CREW_KERNEL_VERSION = '4.14'
  when 'x86_64'
    CREW_KERNEL_VERSION = '4.14'
  end
else
  CREW_KERNEL_VERSION = ENV.fetch('CREW_KERNEL_VERSION', `uname -r`.rpartition('.')[0])
end

CREW_LIB_PREFIX = "#{CREW_PREFIX}/#{ARCH_LIB}"
CREW_MAN_PREFIX = "#{CREW_PREFIX}/share/man"
CREW_LIB_PATH = "#{CREW_PREFIX}/lib/crew/"
CREW_PACKAGES_PATH = "#{CREW_LIB_PATH}packages/"
CREW_CONFIG_PATH = "#{CREW_PREFIX}/etc/crew/"
CREW_META_PATH = "#{CREW_CONFIG_PATH}meta/"
CREW_BREW_DIR = "#{CREW_PREFIX}/tmp/crew/"
CREW_DEST_DIR = "#{CREW_BREW_DIR}dest"
CREW_DLL_PREFIX = "#{CREW_LIB_PREFIX}/wine"
CREW_DEST_PREFIX = CREW_DEST_DIR + CREW_PREFIX
CREW_DEST_LIB_PREFIX = CREW_DEST_DIR + CREW_LIB_PREFIX
CREW_DEST_DLL_PREFIX = CREW_DEST_PREFIX + CREW_DLL_PREFIX
CREW_DEST_MAN_PREFIX = CREW_DEST_DIR + CREW_MAN_PREFIX

# GitHub constants.
CREW_GITHUB_ACCOUNT = 'chromebrew'
CREW_GITHUB_BRANCH = 'master'
CREW_GITHUB_REPO = 'https://github.com/chromebrew/chromebrew.git'

# Local constants for contributors.
repo_root = `git rev-parse --show-toplevel 2> /dev/null`.chomp.to_s
if repo_root.empty? || File.basename(repo_root) != 'chromebrew'
  Dir.chdir '../..' do
    repo_root = `git rev-parse --show-toplevel 2> /dev/null`.chomp.to_s
  end
end
CREW_LOCAL_REPO_ROOT = repo_root
CREW_LOCAL_REPO_BASE = CREW_LOCAL_REPO_ROOT.empty? ? '' : File.basename(CREW_LOCAL_REPO_ROOT)
CREW_LOCAL_MANIFEST_PATH = if ENV['CREW_LOCAL_MANIFEST_PATH'].to_s.empty?
                             CREW_LOCAL_REPO_BASE == CREW_GITHUB_ACCOUNT ? "#{CREW_LOCAL_REPO_ROOT}/manifest" : ''
                           else
                             ENV.fetch('CREW_LOCAL_MANIFEST_PATH', nil)
                           end

# Put musl build dir under CREW_PREFIX/share/musl to avoid FHS incompatibility
CREW_MUSL_PREFIX = "#{CREW_PREFIX}/share/musl"
CREW_DEST_MUSL_PREFIX = CREW_DEST_DIR + CREW_MUSL_PREFIX
MUSL_LIBC_VERSION = `#{CREW_MUSL_PREFIX}/lib/libc.so 2>&1 >/dev/null`[/\bVersion\s+\K\S+/] || nil

CREW_DEST_HOME = CREW_DEST_DIR + HOME

# File.join ensures a trailing slash if one does not exist.
CREW_CACHE_DIR = if ENV['CREW_CACHE_DIR'].to_s.empty?
                   File.join("#{HOME}/.cache/crewcache", '')
                 else
                   File.join(ENV.fetch('CREW_CACHE_DIR', nil), '')
                 end

CREW_MANIFEST_CACHE_DIR = "#{CREW_CACHE_DIR}manifest"
begin
  FileUtils.mkdir_p CREW_MANIFEST_CACHE_DIR
rescue Errno::EROFS => e
  # r/o fs
  puts "Error creating CREW_MANIFEST_CACHE_DIR: #{CREW_MANIFEST_CACHE_DIR}".lightred
  puts e.message.to_s.orange
rescue Errno::EACCES => e
  # no write access
  puts "Error creating CREW_MANIFEST_CACHE_DIR: #{CREW_MANIFEST_CACHE_DIR}".lightred
  puts e.message.to_s.orange
rescue Errno::ENOENT => e
  # weird fs e.g., /proc
  puts "Error creating CREW_MANIFEST_CACHE_DIR: #{CREW_MANIFEST_CACHE_DIR}".lightred
  puts e.message.to_s.orange
end
CREW_CACHE_BUILD = ENV.fetch('CREW_CACHE_BUILD', nil)
CREW_CACHE_FAILED_BUILD = ENV.fetch('CREW_CACHE_FAILED_BUILD', nil)

# Set CREW_NPROC from environment variable or `nproc`
CREW_NPROC = ENV['CREW_NPROC'].to_s.empty? ? `nproc`.chomp : ENV.fetch('CREW_NPROC', nil)

# Set following as boolean if environment variables exist.
CREW_CACHE_ENABLED = !ENV['CREW_CACHE_ENABLED'].to_s.empty?
CREW_CONFLICTS_ONLY_ADVISORY = !ENV['CREW_CONFLICTS_ONLY_ADVISORY'].to_s.empty? # or use conflicts_ok
CREW_DISABLE_ENV_OPTIONS = !ENV['CREW_DISABLE_ENV_OPTIONS'].to_s.empty? # or use no_env_options
CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY = !ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY'].to_s.empty? # or use no_fhs
CREW_NOT_COMPRESS = !ENV['CREW_NOT_COMPRESS'].to_s.empty? # or use no_compress
CREW_NOT_LINKS = !ENV['CREW_NOT_LINKS'].to_s.empty? # or use no_links
CREW_NOT_STRIP = !ENV['CREW_NOT_STRIP'].to_s.empty? # or use no_strip
CREW_NOT_SHRINK_ARCHIVE = !ENV['CREW_NOT_SHRINK_ARCHIVE'].to_s.empty? # or use no_shrink

# Set testing constants from environment variables
CREW_TESTING_REPO = ENV.fetch('CREW_TESTING_REPO', nil)
if CREW_TESTING_REPO
  CREW_TESTING_ACCOUNT = if CREW_TESTING_REPO.downcase.include?('https://github.com')
                           CREW_TESTING_REPO.to_s.downcase.gsub('https://github.com/', '').gsub('/chromebrew.git', '')
                         else
                           ENV.fetch('CREW_TESTING_ACCOUNT', nil)
                         end
end
CREW_TESTING_BRANCH = ENV.fetch('CREW_TESTING_BRANCH', nil)

CREW_TESTING = CREW_TESTING_BRANCH.to_s.empty? || CREW_TESTING_REPO.to_s.empty? ? '0' : ENV.fetch('CREW_TESTING', nil)

USER = `whoami`.chomp

CHROMEOS_RELEASE = if File.exist?('/etc/lsb-release')
                     File.read('/etc/lsb-release')[/CHROMEOS_RELEASE_CHROME_MILESTONE=(.+)/, 1]
                   else
                     # newer version of Chrome OS exports info to env by default
                     ENV.fetch('CHROMEOS_RELEASE_CHROME_MILESTONE', nil)
                   end

# If CREW_DISABLE_MVDIR environment variable exists and is equal to 1 use rsync/tar to install files in lieu of crew-mvdir.
CREW_DISABLE_MVDIR = ENV['CREW_DISABLE_MVDIR'] != '0'

# If CREW_USE_CURL environment variable exists use curl in lieu of net/http.
CREW_USE_CURL = ENV['CREW_USE_CURL'].eql?('1')

# Use an external downloader instead of net/http if CREW_DOWNLOADER is set, see lib/downloader.rb for more info
# About the format of the CREW_DOWNLOADER variable, see line 130-133 in lib/downloader.rb
CREW_DOWNLOADER = ENV['CREW_DOWNLOADER'].to_s.empty? ? nil : ENV.fetch('CREW_DOWNLOADER', nil)

# Downloader maximum retry count
CREW_DOWNLOADER_RETRY = ENV['CREW_DOWNLOADER_RETRY'].to_s.empty? ? 3 : ENV['CREW_DOWNLOADER_RETRY'].to_i
# show download progress bar or not (only applied when using the default ruby downloader)
CREW_HIDE_PROGBAR = ENV['CREW_HIDE_PROGBAR'].eql?('1')

# set certificate file location for lib/downloader.rb
SSL_CERT_FILE = if ENV['SSL_CERT_FILE'].to_s.empty? || !File.exist?(ENV.fetch('SSL_CERT_FILE', nil))
                  if File.exist?("#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt")
                    "#{CREW_PREFIX}/etc/ssl/certs/ca-certificates.crt"
                  else
                    '/etc/ssl/certs/ca-certificates.crt'
                  end
                else
                  ENV.fetch('SSL_CERT_FILE', nil)
                end
SSL_CERT_DIR = if ENV['SSL_CERT_DIR'].to_s.empty? || !Dir.exist?(ENV.fetch('SSL_CERT_DIR', nil))
                 if Dir.exist?("#{CREW_PREFIX}/etc/ssl/certs")
                   "#{CREW_PREFIX}/etc/ssl/certs"
                 else
                   '/etc/ssl/certs'
                 end
               else
                 ENV.fetch('SSL_CERT_DIR', nil)
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

CREW_LINKER = if ENV['CREW_LINKER'].to_s.empty?
                'mold'
              else
                ENV.fetch('CREW_LINKER', nil)
              end
CREW_LINKER_FLAGS = ENV.fetch('CREW_LINKER_FLAGS', nil)

CREW_CORE_FLAGS = "-O2 -pipe -ffat-lto-objects -fPIC #{CREW_ARCH_FLAGS} -fuse-ld=#{CREW_LINKER} #{CREW_LINKER_FLAGS}"
CREW_COMMON_FLAGS = "#{CREW_CORE_FLAGS} -flto=auto"
CREW_COMMON_FNO_LTO_FLAGS = "#{CREW_CORE_FLAGS} -fno-lto"
CREW_LDFLAGS = "-flto=auto #{CREW_LINKER_FLAGS}"
CREW_FNO_LTO_LDFLAGS = '-fno-lto'

CREW_ENV_OPTIONS_HASH = if CREW_DISABLE_ENV_OPTIONS
                          { 'CREW_DISABLE_ENV_OPTIONS' => '1' }
                        else
                          {
                            'CFLAGS'   => CREW_COMMON_FLAGS,
                            'CXXFLAGS' => CREW_COMMON_FLAGS,
                            'FCFLAGS'  => CREW_COMMON_FLAGS,
                            'FFLAGS'   => CREW_COMMON_FLAGS,
                            'LDFLAGS'  => CREW_LDFLAGS
                          }
                        end
# parse from hash to shell readable string
CREW_ENV_OPTIONS = CREW_ENV_OPTIONS_HASH.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')

CREW_ENV_FNO_LTO_OPTIONS_HASH = {
  'CFLAGS'   => CREW_COMMON_FNO_LTO_FLAGS,
  'CXXFLAGS' => CREW_COMMON_FNO_LTO_FLAGS,
  'FCFLAGS'  => CREW_COMMON_FNO_LTO_FLAGS,
  'FFLAGS'   => CREW_COMMON_FNO_LTO_FLAGS,
  'LDFLAGS'  => CREW_FNO_LTO_LDFLAGS
}
# parse from hash to shell readable string
CREW_ENV_FNO_LTO_OPTIONS = CREW_ENV_FNO_LTO_OPTIONS_HASH.map { |k, v| "#{k}=\"#{v}\"" }.join(' ')

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
  -Dcpp_args='#{CREW_CORE_FLAGS}' \
  -Dc_args='#{CREW_CORE_FLAGS}'
OPT

CREW_MESON_FNO_LTO_OPTIONS = <<~OPT.chomp
  -Dprefix=#{CREW_PREFIX} \
  -Dlibdir=#{CREW_LIB_PREFIX} \
  -Dmandir=#{CREW_MAN_PREFIX} \
  -Dbuildtype=release \
  -Db_lto=false \
  -Dstrip=true \
  -Db_pie=true \
  -Dcpp_args='#{CREW_CORE_FLAGS}' \
  -Dc_args='#{CREW_CORE_FLAGS}'
OPT

# Use ninja or samurai
CREW_NINJA = if ENV['CREW_NINJA'].to_s.downcase == 'ninja'
               'ninja'
             else
               'samu'
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

CREW_LIB_SUFFIX = ARCH == 'x86_64' ? '64' : ''
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
