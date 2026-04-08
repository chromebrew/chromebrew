require 'package'

class Asmc < Package
  description 'Asmc Macro Assembler'
  homepage 'https://github.com/nidud/asmc'
  license 'GPL-2.0'
  @_commit = 'c3789a9cafd0548fa1777b1c61ce3bd2edaeb253'
  version "2.37.92-#{@_commit[0..6]}"
  compatibility 'all'
  source_url "https://github.com/nidud/asmc/raw/#{@_commit}/bin/asmc"
  source_sha256 'fb654cb5d3538267c8b46774126b2a32044008e1b6eff1d824667f7893c72bf2'

  no_compile_needed

  def self.install
    FileUtils.install 'asmc', "#{CREW_DEST_PREFIX}/bin/asmc", mode: 0o755
  end
end
