require 'package'

class Antigravity < Package
  description 'Next-generation IDE from Google'
  homepage 'https://antigravity.google/'
  version '1.11.17'
  license 'Google Terms of Service'
  compatibility 'x86_64'
  min_glibc '2.28'
  # To display this url, the latest Debian package must be installed and then run 'apt download --print-uris antigravity'
  source_url 'https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/pool/antigravity-debian/antigravity_1.11.17-1765244408_amd64_9df0712156d4f7f37ea353feaa9633ca.deb'
  source_sha256 'f5b61a4d00354f846e8850a2da9e87b7e204298f0f5cfa0365ede7207c7fc897'

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
