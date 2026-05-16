require 'package'

class Photogimp < Package
  description 'A Patch for GIMP 3+ for Photoshop Users'
  homepage 'https://photogimp.com/'
  version '3.0'
  license 'GPL-3.0'
  compatibility 'aarch64 armv7l x86_64'
  source_url "https://github.com/Diolinux/PhotoGIMP/releases/download/#{version}/PhotoGIMP-linux.zip"
  source_sha256 '1af6e2a6308bbc0fb716a7dbbd68036adbcc091da16432869c7c6c6aef18e54e'

  depends_on 'gimp' => :logical
  depends_on 'xdg_base' => :logical

  no_compile_needed
  no_fhs

  def self.install
    FileUtils.mkdir_p CREW_DEST_PREFIX
    FileUtils.mv '.config', CREW_DEST_PREFIX
    # Get rid of the MacOS specific files.
    system 'find .local/ -name .DS_Store -exec rm {} +'
    FileUtils.mv '.local/share', CREW_DEST_PREFIX
  end

  def self.postinstall
    ExitMessage.add "\nType 'gimp' to launch PhotoGIMP.\n"
  end
end
