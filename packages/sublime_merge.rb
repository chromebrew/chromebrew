require 'package'

class Sublime_merge < Package
  description 'A snappy UI, three-way merge tool,side-by-side diffs, syntax highlighting, and more.'
  homepage 'https://www.sublimemerge.com/'
  version 'Build 2096'
  license 'Copyright Sublime HQ Pty Ltd' # Shareware for evaluation purposes only.  Source code is not available.
  compatibility 'x86_64'
  source_url "https://download.sublimetext.com/sublime_merge_build_#{version.split.last}_x64.tar.xz"
  source_sha256 'e3523aa79c0dc76a45e7a9e9ee01eaa77f7a447a57b50bb9aee92c532c05fd48'

  depends_on 'sommelier'

  no_compile_needed

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/share/sublime_merge"
    FileUtils.cp_r '.', "#{CREW_DEST_PREFIX}/share/sublime_merge/"
    FileUtils.ln_s "#{CREW_PREFIX}/share/sublime_merge/sublime_merge", "#{CREW_DEST_PREFIX}/bin/sublime_merge"
  end

  def self.postinstall
    ExitMessage.add "\nType 'sublime_merge' to get started.\n".lightblue
  end
end
