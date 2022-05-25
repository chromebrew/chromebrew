require 'package'

class Libdmraid < Package
  description 'Device-Mapper Software RAID support tool'
  homepage 'http://people.redhat.com/~heinzm/sw/dmraid/'
  version '1.0.0.rc16-3'
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'http://people.redhat.com/~heinzm/sw/dmraid/src/dmraid-1.0.0.rc16-3.tar.bz2'
  source_sha256 '93421bd169d71ff5e7d2db95b62b030bfa205a12010b6468dcdef80337d6fbd8'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdmraid/1.0.0.rc16-3_armv7l/libdmraid-1.0.0.rc16-3-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdmraid/1.0.0.rc16-3_armv7l/libdmraid-1.0.0.rc16-3-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdmraid/1.0.0.rc16-3_i686/libdmraid-1.0.0.rc16-3-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libdmraid/1.0.0.rc16-3_x86_64/libdmraid-1.0.0.rc16-3-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: 'bf6a85cf7fada37b4c6eaf3e20bc029b478ac150910f5b621baa8c5190c098d3',
     armv7l: 'bf6a85cf7fada37b4c6eaf3e20bc029b478ac150910f5b621baa8c5190c098d3',
       i686: '960b0acb4d557f5d3768e7323f4472e75439dc9f240753a3a62aec27e6843223',
     x86_64: '826735e71f3ffc850583862bb58d46369170d7f945efd14406c4bcef8865c428'
  })

  depends_on 'gawk' => :build
  depends_on 'lvm2' => :build

  def self.build
    Dir.chdir '1.0.0.rc16-3/dmraid' do
      system 'autoreconf -fvi'
      system "./configure #{CREW_OPTIONS}"
      system 'make || make'
    end
  end

  def self.install
    Dir.chdir '1.0.0.rc16-3/dmraid' do
      system "make install DESTDIR=#{CREW_DEST_DIR}"
    end
  end
end
