require 'package'

class Oc < Package
  description 'Enterprise Kubernetes for Developers'
  homepage 'https://github.com/openshift/origin'
  version '3.11.0'
  license 'Apache-2.0'
  compatibility 'x86_64'
  source_url 'https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz'
  source_sha256 '4b0f07428ba854174c58d2e38287e5402964c9a9355f6c359d1242efd0990da3'

  def self.install
    system "install -Dm755 oc #{CREW_DEST_PREFIX}/bin/oc"
  end
end
