# Defines common constants used in different parts of crew

ARCH = `uname -m`.strip
ARCH_LIB = if ARCH == 'x86_64' then 'lib64' else 'lib' end

CREW_PREFIX = '/usr/local'
CREW_LIB_PREFIX = CREW_PREFIX + '/' + ARCH_LIB

CREW_LIB_PATH = CREW_PREFIX + '/lib/crew/'
CREW_CONFIG_PATH = CREW_PREFIX + '/etc/crew/'
CREW_BREW_DIR = CREW_PREFIX + '/tmp/crew/'
CREW_DEST_DIR = CREW_BREW_DIR + 'dest'
CREW_DEST_PREFIX = CREW_DEST_DIR + CREW_PREFIX
CREW_DEST_LIB_PREFIX = CREW_DEST_DIR + CREW_LIB_PREFIX

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

# Set XZ_OPT environment variable for build command.
# If CREW_XZ_OPT is defined, use it by default.  Use `-7e`, otherwise.
if ENV["CREW_XZ_OPT"].to_s == ''
  ENV["XZ_OPT"] = "-7e"
else
  ENV["XZ_OPT"] = ENV["CREW_XZ_OPT"]
end

USER = `whoami`.chomp
