require 'package'

class Storm < Package
  description 'Manage your SSH like a boss.'
  homepage 'http://stormssh.readthedocs.org/en/master/'
  version '0.6.9'
  source_url 'https://github.com/emre/storm/archive/0.6.9.tar.gz'
  source_sha1 'ebc82a5ab77039de16e3ca0d7df6e24ff1950927'

  depends_on 'pip'

  def self.install
    system "mkdir -p #{CREW_DEST_DIR}/usr/local/bin"
    system "pip install stormssh --prefix=/usr/local"
    system "cp /usr/local/bin/storm #{CREW_DEST_DIR}/usr/local/bin"
  end
end
