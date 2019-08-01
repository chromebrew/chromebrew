require 'package'

class Linux_sources < Package
  description 'Sources for the Linux kernel'
  homepage 'https://kernel.org/'
  version '4.14'
  source_url 'https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz'
  source_sha256 'f81d59477e90a130857ce18dc02f4fbe5725854911db1e7ba770c7cd350f96a7'

  def self.install
    linux_src_dir = CREW_DEST_PREFIX + '/src/linux'
    pdir = 'chromiumos-overlay/sys-kernel/linux-headers/files'
    # Download Linux kernel header patches
    system 'git', 'clone', '--depth=1', '-b', 'release-R75-12105.B',
           'https://chromium.googlesource.com/chromiumos/overlays/chromiumos-overlay.git'
    # Remove a/ and b/ path prefixes on patches so they can be applied with -Np0
    system "sed -i -e 's,a/,,g' -e 's,b/,,g' #{pdir}/*.patch"
    system "for file in #{pdir}/*.patch; do patch -Np0 -i \${file}; done"
    # Remove Chromium OS overlay so it isn't included in the source tree
    FileUtils.rm_rf 'chromiumos-overlay'
    FileUtils.mkdir_p(linux_src_dir)
    FileUtils.cp_r('.', linux_src_dir)
    Dir.chdir(linux_src_dir) do
      system 'make', 'defconfig'
    end
  end
end
