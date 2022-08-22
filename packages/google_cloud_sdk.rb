require 'package'

class Google_cloud_sdk < Package
  description 'Command-line interface for Google Cloud Platform products and services'
  homepage 'https://cloud.google.com/sdk/gcloud/'
  version '370.0.0'
  license 'Apache-2.0'
  compatibility 'i686,x86_64'

  depends_on 'gcloud'

  is_fake
end
