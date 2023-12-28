require 'package'

class Libewf < Package
  description 'Libewf is a library to access the Expert Witness Compression Format (EWF)'
  homepage 'https://github.com/libyal/libewf'
  version '20171104'
  license 'LGPL-3'
  compatibility 'all'
  source_url 'https://github.com/libyal/libewf/releases/download/20171104/libewf-experimental-20171104.tar.gz'
  source_sha256 'cf36d3baf3a96dbe566fde55ae7d79fc2e7b998806ab13e0f69915799f19e040'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libewf/20171104_armv7l/libewf-20171104-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libewf/20171104_armv7l/libewf-20171104-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libewf/20171104_i686/libewf-20171104-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/libewf/20171104_x86_64/libewf-20171104-chromeos-x86_64.tar.xz'
  })
  binary_sha256({
    aarch64: 'fdd4e2e098bd07486158fda5f5cc9ab4ed02ed2f39b1201af889fba500b84ab1',
     armv7l: 'fdd4e2e098bd07486158fda5f5cc9ab4ed02ed2f39b1201af889fba500b84ab1',
       i686: 'ddfbfe29f3989c17414fd1a1d8ce50b3619ca8ccbab8bac8632a33adb107d81e',
     x86_64: '383f9c811cddf2c957588c265f7fb31075a4b3fce94e6c4d324f1fd1dd31fc13'
  })

  depends_on 'bzip2'
  depends_on 'py3_six'
  depends_on 'util_linux'

  def self.build
    system './configure',
           "--prefix=#{CREW_PREFIX}",
           "--libdir=#{CREW_LIB_PREFIX}",
           '--enable-python',
           '--enable-python3',
           '--enable-wide-character-type'
    system 'make'
  end

  def self.install
    system 'make', "DESTDIR=#{CREW_DEST_DIR}", 'install'
  end
end
