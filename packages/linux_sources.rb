require 'package'

class Linux_sources < Package
  description 'Sources for the Linux kernel'
  homepage 'https://kernel.org/'
  version '0.1'
  source_url 'file:///dev/null'
  source_sha256 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'

  # No binaries for this package for these reasons:
  # 1. The package purely downloads sources, no compiling involved
  # 2. The linux kernel version may be different for different Chromebooks

  @uname_r = `uname -r | cut -d- -f1`.chomp
  @uname_r = `echo #{@uname_r} | cut -d. -f-2`.chomp if `echo #{@uname_r} | cut -d. -f3`.chomp == '0'

  def self.build
    major = `echo #{@uname_r} | cut -d. -f1`.chomp
    system "wget", "https://kernel.org/pub/linux/kernel/v#{major}.x/linux-#{@uname_r}.tar.xz"
    system "wget", "https://kernel.org/pub/linux/kernel/v#{major}.x/sha256sums.asc"
    system "sha256sum", "-c", "sha256sums.asc", "--ignore-missing"
  end

  def self.install
    case ARCH
    when 'x86_64', 'x86'
      arch = 'x86'
    when 'armv7l', 'aarch64'
      arch = 'arm'
    end
    linux_src_dir = CREW_DEST_PREFIX + "/src/linux"
    FileUtils.mkdir_p linux_src_dir
    system "tar", "xpf", "linux-#{@uname_r}.tar.xz", "--strip-components=1", "-C", "#{linux_src_dir}"
    Dir.chdir(linux_src_dir) do
      system "sudo", "modprobe", "configs"
      system 'make',
             'headers_install',
             "INSTALL_HDR_PATH=#{CREW_DEST_PREFIX}",
             "HOSTCC=gcc -I#{linux_src_dir}/include/uapi -I#{linux_src_dir}/arch/#{arch}/include/uapi"
      system "for file in \$(find #{CREW_DEST_PREFIX}/include -name \'.*\'); do
                rm -f \${file}
              done"
      system "zcat /proc/config.gz | tee .config >/dev/null"
      system "yes '' | make oldconfig HOSTCC='gcc -I#{CREW_DEST_PREFIX}/include'"
    end
  end
end
