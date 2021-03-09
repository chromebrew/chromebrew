require 'package'

class Intel_vaapi_driver < Package
  description 'VA-API user mode driver for Intel GEN Graphics family'
  homepage 'https://github.com/intel/intel-vaapi-driver'
  compatibility 'i686, x86_64'
  @_ver = '2.4.1'
  version @_ver
  source_url "https://github.com/intel/intel-vaapi-driver/releases/download/#{@_ver}/intel-vaapi-driver-#{@_ver}.tar.bz2"
  source_sha256 '0081fce08eb3a83f7d99c3b853c8fdfa0af437b8f5b0fb7c66faeb83bcbe0c19'
  
  depends_on 'libva'
  
  def self.preflight
    abort 'Not an Intel processor, aborting.'.lightred unless Kernel.system("grep 'GenuineIntel' /proc/cpuinfo")
  end
  
  def self.build
    system "env CFLAGS='-pipe -fstack-protector-strong -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
            CXXFLAGS='-pipe -fstack-protector-strong -U_FORTIFY_SOURCE -flto=auto -fuse-ld=gold' \
            LDFLAGS='-fstack-protector-strong -U_FORTIFY_SOURCE -flto=auto' \
            ./configure #{CREW_OPTIONS}"
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
  
  def self.postinstall
    puts 'Performing env-setup'
    @_str = 'export LIBVA_DRIVER_NAME=i965'
    system "echo '#{@_str}' >> #{HOME}/.bashrc" if `grep -c '#{@_str}' #{HOME}/.bashrc`.to_i == 0
    puts
    puts 'To complete the installation, execute the following:'.lightblue
    puts 'source ~/.bashrc'.lightblue
    puts
  end
end