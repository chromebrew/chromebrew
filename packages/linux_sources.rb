require 'package'

class Linux_sources < Package
  description 'Sources for the Linux kernel'
  homepage 'https://kernel.org/'
  # KERNEL_VERSION = %x[uname -r].chomp.reverse.split('.',2).collect(&:reverse)[1]
  case ARCH
  when 'aarch64', 'armv7l', 'x86_64'
    @_ver = '4.14'
    version @_ver
  when 'i686'
    @_ver = '3.8'
    version @_ver
  end
  # Only check for kernel version if not in container.
  unless File.exist?('/.dockerenv')
    @KERNEL_VERSION = `uname -r`.chomp.reverse.split('.', 2).collect(&:reverse)[1]
    @ver = @KERNEL_VERSION.between?(@KERNEL_VERSION, '5.15') ? @ver : @KERNEL_VERSION
    version @ver
  end
  license 'GPL-2'
  compatibility 'all'
  source_url 'https://chromium.googlesource.com/chromiumos/third_party/kernel.git'
  git_hashtag "chromeos-#{@_ver}"

  def self.install
    ENV['CREW_FHS_NONCOMPLIANCE_ONLY_ADVISORY'] = '1'
    warn_level = $VERBOSE
    $VERBOSE = nil
    load "#{CREW_LIB_PATH}lib/const.rb"
    $VERBOSE = warn_level
    linux_src_dir = "#{CREW_DEST_PREFIX}/src/linux"
    FileUtils.mkdir_p(linux_src_dir)
    FileUtils.rm_rf('.git')
    FileUtils.cp_r('.', linux_src_dir)
    Dir.chdir(linux_src_dir) do
      system 'make', 'defconfig'
    end
  end
end
