require 'package'

class Volume_key < Package
  description 'The volume_key project provides a libvolume_key, a library for manipulating
storage volume encryption keys and storing them separately from volumes, and an
associated command-line tool, named volume_key.'
  homepage 'https://pagure.io/volume_key'
  version '0.3.12'
  license 'GPL-2.0'
  compatibility 'all'
  source_url 'https://pagure.io/volume_key/archive/volume_key-0.3.12/volume_key-volume_key-0.3.12.tar.gz'
  source_sha256 '8b7941586b711859f568b01f44df87a23081a1c75f40c42b66af3fda10341180'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/volume_key/0.3.12_armv7l/volume_key-0.3.12-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/volume_key/0.3.12_armv7l/volume_key-0.3.12-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/volume_key/0.3.12_i686/volume_key-0.3.12-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/volume_key/0.3.12_x86_64/volume_key-0.3.12-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '695ed87d3a36c9581019c1d41e77b95d8ed98ee8d2c6dffbc2716de84db7616d',
     armv7l: '695ed87d3a36c9581019c1d41e77b95d8ed98ee8d2c6dffbc2716de84db7616d',
       i686: '20e139ecaca2f942c57a4723ff9571dca4c1e13a4fe1be175ff7bc5ce5b6a7ea',
     x86_64: 'bbe7a60ff113b743958e7ded0aff0fbbd2359a4a40354156c5ef1b25928908d4'
  })

  depends_on 'cryptsetup' => :build
  depends_on 'glib' => :build
  depends_on 'gpgme' => :build
  depends_on 'libbytesize' => :build
  depends_on 'nss' => :build
  depends_on 'swig' => :build

  def self.build
    system 'autopoint'
    system 'aclocal'
    system 'libtoolize'
    system 'autoconf'
    system 'autoheader'
    system 'automake --add-missing'
    system "./configure #{CREW_OPTIONS}"
    system 'make'
  end

  def self.install
    system "make install DESTDIR=#{CREW_DEST_DIR}"
  end
end
