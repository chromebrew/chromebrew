require 'package'

class Antigravity < Package
  description 'Next-generation IDE from Google'
  homepage 'https://antigravity.google/'
  version '1.13.3'
  license 'Google Terms of Service'
  compatibility 'x86_64'
  min_glibc '2.28'
  # To display this url, the latest Debian package must be installed and then run 'apt download --print-uris antigravity'
  source_url 'https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/pool/antigravity-debian/antigravity_1.13.3-1766182170_amd64_365061c50063f9bd47a9ff88432261b8.deb'
  source_sha256 'd9920f9e0788245b1dab0f73a607b4eea00605bfb70e16795da1c1ac89eabd4b'

  no_compile_needed

  depends_on 'sommelier'

  def self.preflight
    # Need at least 1.4 gb of free disk space to install.
    MiscFunctions.check_free_disk_space(1468006400)
  end

  def self.install
    FileUtils.mkdir_p "#{CREW_DEST_PREFIX}/bin"
    FileUtils.mv 'share', CREW_DEST_PREFIX
    FileUtils.ln_s "#{CREW_PREFIX}/share/antigravity/bin/antigravity", "#{CREW_DEST_PREFIX}/bin/antigravity"
  end

  def self.postremove
    Package.agree_to_remove("#{HOME}/.antigravity")
    Package.agree_to_remove("#{HOME}/.gemini")
    Package.agree_to_remove("#{CREW_PREFIX}/.config/Antigravity")
  end
end
