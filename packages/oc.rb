require 'package'

class Oc < Package
  description 'Enterprise Kubernetes for Developers'
  homepage 'https://github.com/openshift/origin'
  version '3.7.0'
  case ARCH
  when 'x86_64'
    source_url 'https://github.com/openshift/origin/releases/download/v3.7.0/openshift-origin-client-tools-v3.7.0-7ed6862-linux-64bit.tar.gz'
    source_sha256 '573e39965633671aac08d68f57d66ff182fb646649523914f0a60debb6515eba'
  else
    puts 'Architecture not supported.  The only available platform is x86_64.'.lightred
  end

  binary_url ({
  })
  binary_sha256 ({
  })

  def self.install
    system "install -Dm755 oc #{CREW_DEST_PREFIX}/bin/oc"
  end
end
