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
     x86_64: 'https://dl.bintray.com/chromebrew/chromebrew/oc-3.7.0-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
     x86_64: '3243a878b6ba2c52888c633c29b95ac07bb63ec6704e90e849a6e6d463c0d1bc',
  })

  def self.install
    system "install -Dm755 oc #{CREW_DEST_PREFIX}/bin/oc"
  end
end
