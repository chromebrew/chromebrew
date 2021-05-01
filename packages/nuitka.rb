require 'package'

class Nuitka < Package
  description 'nuitka is a Python to binary compiler written in Python. You feed it your Python app, it does a lot of clever things, and spits out an executable or extension module.'
  homepage 'https://nuitka.net/'
  version '0.6.13.2'
  license 'Apache-2.0'
  compatibility 'all'
  source_url 'https://github.com/Nuitka/Nuitka/archive/refs/tags/0.6.13.2.tar.gz'
  source_sha256 'a594d054255688dbef8f8ba5b6cbb0207ad467384f2a6214522781ffbd5d43e5'

  binary_url ({
    aarch64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nuitka/0.6.13.2_armv7l/nuitka-0.6.13.2-chromeos-armv7l.tar.xz',
     armv7l: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nuitka/0.6.13.2_armv7l/nuitka-0.6.13.2-chromeos-armv7l.tar.xz',
       i686: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nuitka/0.6.13.2_i686/nuitka-0.6.13.2-chromeos-i686.tar.xz',
     x86_64: 'https://gitlab.com/api/v4/projects/26210301/packages/generic/nuitka/0.6.13.2_x86_64/nuitka-0.6.13.2-chromeos-x86_64.tar.xz',
  })
  binary_sha256 ({
    aarch64: '30d982517d09101767cfb71f7e579b0dd8b0636ce2e922ccd7d2a3eec93f0e26',
     armv7l: '30d982517d09101767cfb71f7e579b0dd8b0636ce2e922ccd7d2a3eec93f0e26',
       i686: '31d41f49b3caea88732e590ef269a17233f8cbc8298e50d9e89e7e8daae44889',
     x86_64: '19333abe43c61a1fb3907ab6d4e63532dc9ddc7917b2cfa0c790a21bb89117e1',
  })

  def self.install
    system "python3 -m pip install --prefix #{CREW_PREFIX} --root #{CREW_DEST_DIR} -I nuitka==#{version} --no-warn-script-location"
  end
end
