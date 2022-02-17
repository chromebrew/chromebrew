require 'package'

class Asmc < Package
  description 'Asmc Macro Assembler'
  homepage 'https://github.com/nidud/asmc'
  compatibility 'x86_64, i686'
  license 'GPL-2.0'

  @_commit = '3663995a73c333742c6c3bd022ba7ba33e4f5155'
  version "2.33.27-#{@_commit[0..6]}"
  source_url "https://github.com/nidud/asmc/raw/#{@_commit}/bin/asmc"
  source_sha256 '90d227fa76ceba80da6aa63e90b945577daf7c13d93c3a08b76b9d488875d4a0'

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.install 'asmc', "#{CREW_DEST_PREFIX}/bin/asmc", mode: 0o755
  end
end