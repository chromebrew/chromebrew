require 'package'

class Linux_sources < Package
  description 'Sources for the Linux kernel'
  homepage 'https://kernel.org/'
  version '3.18'
  source_url 'https://www.kernel.org/pub/linux/kernel/v3.x/linux-3.18.tar.xz'
  source_sha256 'becc413cc9e6d7f5cc52a3ce66d65c3725bc1d1cc1001f4ce6c32b69eb188cbd'

  def self.install
    linux_src_dir = CREW_DEST_PREFIX + '/src/linux'
    FileUtils.mkdir_p(linux_src_dir)
    FileUtils.cp_r('.', linux_src_dir)
    Dir.chdir(linux_src_dir) do
      system 'make', 'defconfig'
    end
  end
end
