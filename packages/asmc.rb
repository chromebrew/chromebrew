require 'package'

class Asmc < Package
  description 'Asmc Macro Assembler'
  homepage 'https://github.com/nidud/asmc'
  license 'GPL-2.0'
  @_commit = '3663995a73c333742c6c3bd022ba7ba33e4f5155'
  version "2.33.27-#{@_commit[0..6]}"
  compatibility 'all'
  source_url "https://github.com/nidud/asmc/raw/#{@_commit}/bin/asmc"
  source_sha256 '90d227fa76ceba80da6aa63e90b945577daf7c13d93c3a08b76b9d488875d4a0'
  binary_compression 'tar.zst'

  binary_sha256({
    aarch64: 'dda205aeddb6e8c0aa09f12bdb3e5c6908351a3d2528ceb0286e518efb025c73',
     armv7l: 'dda205aeddb6e8c0aa09f12bdb3e5c6908351a3d2528ceb0286e518efb025c73',
       i686: 'a05c421ca0ec71712bb00ea1d1e6d06882b723a073167fd67162c3a92a6445f2',
     x86_64: '56057ed91a1edb20cb0c6c6a91022f84a5871d345cde35f066b73a20a70b2ee0'
  })

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'asmc', "#{CREW_DEST_PREFIX}/bin/asmc", mode: 0o755
  end
end
