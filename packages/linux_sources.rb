require 'package'

class Linux_sources < Package
  description 'Sources for the Linux kernel'
  homepage 'https://kernel.org/'
  version '4.14'
  compatibility 'all'
  source_url 'https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz'
  source_sha256 'f81d59477e90a130857ce18dc02f4fbe5725854911db1e7ba770c7cd350f96a7'

  binary_url ({
    aarch64: 'https://dl.bintray.com/chromebrew/chromebrew/linux_sources-4.14-chromeos-armv7l.tar.xz',
     armv7l: 'https://dl.bintray.com/chromebrew/chromebrew/linux_sources-4.14-chromeos-armv7l.tar.xz',
       i686: 'https://dl.bintray.com/chromebrew/chromebrew/linux_sources-4.14-chromeos-i686.tar.xz',
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/linux_sources-4.14-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '7dfea20067015e59a2b4b1006b0beddaa6873a01470cee8007647d990da5bf57',
     armv7l: '7dfea20067015e59a2b4b1006b0beddaa6873a01470cee8007647d990da5bf57',
       i686: 'fae80d1d113eb4e2d9bc84daee4b398c2064730234df74b09edfc85fb9a696b4',
     x86_64: '3051229ae81224a038795eecd6d21dfd9dad2c5f8711137016bb8a4bb28852c9',
  })

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
