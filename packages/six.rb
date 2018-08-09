require 'package'

class Six < Package
  description 'Six is a Python 2 and 3 compatibility library.'
  homepage 'https://github.com/benjaminp/six'
  version '1.11.0'
  source_url 'https://github.com/skycocker/chromebrew/raw/cc4f47007b6fe702e03de28347e20d3a0bb692f6/install.sh'
  source_sha256 'bf141178609cfbb130b611b0d38c28f07360fde829100ef6a047db19fe1fb593'

  binary_url ({
  })
  binary_sha256 ({
  })

  depends_on 'python3'
  depends_on 'python27'

  def self.install
    system "pip install six --upgrade --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
    system "pip3 install six --upgrade --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR}"
  end
end
