require 'package'

class Qpdf < Package
  description 'QPDF is a command-line program that does structural, content-preserving transformations on PDF files.'
  homepage 'http://qpdf.sourceforge.net/'
  version '11.1.1'
  license 'Apache-2.0 or Artistic-2'
  compatibility 'all'
  source_url 'https://github.com/qpdf/qpdf/archive/refs/tags/v11.1.1.tar.gz'
  source_sha256 '785edab622a1bc7e25e1537ad2c325005d48c5c7957f7abedff405deb80fa59a'
  binary_compression 'tar.zst'

  binary_url({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qpdf/11.1.1_armv7l/qpdf-11.1.1-chromeos-armv7l.tar.zst',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qpdf/11.1.1_armv7l/qpdf-11.1.1-chromeos-armv7l.tar.zst',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qpdf/11.1.1_i686/qpdf-11.1.1-chromeos-i686.tar.zst',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/qpdf/11.1.1_x86_64/qpdf-11.1.1-chromeos-x86_64.tar.zst'
  })
  binary_sha256({
    aarch64: '53a790ba153b2533d9384f3653830942fd87eac4f5f58b58d161a32af06d012c',
     armv7l: '53a790ba153b2533d9384f3653830942fd87eac4f5f58b58d161a32af06d012c',
       i686: 'd71562f7c38ea4a57274fc8d6d8a85bbc91feb19af8ffc1417f9a183d5b2dba6',
     x86_64: '36dde4a77f5bbad284e02f9ca7d684a36d6b03c97addfe7a7667711feb5fdecd'
  })

  depends_on 'libjpeg'
  depends_on 'gcc_lib' # R
  depends_on 'glibc' # R
  depends_on 'gnutls' # R
  depends_on 'openssl' # R
  depends_on 'zlibpkg' # R

  def self.build
    Dir.mkdir 'builddir'
    Dir.chdir 'builddir' do
      system "cmake -G Ninja \
        #{CREW_CMAKE_OPTIONS} \
        .."
    end
    system 'ninja -C builddir'
  end

  def self.install
    system "DESTDIR=#{CREW_DEST_DIR} ninja -C builddir install"
  end
end
