require 'buildsystems/autotools'

class Xmlstarlet < Autotools
  description 'XMLStarlet is a command line XML toolkit which can be used to transform, query, validate, and edit XML documents and files using simple set of shell commands in similar way it is done for plain text files using grep/sed/awk/tr/diff/patch.'
  homepage 'https://xmlstar.sourceforge.net/'
  version '1.6.1'
  license 'MIT'
  compatibility 'all'
  source_url "https://downloads.sourceforge.net/project/xmlstar/xmlstarlet/#{version}/xmlstarlet-#{version}.tar.gz"
  source_sha256 '15d838c4f3375332fd95554619179b69e4ec91418a3a5296e7c631b7ed19e7ca'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: '16bc087a81954a1fb85bc0bba87fbb4a7ad82f6ced461ba73edacccb90b0c652',
     armv7l: '16bc087a81954a1fb85bc0bba87fbb4a7ad82f6ced461ba73edacccb90b0c652',
       i686: '0b32e2295e2ff530e5532d14adc4634e0ade37e27855e16973cd54dd8ad6bff2',
     x86_64: 'e6d96615719b3c47d0d6c558cd651dea02387af7baca0ab1cf8b22e8b6b6e221'
  })

  depends_on 'glibc' => :executable_only
  depends_on 'libxml2' => :executable_only
  depends_on 'libxslt' => :executable_only

  def self.patch
    system "sed -i 's, ATTRIBUTE_UNUSED,,g' src/xml_pyx.c"
  end

  autotools_install_extras do
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.ln_s "#{CREW_PREFIX}/bin/xml", "#{CREW_DEST_PREFIX}/bin/xmlstarlet"
  end
end
