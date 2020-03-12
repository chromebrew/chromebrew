# Defines common constants used in different parts of crew

CREW_VERSION = '1.3.2'

ARCH = `uname -m`.strip
ARCH_LIB = if ARCH == 'x86_64' then 'lib64' else 'lib' end
LIBC_VERSION = if File.exist? "/#{ARCH_LIB}/libc-2.27.so" then '2.27' else '2.23' end

if ENV['CREW_PREFIX'].to_s == ''
  CREW_PREFIX = '/usr/local'
else
  CREW_PREFIX = ENV['CREW_PREFIX']
  @pkg.build_from_source = true
end
CREW_LIB_PREFIX = CREW_PREFIX + '/' + ARCH_LIB

CREW_LIB_PATH = CREW_PREFIX + '/lib/crew/'
CREW_CONFIG_PATH = CREW_PREFIX + '/etc/crew/'
CREW_BREW_DIR = CREW_PREFIX + '/tmp/crew/'
CREW_DEST_DIR = CREW_BREW_DIR + 'dest'
CREW_DEST_PREFIX = CREW_DEST_DIR + CREW_PREFIX
CREW_DEST_LIB_PREFIX = CREW_DEST_DIR + CREW_LIB_PREFIX

if ENV['CREW_PREFIX'].to_s == ''
  HOME = ENV['HOME']
else
  HOME = CREW_PREFIX + ENV['HOME']
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

CREW_BUILD = `gcc -dumpmachine`
