require 'package'

class Libaacs < Package
  description 'This library is simply a tool for playback of Blu-ray movies.'
  homepage 'https://www.videolan.org/developers/libaacs.html'
  version '0.11.1'
  license 'LGPL-2.1'
  compatibility 'all'
  source_url 'https://get.videolan.org/libaacs/0.11.1/libaacs-0.11.1.tar.bz2'
  source_sha256 'a88aa0ebe4c98a77f7aeffd92ab3ef64ac548c6b822e8248a8b926725bea0a39'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '2bd87cccd1d123aa642b3d187c94bd2180f78be9f14f9d5e719fdfa324f54fef',
     armv7l: '2bd87cccd1d123aa642b3d187c94bd2180f78be9f14f9d5e719fdfa324f54fef',
       i686: 'cc86d5ba4511da7a799bb329b26b98d6581ba730b210d007cd31b76b944a1066',
     x86_64: '3b9647d110d372cb587a982094e3cdf08e91b680ef00fd2533be16263c3368e6'
  })

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--disable-maintainer-mode'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
