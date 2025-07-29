require 'package'

class Recomod < Package
  description 'a cros recovery image modification toolkit'
  homepage 'https://github.com/MercuryWorkshop/RecoMod'
  version '84586f8'
  license 'GPL-3.0'
  compatibility 'all'
  source_url 'https://github.com/MercuryWorkshop/RecoMod.git'
  git_hashtag '84586f828903eaa27d30ef24fde5d7a30460012f'

  no_compile_needed
  no_shrink

  def self.patch
    patch = [
      # Fix directory bug.
      ['https://patch-diff.githubusercontent.com/raw/MercuryWorkshop/RecoMod/pull/73.diff',
       '012f7dd27e0bce23c91320881c2440870d089da486e8bcd1eee382952c050ef6']
    ]
    ConvenienceFunctions.patch(patch)
    system "sed -i '2,4d' recomod.sh"
    system "sed -i '2i. \"#{CREW_PREFIX}/share/recomod/lib/common_minimal.sh\"' recomod.sh"
    system "sed -i 's,\${SCRIPT_DIR},#{CREW_PREFIX}/share/recomod,g' recomod.sh"
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/recomod"
    FileUtils.mv Dir['*'], "#{CREW_DEST_PREFIX}/share/recomod"
    FileUtils.ln_s "#{CREW_PREFIX}/share/recomod/recomod.sh", "#{CREW_DEST_PREFIX}/bin/recomod"
  end

  def self.postinstall
    ExitMessage.add "\nType 'recomod' to get started.\n"
  end
end
