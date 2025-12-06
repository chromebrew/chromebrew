require 'package'

class Antigravity < Package
  description 'Next-generation IDE from Google'
  homepage 'https://antigravity.google/'
  version '1.11.14'
  license 'Google Terms of Service'
  compatibility 'x86_64'
  min_glibc '2.28'
  source_url 'https://us-central1-apt.pkg.dev/projects/antigravity-auto-updater-dev/pool/antigravity-debian/antigravity_1.11.14-1764918088_amd64_acf73c2fd8e096dca6a2d5535d58efc5.deb'
  source_sha256 '67138611cf331f8186b1a013856a9823a7a9bfd2b1243290103f2b66917ae49c'

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
